//
//  UIView+AutoLayoutCore.m
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import "UIView+XHSSAutoLayoutCore.h"
#import "UIView+XHSSAutoLayoutSizeUtils.h"
#import "UIView+XHSSAutoLayoutPointAndValueUtils.h"
#import "UIView+XHSSAutoLayoutFrameUtils.h"
#import "UIView+XHSSAutoLayoutCoreUtils.h"


#define kXHSSAssert(Condition, Description) \
        NSAssert(Condition, @"\n"" ****************************************\n""     File: %s \n""     LineNum: %d \n ""    Desc: %@ \n ""    CurrentView: %@ \n ""    ParentView: %@ \n ""****************************************\n",\
             __FILE_NAME__, __LINE__, Description, self, self.superview);


@implementation UIView (AutoLayoutCore)

- (void)xhss_PerformAutoLayout {
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_VerticleFlow: {
            [self __xhss_PerformFlowLayout];
        } break;
        case XHSSLayoutType_Row:
        case XHSSLayoutType_Column: {
            [self __xhss_preSigleLineFlexLayout];
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
}


#pragma mark - Flow Layout
/**
 多行/多列 布局
 */
- (void)__xhss_PerformFlowLayout {
    [self __xhss_CheckLayoutAvailable];
                    
    CGFloat allowSpace = kXHSS_ALLOW_LAYOUT_SPACE;
    
    // 横向布局需要先确定自身的宽度，如果有固定宽度则用固定宽度，如果宽度不固定则使用父视图的基本宽度
    // 纵向布局需要先确定自身的高度，如果有固定高度则用固定高度，如果高度不固定则使用父视图的基本高度
    CGFloat fixedLengthWithPading = [self __xhss_fixedLength];
    
    // 所有子视图的 frame 缓存，用来调整最终布局状态
    NSMutableArray<NSValue*>* subviewFramesCache = [NSMutableArray array];
    
    // 主方向
    CGFloat currentMainAxisTotalLength = 0;
    NSMutableArray<NSValue*>* toBeLayoutViewFrames = [NSMutableArray array];
    
    // 副方向
    CGFloat crossAxisLayoutStart = [self __xhss_crossAxisLayoutStart];
    CGFloat nextCrossAxisLayoutStart = crossAxisLayoutStart;
    
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    BOOL needFinishCurrentLayout = NO;
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    
    int index = 0;
    while (index < self.subviews.count) {
        UIView* subView = self.subviews[index];
        CGSize subViewSize = [subView __xhss_PreLayoutSizeWithMargin];
        CGFloat subviewLengthInMainAxis = [self __xhss_lengthOfViewSize:subViewSize
                                                             isMainAxis:YES];
        CGFloat preMainAxisTotalLength = currentMainAxisTotalLength +subviewLengthInMainAxis;
        
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        needFinishCurrentLayout = NO;
        
        // 布局数据无效
        if (![self __xhss_isViewLayoutAvailable:subView]) {
            [subviewFramesCache addObject:@(CGRectZero)];
            index++;
            continue;
        }
        
        
        CGFloat mainAxisLayoutLength = 0;
        switch (self.mainLayoutType) {
            case XHSSLayoutType_HorizontalFlow:
            case XHSSLayoutType_Row: {
                mainAxisLayoutLength = subView.layoutWidth;
            } break;
            case XHSSLayoutType_VerticleFlow:
            case XHSSLayoutType_Column: {
                mainAxisLayoutLength = subView.layoutHeight;
            } break;
            default:
                break;
        }
        
        // 如果没给具体长度，并且没指定缩放权重，则忽略不处理
        if (mainAxisLayoutLength == 0 && subView.layoutFlex == 0) {
            // 1. width/height=0 & flex=0 ，则忽略这个 subview
            [subviewFramesCache addObject:@(CGRectZero)];
            index++;
            continue;
        }
        // 如果给了具体长度，按照不需要缩放处理
        else if (mainAxisLayoutLength > 0) {
            // 2. width>0, flex=0 表示常规布局
            // 无需处理，继续执行程序
        }
        // 如果给了具体长度，并且指定了缩放权重，则进行缩放处理
        else if (subView.layoutFlex > 0) {
            // 3. width/height=0, flex>0 表示使用自动缩放
            
            // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            // 1.是当前行第一个 subview
            if (toBeLayoutViewFrames.count == 0) {
                // 1.3. 当前 subview 是最后一个 subview，则放在当前行适应父视图宽度
                if (index+1 >= self.subviews.count) {
                    // 【高度如果没有给出，并且没有设置宽高比，默认等于宽度】
                    CGFloat mainAxisLength = fixedLengthWithPading;
                    CGFloat crossAxisLength = [self __xhss_crossAxisLayoutLengthOfView:subView
                                                              withMainAxisLayoutLength:mainAxisLength];
                    CGRect flexFrame = [self __xhss_refLayoutFrameWithMainAxisLength:mainAxisLength
                                                                     crossAxisLength:crossAxisLength];
                    [toBeLayoutViewFrames addObject:@(flexFrame)];
                    //[subviewFramesCache addObject:@(flexFrame)];
                    
                    nextCrossAxisLayoutStart = MAX(nextCrossAxisLayoutStart,
                                                   crossAxisLayoutStart +crossAxisLength);
                    index++;
                    
                    // 标记当前行布局需要结束
                    needFinishCurrentLayout = YES;
                    //continue;
                }
                // 1.3. 当前 subview 不是最后一个 subview
                else {
                    UIView* nextSubview = self.subviews[index+1];
                    // 1.1. 后面还有连续的 flexableSubview，则当前连续的 flexableSubview 一起放在当前一行自适应布局
                    if ([self __xhss_ifViewNeedFlexLayout:nextSubview]) {
                        // 找到后续的连续 flexableSubview
                        CGFloat totalFlexValue = 0;
                        NSMutableArray<UIView*>* flexSubviews = [NSMutableArray array];
                        int startIdx = index;
                        for ( ; startIdx < self.subviews.count; startIdx++) {
                            UIView* nextFlexSubview = self.subviews[startIdx];
                            if ([self __xhss_ifViewNeedFlexLayout:nextFlexSubview]) {
                                [flexSubviews addObject:nextFlexSubview];
                                totalFlexValue += nextFlexSubview.layoutFlex;
                            } else {
                                break;
                            }
                        }
                        // 对整行的 flexableSubview 进行布局
                        for (NSUInteger idx=0; idx<flexSubviews.count; idx++) {
                            UIView* oneFlexSubview = flexSubviews[idx];
                            // 【高度如果没有给出，并且没有设置宽高比，默认等于宽度】
                            CGFloat mainAxisLength = fixedLengthWithPading * (oneFlexSubview.layoutFlex/totalFlexValue);
                            CGFloat crossAxisLength = [self __xhss_crossAxisLayoutLengthOfView:oneFlexSubview
                                                                      withMainAxisLayoutLength:mainAxisLength];
                            CGRect flexFrame = [self __xhss_refLayoutFrameWithMainAxisLength:mainAxisLength
                                                                             crossAxisLength:crossAxisLength];
                            [toBeLayoutViewFrames addObject:@(flexFrame)];
                            //..[subviewFramesCache addObject:@(flexFrame)];
                            
                            nextCrossAxisLayoutStart = MAX(nextCrossAxisLayoutStart,
                                                           crossAxisLayoutStart +crossAxisLength);
                        }
                        
                        index = startIdx;
                        // 标记当前行布局需要结束
                        needFinishCurrentLayout = YES;
                    }
                    // 1.2. 只有当前一个 flexableSubview，则和后面的固定 width subview 放在同一行，后面固定 width subview 的选择方案：(父视图宽度) - (所有选中的固定 width subview 的布局宽度和) >= 某个值
                    else {
                        CGFloat mainAxisAvailableLength = (fixedLengthWithPading -allowSpace);
                        CGFloat mainAxisTotalLength = 0;
                        for (int startIdx = index+1 ; startIdx<self.subviews.count; startIdx++) {
                            UIView* oneView = self.subviews[startIdx];
                            if ([self __xhss_ifViewNeedFlexLayout:oneView]) {
                                // 标记当前行布局需要结束
                                needFinishCurrentLayout = YES;
                                break;
                            }
                            CGFloat preMainAxisTotalLength = 0;
                            switch (self.mainLayoutType) {
                                case XHSSLayoutType_HorizontalFlow:
                                case XHSSLayoutType_Row: {
                                    preMainAxisTotalLength = mainAxisTotalLength +[oneView __xhss_PreLayoutSizeWithMargin].width;
                                } break;
                                case XHSSLayoutType_VerticleFlow:
                                case XHSSLayoutType_Column: {
                                    preMainAxisTotalLength = mainAxisTotalLength +[oneView __xhss_PreLayoutSizeWithMargin].height;
                                } break;
                                default:
                                    break;
                            }
                            
                            if (preMainAxisTotalLength <= mainAxisAvailableLength) {
                                mainAxisTotalLength = preMainAxisTotalLength;
                            } else {
                                break;
                            }
                        }
                        
                        
                        CGFloat flexLength = (fixedLengthWithPading -mainAxisTotalLength);
                        currentMainAxisTotalLength += flexLength;
                        // 【高度如果没有给出，并且没有设置宽高比，默认等于宽度】
                        CGFloat mainAxisLength = flexLength;
                        CGFloat crossAxisLength = [self __xhss_crossAxisLayoutLengthOfView:subView
                                                                  withMainAxisLayoutLength:mainAxisLength];
                        CGRect flexFrame = [self __xhss_refLayoutFrameWithMainAxisLength:mainAxisLength
                                                                         crossAxisLength:crossAxisLength];
                        [toBeLayoutViewFrames addObject:@(flexFrame)];
                        
                        // 确定下一行/列布局的起始高度
                        CGFloat subviewLengthInCrossAxis = crossAxisLength;
                        nextCrossAxisLayoutStart = MAX(nextCrossAxisLayoutStart,
                                                       crossAxisLayoutStart +subviewLengthInCrossAxis);
                                    
                        index++;
                        
                        continue;
                    }
                }
            }
            // 2.不是当前行第一个 subview
            else {
                // 2.1. 当前行所剩空间 >= 某个值，则将这个 flexableSubview 放在当前行尾适应父视图宽度
                if ((fixedLengthWithPading -currentMainAxisTotalLength) >= allowSpace) {
                    CGFloat mainAxisLength = (fixedLengthWithPading -currentMainAxisTotalLength);
                    CGFloat crossAxisLength = [self __xhss_crossAxisLayoutLengthOfView:subView
                                                              withMainAxisLayoutLength:mainAxisLength];
                    CGRect flexFrame = [self __xhss_refLayoutFrameWithMainAxisLength:mainAxisLength
                                                                     crossAxisLength:crossAxisLength];
                    [toBeLayoutViewFrames addObject:@(flexFrame)];
                    
                    // 确定下一行/列布局的起始高度
                    CGFloat subviewLengthInCrossAxis = crossAxisLength;
                    nextCrossAxisLayoutStart = MAX(nextCrossAxisLayoutStart,
                                                   crossAxisLayoutStart +subviewLengthInCrossAxis);
                                
                    index++;
                    
                    // 标记当前行布局需要结束
                    needFinishCurrentLayout = YES;
                    //..continue;
                }
                // 2.2. 当前行所剩空间 < 某个值，则将这个 flexableSubview 放在下一行并结束当前行布局
                else {
                    // 标记当前行布局需要结束，开始下一行布局即可处理这种情况
                    needFinishCurrentLayout = YES;
                }
            }
            // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        }
        // 给了具体长度，并且给了缩放权重，按照给定具体长度处理
        else {
            // 4. width/height>0, flex>0，则需要确定 width/height 优先还是 flex 优先【默认 width/height 优先级高，如果设置 width/height 则忽略 flex 】
            // 同 mainAxisLayoutLength > 0 的情况，无需处理
        }
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                
        // ** 寻找整行可以容纳的子视图
        // 本列内空间可以容纳当前子视图
        if ((preMainAxisTotalLength <= fixedLengthWithPading || [self __xhss_isSingleLineLayout])
            && !needFinishCurrentLayout) {
            
            currentMainAxisTotalLength += subviewLengthInMainAxis;
            [toBeLayoutViewFrames addObject:@(CGRectMake(0,
                                                         0,
                                                         subViewSize.width,
                                                         subViewSize.height))];
            
            // 确定下一列布局的起始高度
            CGFloat subviewLengthInCrossAxis = [self __xhss_lengthOfViewSize:subViewSize
                                                                  isMainAxis:NO];
            nextCrossAxisLayoutStart = MAX(nextCrossAxisLayoutStart,
                                           crossAxisLayoutStart +subviewLengthInCrossAxis);
                        
            index++;
        }
        
        // ** 计算生成整行的子视图布局 frame 信息
        if (((preMainAxisTotalLength > fixedLengthWithPading || (index == self.subviews.count))
            || ((index == self.subviews.count) && [self __xhss_isSingleLineLayout]))
            /*&& !needFinishCurrentLayout*/
            || needFinishCurrentLayout) {
            
            if ([self __xhss_isSingleLineLayout] && (index != self.subviews.count)) {
                continue;
            }
            
            
            // ** 计算布局
            [self __xhss_generateFramesToSubviewFramesCache:subviewFramesCache
                                     withRefrenceSizeFrames:toBeLayoutViewFrames
                                      fixedLengthWithPading:fixedLengthWithPading
                             totalLayoutLengthInCurrentLine:currentMainAxisTotalLength
                                       crossAxisLayoutStart:crossAxisLayoutStart
                                   nextCrossAxisLayoutStart:nextCrossAxisLayoutStart];
            
            // ** 即将开始下一 行/列 布局
            [toBeLayoutViewFrames removeAllObjects];
            if ((index == self.subviews.count) && [self __xhss_isSingleLineLayout]) {
                currentMainAxisTotalLength = 0;
                crossAxisLayoutStart = 0;
            } else if (![self __xhss_isSingleLineLayout]) {
                currentMainAxisTotalLength = 0;
                crossAxisLayoutStart = nextCrossAxisLayoutStart;
            }
            
            needFinishCurrentLayout = NO;
        }
    } // End while
    
        
    
    // ** 副轴方向的整体布局方式
    CGFloat crossAxisOffset = [self __xhss_crossAxisOffsetWithNextCrossAxisLayoutStart:nextCrossAxisLayoutStart];
    
    // ** 布局子视图
    [self __xhss_layoutWithSubviewFramesChache:subviewFramesCache
                          crossAxisTotalOffset:crossAxisOffset
                              maxCrossPosition:nextCrossAxisLayoutStart
                   isMultipuleSingleLineLayout:YES];
}


#pragma mark - Sigle Line Layout
/**
 单行/单列 布局
 */
- (void)__xhss_preSigleLineFlexLayout {
    // 横向布局需要先确定自身的宽度，如果有固定宽度则用固定宽度，如果宽度不固定则使用父视图的基本宽度
    // 纵向布局需要先确定自身的高度，如果有固定高度则用固定高度，如果高度不固定则使用父视图的基本高度
    CGFloat fixedLengthWithPading = [self __xhss_fixedLength];
        
    CGFloat totalLength = 0;
    CGFloat totalFixedLength = 0;
    
    BOOL needFlexLayout = NO;
    
    for (NSInteger index=0; index<self.subviews.count; index++) {
        UIView* subView = self.subviews[index];
        CGFloat layoutLength = [self __xhss_layoutLengthOfView:subView isMainAxis:YES];
        totalLength += layoutLength;
        // Layout mode
        switch (subView.layoutSizeMode) {
            case XHSSLayoutSizeMode_Fixed: {
                totalFixedLength += layoutLength;
            } break;
            case XHSSLayoutSizeMode_Compress:
            case XHSSLayoutSizeMode_Stretch:
            case XHSSLayoutSizeMode_Flexable: {
                needFlexLayout = YES;
            } break;
            default:
                break;
        }
    } // End for loop
    
    kXHSSAssert(totalFixedLength <= fixedLengthWithPading, @"需要布局的内容超出父视图边界");
    
    // ** 需要自适应布局时根据优先级、权重等进行空间分配
    NSUInteger minPriority = NSUIntegerMax;
    CGFloat unitFlexLength = 0;
    if (needFlexLayout) {
        NSDictionary* layoutInfoDIct = [self __xhss_subviewFlexPolicyWithTotalLength:totalLength
                                                         fixedLengthWithPading:fixedLengthWithPading];
        minPriority = [layoutInfoDIct[@"minPriority"] integerValue];
        unitFlexLength = [layoutInfoDIct[@"unitFlexLength"] floatValue];
    }
    
        
    // ** 所有子视图的 frame 缓存，用来调整最终布局状态
    NSMutableArray<NSValue*>* subviewFramesCache = [NSMutableArray array];
    NSMutableArray<NSValue*>* toBeLayoutViewFrames = [NSMutableArray array];
    CGFloat maxSubviewCrossAxisLength = 0;
    CGFloat totalLayoutLength = 0;
    for (NSInteger index=0; index<self.subviews.count; index++) {
        UIView* subView = self.subviews[index];
        CGFloat mainAxisLength = [self __xhss_layoutLengthOfView:subView isMainAxis:YES];

        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        // 如果需要自适应才动态处理宽度
        if (needFlexLayout) {
            switch (subView.layoutSizeMode) {
                case XHSSLayoutSizeMode_Fixed: {
                    // 使用固定已有的 宽度/长度
                } break;
                case XHSSLayoutSizeMode_Compress: {
                    if (subView.layoutPriority > minPriority) {
                        mainAxisLength = [self __xhss_layoutMinLengthOfView:subView isMainAxis:YES];
                    } else if (subView.layoutPriority == minPriority) {
                        mainAxisLength = MIN(mainAxisLength, unitFlexLength*subView.layoutFlex);
                    } else {
                        // 使用固定已有的 宽度/长度
                    }
                } break;
                case XHSSLayoutSizeMode_Stretch: {
                    if (subView.layoutPriority > minPriority) {
                        mainAxisLength = [self __xhss_layoutMinLengthOfView:subView isMainAxis:YES];
                    } else if (subView.layoutPriority == minPriority) {
                        mainAxisLength = MAX(mainAxisLength, unitFlexLength*subView.layoutFlex);
                    } else {
                        // 使用固定已有的 宽度/长度
                    }
                } break;
                case XHSSLayoutSizeMode_Flexable: {
                    if (subView.layoutPriority > minPriority) {
                        mainAxisLength = [self __xhss_layoutMinLengthOfView:subView isMainAxis:YES];
                    } else if (subView.layoutPriority == minPriority) {
                        mainAxisLength = unitFlexLength * subView.layoutFlex;
                    } else {
                        // 使用固定已有的 宽度/长度
                    }
                } break;
                default:
                    break;
            }
        } else {
            // 不需要动态处理布局空间
        }
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        CGFloat crossAxisLength = [self __xhss_crossAxisLayoutLengthOfView:subView
                                                  withMainAxisLayoutLength:mainAxisLength];
        maxSubviewCrossAxisLength = MAX(maxSubviewCrossAxisLength, crossAxisLength);
        totalLayoutLength += mainAxisLength;
        
        CGRect refFrame = [self __xhss_refLayoutFrameWithMainAxisLength:mainAxisLength
                                                        crossAxisLength:crossAxisLength];
        [toBeLayoutViewFrames addObject:@(refFrame)];
    } // End for loop
    
    
    // ** 计算布局
    CGFloat crossAxisLayoutStart = [self __xhss_crossAxisLayoutStart];
    [self __xhss_generateFramesToSubviewFramesCache:subviewFramesCache
                             withRefrenceSizeFrames:toBeLayoutViewFrames
                              fixedLengthWithPading:fixedLengthWithPading
                     totalLayoutLengthInCurrentLine:totalLayoutLength
                               crossAxisLayoutStart:crossAxisLayoutStart
                           nextCrossAxisLayoutStart:(crossAxisLayoutStart +maxSubviewCrossAxisLength)];
    
    // ** 副轴方向的整体布局方式
    CGFloat crossAxisOffset = [self __xhss_crossAxisOffsetWithNextCrossAxisLayoutStart:(crossAxisLayoutStart +maxSubviewCrossAxisLength)];
    
    // ** 执行布局
    [self __xhss_layoutWithSubviewFramesChache:subviewFramesCache
                          crossAxisTotalOffset:crossAxisOffset
                              maxCrossPosition:crossAxisLayoutStart +maxSubviewCrossAxisLength
                   isMultipuleSingleLineLayout:NO];
}


/**
 需要自适应布局时根据优先级、权重等进行空间分配
 */
- (NSDictionary*)__xhss_subviewFlexPolicyWithTotalLength:(CGFloat)totalLength
                          fixedLengthWithPading:(CGFloat)fixedLengthWithPading {
    BOOL needStretch = totalLength < fixedLengthWithPading;
    NSMutableDictionary<id, NSMutableArray<UIView*>*>* subviewPriorityInfoDict = [NSMutableDictionary dictionary];

    for (NSInteger index=0; index<self.subviews.count; index++) {
        UIView* subView = self.subviews[index];
        NSInteger priority = subView.layoutPriority;
        if (needStretch) {
            if (subView.layoutSizeMode == XHSSLayoutSizeMode_Stretch
                || subView.layoutSizeMode == XHSSLayoutSizeMode_Flexable) {

                NSMutableArray<UIView*>* prioritySubviews = subviewPriorityInfoDict[@(priority)];
                if (prioritySubviews && (![prioritySubviews containsObject:subView])) {
                    [prioritySubviews addObject:subView];
                } else {
                    subviewPriorityInfoDict[@(priority)] = [NSMutableArray arrayWithObjects:subView, nil];
                }
            } else { /* 不允许进行相应缩放处理的 subview */ }
        } else {
            if (subView.layoutSizeMode == XHSSLayoutSizeMode_Compress
                || subView.layoutSizeMode == XHSSLayoutSizeMode_Flexable) {

                NSMutableArray<UIView*>* prioritySubviews = subviewPriorityInfoDict[@(priority)];
                if (prioritySubviews && (![prioritySubviews containsObject:subView])) {
                    [prioritySubviews addObject:subView];
                } else {
                    subviewPriorityInfoDict[@(priority)] = [NSMutableArray arrayWithObjects:subView, nil];
                }
            } else { /* 不允许进行相应缩放处理的 subview */ }
        }
    }

    // 按照优先级从大到小排序
    NSMutableArray* priorityValues = [[subviewPriorityInfoDict allKeys] mutableCopy];
    [priorityValues sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 integerValue] < [obj2 integerValue];
    }];

    NSUInteger minPriority = NSUIntegerMax;
    CGFloat helpTotalLength = totalLength;
    CGFloat finalTotalFlexableLength = 0;
    NSInteger finalTotalFlexableFlex = 0;
    for (int idx=0; idx<priorityValues.count; idx++) {
        id priorityKey = priorityValues[idx];
        NSMutableArray<UIView*>* prioritySubviews = subviewPriorityInfoDict[priorityKey];

        CGFloat prioritySubviewsMinLength = 0;
        CGFloat prioritySubviewsLength = 0;
        CGFloat prioritySubviewsLengthRef = 0;
        NSInteger prioritySubviewsFlex = 0;
        for (UIView* subV in prioritySubviews) {
            prioritySubviewsMinLength += [self __xhss_layoutMinLengthOfView:subV isMainAxis:YES];
            prioritySubviewsLength += [self __xhss_layoutLengthOfView:subV isMainAxis:YES];
            prioritySubviewsLengthRef += ([self __xhss_layoutLengthOfView:subV isMainAxis:YES] -[self __xhss_layoutMinLengthOfView:subV isMainAxis:YES]);
            prioritySubviewsFlex += subV.layoutFlex;
        }

        helpTotalLength -= prioritySubviewsLengthRef;
        finalTotalFlexableLength += prioritySubviewsLengthRef;
        //finalTotalFlexableLength += prioritySubviewsMinLength;
        finalTotalFlexableFlex = prioritySubviewsFlex;

        if (helpTotalLength <= fixedLengthWithPading) {
            finalTotalFlexableLength += prioritySubviewsMinLength;
            minPriority = [priorityKey integerValue];
            break;
        }
    }

    kXHSSAssert(helpTotalLength <= fixedLengthWithPading, @"需要布局的内容尺寸过大，超出父视图边界");

    CGFloat canFlexLength = fixedLengthWithPading -(totalLength -finalTotalFlexableLength);
    CGFloat canFlexValue = finalTotalFlexableFlex;
    CGFloat unitFlexLength = canFlexValue > 0 ? canFlexLength/canFlexValue : 0;
    
    return @{
        @"minPriority": @(minPriority),
        @"unitFlexLength": @(unitFlexLength),
    };
}


#pragma mark - Common
/**
 根据副轴方向的整体对齐方式计算所有子视图在副轴方向的整体偏移量
 */
- (CGFloat)__xhss_crossAxisOffsetWithNextCrossAxisLayoutStart:(CGFloat)nextCrossAxisLayoutStart {
    // ** 副轴方向的整体布局方式
    CGFloat crossAxisOffset = 0; // xOffset
    if ([self __xhss_isCrossAxisAligmentAvailable]) {
        CGFloat layoutedLengthInCrossAxis = 0;
        CGFloat remainderSpace = 0;
        switch (self.mainLayoutType) {
            case XHSSLayoutType_HorizontalFlow:
            case XHSSLayoutType_Row: {
                layoutedLengthInCrossAxis = (nextCrossAxisLayoutStart -self.padingTopValue);
                remainderSpace = self.xhss_HeightValueWithPadingForAutoLayout -layoutedLengthInCrossAxis;
            } break;
            case XHSSLayoutType_VerticleFlow:
            case XHSSLayoutType_Column: {
                layoutedLengthInCrossAxis = (nextCrossAxisLayoutStart -self.padingLeftValue);
                remainderSpace = self.xhss_WidthValueWithPadingForAutoLayout -layoutedLengthInCrossAxis;
            } break;
            case XHSSLayoutType_Stack:
            default:
                break;
        }
        
        if (self.isCrossAxisExpending) {
            crossAxisOffset = remainderSpace;
        } else {
            switch (self.crossAxisAligment) {
                case XHSSLayoutAxisAligment_Start: {
                    // 副轴方向靠前
                    crossAxisOffset = 0;
                } break;
                case XHSSLayoutAxisAligment_Center: {
                    // 副轴方向居中
                    crossAxisOffset = remainderSpace/2.0;
                } break;
                case XHSSLayoutAxisAligment_End: {
                    // 副轴方向靠后
                    crossAxisOffset = remainderSpace;
                } break;
                default:
                    break;
            }
        }
    }
    
    return crossAxisOffset;
}


/**
 使用只计算好长、宽的 frame 信息计算相应 frame 的位置信息
 */
- (void)__xhss_generateFramesToSubviewFramesCache:(const NSMutableArray<NSValue*>*)subviewFramesCache
                           withRefrenceSizeFrames:(const NSMutableArray<NSValue*>*)toBeLayoutViewFrames
                            fixedLengthWithPading:(CGFloat)fixedLengthWithPading
                   totalLayoutLengthInCurrentLine:(CGFloat)currentMainAxisTotalLength
                             crossAxisLayoutStart:(CGFloat)crossAxisLayoutStart
                         nextCrossAxisLayoutStart:(CGFloat)nextCrossAxisLayoutStart {
    [toBeLayoutViewFrames enumerateObjectsUsingBlock:^(NSValue * _Nonnull subviewFrameValue,
                                                       NSUInteger idx,
                                                       BOOL * _Nonnull stop) {
        // 包括 margin、border 在内的 子视图布局区域
        CGSize subViewSize = [toBeLayoutViewFrames[idx] CGRectValue].size;
        
        // ** 主轴调整 **
        CGFloat mainAxisLayoutStart;
        CGFloat mainAxisLayoutSpace;
        // 平分空间布局
        if (self.isMainAxisExpending) {
            mainAxisLayoutStart = (fixedLengthWithPading -currentMainAxisTotalLength)/(toBeLayoutViewFrames.count +1);
            mainAxisLayoutSpace = mainAxisLayoutStart;
        }
        // 相邻紧凑布局
        else {
            switch (self.mainAxisAligment) {
                case XHSSLayoutAxisAligment_Start: {
                    // 主轴方向靠前
                    mainAxisLayoutStart = 0;
                    mainAxisLayoutSpace = 0;
                } break;
                case XHSSLayoutAxisAligment_Center: {
                    // 主轴方向居中
                    mainAxisLayoutStart = (fixedLengthWithPading -currentMainAxisTotalLength)/2.0;
                    mainAxisLayoutSpace = 0;
                } break;
                case XHSSLayoutAxisAligment_End: {
                    // 主轴方向靠后
                    mainAxisLayoutStart = fixedLengthWithPading -currentMainAxisTotalLength;
                    mainAxisLayoutSpace = 0;
                } break;
                default:
                    break;
            }
        }
        
        CGFloat mainAxisOriginComponent = 0;
        switch (self.mainLayoutType) {
            case XHSSLayoutType_HorizontalFlow:
            case XHSSLayoutType_Row: {
                if (idx <= 0) {
                    mainAxisOriginComponent = self.padingLeftValue +mainAxisLayoutStart;
                } else {
                    mainAxisOriginComponent = CGRectGetMaxX([toBeLayoutViewFrames[idx-1] CGRectValue]) +MAX(mainAxisLayoutSpace, 0);
                }
            } break;
            case XHSSLayoutType_VerticleFlow:
            case XHSSLayoutType_Column: {
                if (idx <= 0) {
                    mainAxisOriginComponent = self.padingTopValue +mainAxisLayoutStart;
                } else {
                    mainAxisOriginComponent = CGRectGetMaxY([toBeLayoutViewFrames[idx-1] CGRectValue]) +MAX(mainAxisLayoutSpace, 0);
                }
            } break;
            case XHSSLayoutType_Stack:
            default:
                break;
        }
        
        
        // ** 副轴调整 **
        CGFloat subviewLengthInCrossAxis = [self __xhss_lengthOfViewSize:subViewSize
                                                              isMainAxis:NO];
        // 副轴方向最大空间
        CGFloat currentMaxLengthInCrossAxis = (nextCrossAxisLayoutStart -crossAxisLayoutStart) -subviewLengthInCrossAxis;
        
        CGFloat crossAxisOriginComponent;
        switch (self.mainAxisCrossAligment) {
            case XHSSLayoutAxisAligment_Start: {
                crossAxisOriginComponent = crossAxisLayoutStart;
            } break;
            case XHSSLayoutAxisAligment_Center: {
                crossAxisOriginComponent = crossAxisLayoutStart +currentMaxLengthInCrossAxis/2.0;
            } break;
            case XHSSLayoutAxisAligment_End: {
                crossAxisOriginComponent = crossAxisLayoutStart +currentMaxLengthInCrossAxis;
            } break;
            default:
                break;
        }
        
        // ** 计算 frame
        CGFloat x = 0, y = 0;
        switch (self.mainLayoutType) {
            case XHSSLayoutType_HorizontalFlow:
            case XHSSLayoutType_Row: {
                x = mainAxisOriginComponent;
                y = crossAxisOriginComponent;
            } break;
            case XHSSLayoutType_VerticleFlow:
            case XHSSLayoutType_Column: {
                x = crossAxisOriginComponent;
                y = mainAxisOriginComponent;
            } break;
            case XHSSLayoutType_Stack:
            default:
                break;
        }
        
        CGRect marginFrame = CGRectMake(x,
                                        y,
                                        subViewSize.width,
                                        subViewSize.height);
        toBeLayoutViewFrames[idx] = @(marginFrame);
        [subviewFramesCache addObject:@(marginFrame)];
    }];
}

/**
 使用计算好的 frame 对所有子视图进行最后的布局
 */
- (void)__xhss_layoutWithSubviewFramesChache:(NSMutableArray<NSValue*>*)subviewFramesCache
                         crossAxisTotalOffset:(CGFloat)crossAxisTotalOffset
                            maxCrossPosition:(CGFloat)maxCrossPosition
                 isMultipuleSingleLineLayout:(BOOL)isMultipule
                         /*crossAxisLyoutCount:(NSUInteger)crossAxisLyoutCount*/ {
    if (!subviewFramesCache || subviewFramesCache.count == 0) return;
    
    CGFloat firstCrossOriginComponent = [self __xhss_originComponentOfViewFrame:[subviewFramesCache[0] CGRectValue] isMainAxis:NO];
    CGFloat lastCrossStart = firstCrossOriginComponent;
    
    NSUInteger crossAxisLyoutCount = 1;
    if (isMultipule && self.isCrossAxisExpending) {
        crossAxisLyoutCount = [self __xhss_numberOfLayoutSingleLineInSubviewFramesCache:subviewFramesCache];
    }
    CGFloat crossAxisExpendingSpace = crossAxisTotalOffset/(crossAxisLyoutCount+1)*1.0;
    CGFloat crossAxisAddition = crossAxisExpendingSpace;
    
    for (NSInteger idx=0; idx<self.subviews.count; idx++) {
        UIView* subView = self.subviews[idx];
        CGRect subViewMarginFrame = [subviewFramesCache[idx] CGRectValue];

        // 副轴平分剩余空间
        if (self.isCrossAxisExpending) {
            // 每行/列递增一个相等的平均空间
            CGFloat currentCrossOriginComponent = [self __xhss_originComponentOfViewFrame:subViewMarginFrame isMainAxis:NO];
            if (currentCrossOriginComponent != lastCrossStart) {
                lastCrossStart = currentCrossOriginComponent;
                crossAxisAddition += crossAxisExpendingSpace;
            }
        } else {
            // 所有行/列整体偏移
            crossAxisAddition = crossAxisTotalOffset;
        } // End if
        
        // 生成 frame
        switch (self.mainLayoutType) {
            case XHSSLayoutType_HorizontalFlow:
            case XHSSLayoutType_Row: {
                subViewMarginFrame = CGRectMake(subViewMarginFrame.origin.x,
                                                subViewMarginFrame.origin.y +crossAxisAddition,
                                                subViewMarginFrame.size.width,
                                                subViewMarginFrame.size.height);
            } break;
            case XHSSLayoutType_VerticleFlow:
            case XHSSLayoutType_Column: {
                subViewMarginFrame = CGRectMake(subViewMarginFrame.origin.x +crossAxisAddition,
                                                subViewMarginFrame.origin.y,
                                                subViewMarginFrame.size.width,
                                                subViewMarginFrame.size.height);
            } break;
            case XHSSLayoutType_Stack:
            default:
                break;
        } // End switch
        
        // 将计算好的 subview frame 赋值给 subview，执行 subview 布局
        subView.xhss_FrameWithMarginForAutoLayout = subViewMarginFrame;
        // 此处对 subview 的所有子视图进行布局计算 并执行布局
        [subView xhss_PerformAutoLayout];
    } // End for loop
    
    
    // 清 subview frames 缓存
    [subviewFramesCache removeAllObjects];
        
    // 根据子视图布局后的状态调整自身尺寸，如果是固定布局不用再次调整自身尺寸
    [self __xhss_fixSelfSizeWithLayoutEndBoundary:maxCrossPosition];
}

/**
 获取副轴一共排列了多少行/列，用来布局子视图
 */
- (NSUInteger)__xhss_numberOfLayoutSingleLineInSubviewFramesCache:(NSMutableArray<NSValue*>*)subviewFramesCache {
    if (!subviewFramesCache || subviewFramesCache.count == 0) return 1;
    
    NSUInteger crossAxisLyoutCount = 1;
    CGFloat firstCrossOriginComponent = [self __xhss_originComponentOfViewFrame:[subviewFramesCache[0] CGRectValue] isMainAxis:NO];
    CGFloat lastCrossStart = subviewFramesCache.count>0 ? firstCrossOriginComponent : 0;
    for (id frameValue in subviewFramesCache) {
        CGFloat crossOriginComponent = [self __xhss_originComponentOfViewFrame:[frameValue CGRectValue] isMainAxis:NO];
        if (crossOriginComponent != lastCrossStart) {
            lastCrossStart = crossOriginComponent;
            crossAxisLyoutCount++;
        }
    }
    
    return crossAxisLyoutCount;
}

/**
 根据子视图布局后的状态调整自身尺寸，如果是固定布局不用再次调整自身尺寸
 */
- (void)__xhss_fixSelfSizeWithLayoutEndBoundary:(CGFloat)layoutEndBoundary {
    CGRect frame = self.frame;

    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            if ([self isKindOfClass:[UIScrollView class]]) {
                UIScrollView* scrollView = self;
                scrollView.contentSize = CGSizeMake(frame.size.width, layoutEndBoundary);
            }
            if (!self.needResizeSelfBySubview) return;
            if (self.layoutHeight == 0) {
                if ([self isKindOfClass:[UITableView class]]) {
                    // ....
                } else if ([self isKindOfClass:[UICollectionView class]]) {
                    // ....
                } else if ([self isKindOfClass:[UIScrollView class]]) {
                    // ....
                } else {
                    frame.size.height = layoutEndBoundary +self.padingBottomValue;
                }
            } else { /* 高度已经固定不需要动态调整 */ }
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            if ([self isKindOfClass:[UIScrollView class]]) {
                UIScrollView* scrollView = self;
                scrollView.contentSize = CGSizeMake(layoutEndBoundary, frame.size.height);
            }
            if (!self.needResizeSelfBySubview) return;
            if (self.layoutWidth == 0) {
                if ([self isKindOfClass:[UITableView class]]) {
                    // ....
                } else if ([self isKindOfClass:[UICollectionView class]]) {
                    // ....
                } else if ([self isKindOfClass:[UIScrollView class]]) {
                    // ....
                } else {
                    frame.size.width = layoutEndBoundary +self.padingRightValue;
                }
            } else { /* 宽度已经固定不需要动态调整 */ }
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
    
    self.frame = frame;
}

/**
  层叠式布局
 */
- (void)xhss_StackLayout {
    
}

@end


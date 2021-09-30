//
//  UIView+XHSSAutoLayoutCoreUtils.m
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import "UIView+XHSSAutoLayoutCoreUtils.h"
#import "UIView+XHSSAutoLayoutProperty.h"
#import "UIView+XHSSAutoLayoutPointAndValueUtils.h"
#import "UIView+XHSSAutoLayoutSizeUtils.h"


@implementation UIView (XHSSAutoLayoutCoreUtils)

/**
 某个视图是否能够进行布局
 */
- (BOOL)__xhss_isViewLayoutAvailable:(UIView*)view {
    return !((view.layoutWidth == 0) && (view.layoutFlex == 0));
}


/**
 某个视图是否需要自动调整布局尺寸
 */
- (BOOL)__xhss_ifViewNeedFlexLayout:(UIView*)view {
    return (view.layoutWidth == 0) && (view.layoutFlex > 0);
}

/**
 是否 单行 或 单列 布局模式
 */
- (BOOL)__xhss_isSingleLineLayout {
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_VerticleFlow: {
            return NO;
        } break;
        case XHSSLayoutType_Row:
        case XHSSLayoutType_Column:
        case XHSSLayoutType_Stack:
        default:
            return YES;
            break;
    }
}

/**
 是否副轴方向的整体布局方式可调整
 */
- (BOOL)__xhss_isCrossAxisAligmentAvailable {
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            return self.layoutHeight > 0;
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            return self.layoutWidth > 0;
        } break;
        case XHSSLayoutType_Stack:
        default:
            return NO;
            break;
    }
}


/**
 获取给定长度下带外边距和边框宽度的长度
 */
- (CGFloat)__xhss_marginLengthOfView:(UIView*)view
                          fromLength:(CGFloat)length
                        isAtMainAxis:(BOOL)isMainAxis {
    CGFloat horizontalLength = view.marginLeftValue +view.borderLeftValue
                                +length
                                +view.borderRightValue +view.marginRightValue;
    CGFloat verticalLength = view.marginTopValue +view.borderTopValue
                                +length
                                +view.borderBottomValue +view.marginBottomValue;
    CGFloat marginLength = 0;
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            marginLength = isMainAxis ? horizontalLength : verticalLength;
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            marginLength = isMainAxis ? verticalLength : horizontalLength;
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
    return marginLength;
}

/**
 获取给定长度下不带外边距和边框宽度的长度
 */
- (CGFloat)__xhss_lengthOfView:(UIView*)view
              fromMarginLength:(CGFloat)marginLength
                  isAtMainAxis:(BOOL)isMainAxis {
    CGFloat horizontalLength = marginLength
                                -view.marginLeftValue -view.borderLeftValue
                                -view.borderRightValue -view.marginRightValue;
    CGFloat verticalLength = marginLength
                                -view.marginTopValue -view.borderTopValue
                                -view.borderBottomValue -view.marginBottomValue;
    CGFloat length = 0;
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            length = isMainAxis ? horizontalLength : verticalLength;
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            length = isMainAxis ? verticalLength : horizontalLength;
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
    return length;
}

/**
 给定 宽度/高度 通过宽高比计算对应 高度/宽度
 */
- (CGFloat)__xhss_lengthOfView:(UIView*)view
          withWHRatioRefLength:(CGFloat)refLength
         refLengthIsAtMainAxis:(BOOL)refLengthIsAtMainAxis {
    CGFloat length = refLength;
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            if (view.layoutWHRatio > 0) {
                length = refLengthIsAtMainAxis
                            ? refLength/view.layoutWHRatio/*width*/
                            : refLength*view.layoutWHRatio/*height*/;
            }
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            if (view.layoutWHRatio > 0) {
                length = refLengthIsAtMainAxis
                            ? refLength*view.layoutWHRatio/*height*/
                            : refLength/view.layoutWHRatio/*width*/;
            }
            length = (view.layoutWHRatio > 0) ? refLength*view.layoutWHRatio : refLength;
        } break;
        case XHSSLayoutType_Stack:
        default:
            length = 0;
            break;
    }
    return length;
}

/**
 给定主轴长度确定副轴长度
 */
- (CGFloat)__xhss_crossAxisLayoutLengthOfView:(UIView*)view
                     withMainAxisLayoutLength:(CGFloat)mainAxisLength {
    CGFloat crossAxisLength = 0;
    CGFloat lengthNoMargin = [self __xhss_lengthOfView:view
                                      fromMarginLength:mainAxisLength
                                          isAtMainAxis:YES];
    CGFloat ratioLength = [self __xhss_lengthOfView:view
                               withWHRatioRefLength:lengthNoMargin
                              refLengthIsAtMainAxis:YES];
    CGFloat ratioMarginLength = [self __xhss_marginLengthOfView:view
                                                     fromLength:ratioLength
                                                   isAtMainAxis:NO];
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            crossAxisLength = (view.xhss_HeightValueWithMarginForAutoLayout > 0)
                                ? view.xhss_HeightValueWithMarginForAutoLayout
                                : ratioMarginLength;
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            crossAxisLength = (view.xhss_WidthValueWithMarginForAutoLayout > 0)
                                ? view.xhss_WidthValueWithMarginForAutoLayout
                                : ratioMarginLength;
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
    return crossAxisLength;
}

/**
 通过给定 主轴/副轴 的长度获取一个参考布局 frame
 */
- (CGRect)__xhss_refLayoutFrameWithMainAxisLength:(CGFloat)mainAxisLength crossAxisLength:(CGFloat)crossAxisLength {
    CGRect frame = CGRectZero;
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            frame = CGRectMake(0,
                               0,
                               mainAxisLength,
                               crossAxisLength);
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            frame = CGRectMake(0,
                               0,
                               crossAxisLength,
                               mainAxisLength);
        } break;
        default:
            break;
    }
    return frame;
}

/**
 获取一个 viewFrame 的 origin 在 主轴/副轴 的原点分量
 */
- (CGFloat)__xhss_originComponentOfViewFrame:(CGRect)frame isMainAxis:(BOOL)isMainAxis {
    CGFloat originComponent = 0;
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            originComponent = isMainAxis ? frame.origin.x : frame.origin.y;
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            originComponent = isMainAxis ? frame.origin.y : frame.origin.x;
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
    return originComponent;
}

/**
 获取 Size 在 主轴/副轴 方向的长度
 */
- (CGFloat)__xhss_lengthOfViewSize:(CGSize)viewSize isMainAxis:(BOOL)isMainAxis {
    CGFloat viewLength = 0;
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            viewLength = isMainAxis ? viewSize.width : viewSize.height;
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            viewLength = isMainAxis ? viewSize.height : viewSize.width;
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
    return viewLength;
}

/**
 获取 View 在 主轴/副轴 方向的长度
 */
- (CGFloat)__xhss_layoutLengthOfView:(UIView*)view isMainAxis:(BOOL)isMainAxis {
    CGFloat viewLength = 0;
    CGFloat width = view.xhss_WidthValueWithMarginForAutoLayout;
    CGFloat height = view.xhss_HeightValueWithMarginForAutoLayout;
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            viewLength = isMainAxis ? width : height;
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            viewLength = isMainAxis ? height : width;
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
    return viewLength;
}

/**
 获取 View 在 主轴/副轴 方向的最小布局长度
 */
- (CGFloat)__xhss_layoutMinLengthOfView:(UIView*)view isMainAxis:(BOOL)isMainAxis {
    CGFloat viewMinLength = 0;
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            viewMinLength = isMainAxis ? view.layoutMinWidth : view.layoutMinHeight;
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            viewMinLength = isMainAxis ? view.layoutMinHeight : view.layoutMinWidth;
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
    return viewMinLength;
}

/**
 获取 View 在 主轴/副轴 方向对子视图布局的起点
 */
- (CGFloat)__xhss_layoutStartIsMainAxis:(BOOL)isMainAxis {
    CGFloat layoutStart = 0;
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            layoutStart = isMainAxis ? self.padingLeftValue : self.padingTopValue;
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            layoutStart = isMainAxis ? self.padingTopValue : self.padingLeftValue;
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
    return layoutStart;
}
/**
 副轴方向开始布局的位置
 */
- (CGFloat)__xhss_crossAxisLayoutStart {
    CGFloat crossAxisLayoutStart = 0;
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            crossAxisLayoutStart = self.padingTopValue;
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            crossAxisLayoutStart = self.padingLeftValue;
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
    return crossAxisLayoutStart;
}

/**
 检查布局意图是否合法
 */
- (void)__xhss_CheckLayoutAvailable {
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow: {
            NSAssert(self.layoutWidth > 0, @"<<<< 水平方向优先布局需要固定宽度 >>>>");
        } break;
        case XHSSLayoutType_VerticleFlow: {
            NSAssert(self.layoutHeight > 0, @"<<<< 竖直方向优先布局需要固定高度 >>>>");
        } break;
        case XHSSLayoutType_Row: {
            NSAssert(self.layoutWidth > 0, @"<<<< 行布局需要固定宽度 >>>>");
        } break;
        case XHSSLayoutType_Column: {
            NSAssert(self.layoutHeight > 0, @"<<<< 列布局需要固定高度 >>>>");
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
}

/**
 如果自身设置了固定的 Width 或 Height 则获取固定的 Width 或 Height
 */
- (CGFloat)__xhss_fixedLength {
    CGFloat fixedLength = 0;
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            fixedLength = [self xhss_BaseWidth];
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            fixedLength = [self xhss_BaseHeight];
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
    return fixedLength;
}

/**
 获取视图自身在 主轴/副轴 方向的固定长度
 */
- (CGFloat)__xhss_fixedLengthIsMainAxis:(BOOL)isMainAxis {
    CGFloat fixedLength = 0;
    switch (self.mainLayoutType) {
        case XHSSLayoutType_HorizontalFlow:
        case XHSSLayoutType_Row: {
            fixedLength = isMainAxis ? [self xhss_BaseWidth] : [self xhss_BaseHeight];
        } break;
        case XHSSLayoutType_VerticleFlow:
        case XHSSLayoutType_Column: {
            fixedLength = isMainAxis ? [self xhss_BaseHeight] : [self xhss_BaseWidth];
        } break;
        case XHSSLayoutType_Stack:
        default:
            break;
    }
    return fixedLength;
}

/**
 布局参考的 Size
 */
- (CGSize)__xhss_PreLayoutSizeWithMargin {
    CGSize size = [self __xhss_PreLayoutSize];
    return size;
}
- (CGSize)__xhss_PreLayoutSize {
    /**
     * when in bounded constraints, try to be as big as possible in that direction.
     *    bounded : notScroll, width > 0, height > 0,
      
     * when in unbounded constraints, try to fit their children in that direction.
     *    unbounded : scroll, width = 0, height = 0,
     */
    
    
    // ** margin 以及 padding 会影响布局
    CGSize layoutSize = CGSizeZero;
    
    if (self.layoutWidth > 0
        && self.layoutHeight > 0
        ) {
        // 宽度固定，高度固定
        layoutSize = [self xhss_FixedWidth:self.layoutWidth forSize:layoutSize];
        layoutSize = [self xhss_FixedHeight:self.layoutHeight forSize:layoutSize];
    }
    else if (self.layoutWidth > 0
             && self.layoutHeight == 0
             ) {
        // 没有子视图
        if (self.subviews.count == 0) {
            // 宽度固定，高度尽量大
            layoutSize = [self xhss_FixedWidth:self.layoutWidth forSize:layoutSize];
            layoutSize = [self xhss_AsBigAsPossibleHeightForSize:layoutSize];
        }
        // 有子视图
        else {
            // 宽度固定，高度包裹子视图(尽量小)
            layoutSize = [self xhss_FixedWidth:self.layoutWidth forSize:layoutSize];
            layoutSize = [self xhss_AsSmallAsPossibleHeightForSize:layoutSize];
        }
    }
    else if (self.layoutWidth == 0
             && self.layoutHeight > 0
             ) {
        // 没有子视图
        if (self.subviews.count == 0) {
            // 宽度尽量大，高度固定
            layoutSize = [self xhss_AsBigAsPossibleWidthForSize:layoutSize];
            layoutSize = [self xhss_FixedHeight:self.layoutHeight forSize:layoutSize];
        }
        // 有子视图
        else {
            // 宽度包裹子视图(尽量小)，高度固定
            layoutSize = [self xhss_AsSmallAsPossibleWidthForSize:layoutSize];
            layoutSize = [self xhss_FixedHeight:self.layoutHeight forSize:layoutSize];
        }
    }
    else if (self.layoutWidth == 0
             && self.layoutHeight == 0) {
        // 没有子视图
        if (self.subviews.count == 0) {
            // 宽度、高度 尽量大
            layoutSize = [self xhss_AsBigAsPossibleWidthForSize:layoutSize];
            layoutSize = [self xhss_AsBigAsPossibleHeightForSize:layoutSize];
        }
        // 有子视图
        else {
            // 横向布局
            if (self.mainLayoutType == XHSSLayoutType_HorizontalFlow) {
                // 宽度尽量大，高度包裹子视图(尽量小)
                layoutSize = [self xhss_AsBigAsPossibleWidthForSize:layoutSize];
                layoutSize = [self xhss_AsSmallAsPossibleHeightForSize:layoutSize];
            }
            // 纵向布局
            else if (self.mainLayoutType == XHSSLayoutType_VerticleFlow) {
                // 宽度包裹子视图(尽量小)，高度尽量大
                layoutSize = [self xhss_AsSmallAsPossibleWidthForSize:layoutSize];
                layoutSize = [self xhss_AsBigAsPossibleHeightForSize:layoutSize];
            }
            // 重叠布局
            else {
                // TODO
                // ....
            }
        }
    }
    else {
        // ....
    }
    
    return layoutSize;
}

@end

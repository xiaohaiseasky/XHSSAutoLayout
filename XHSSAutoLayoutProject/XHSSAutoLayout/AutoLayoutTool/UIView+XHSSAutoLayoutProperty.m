//
//  UIView+AutoLayoutProperty.m
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import "UIView+XHSSAutoLayoutProperty.h"
#import <objc/runtime.h>




@implementation UIView (AutoLayoutProperty)

// ** mainLayoutDirection;
- (void)setMainLayoutType:(XHSSLayoutType)mainLayoutType {
    objc_setAssociatedObject(self,
                             @selector(mainLayoutType),
                             @(mainLayoutType),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (XHSSLayoutType)mainLayoutType {
    return [objc_getAssociatedObject(self, @selector(mainLayoutType)) integerValue];
}

// ** mainAxisAligment;
- (void)setMainAxisAligment:(XHSSLayoutAxisAligment)mainAxisAligment {
    objc_setAssociatedObject(self,
                             @selector(mainAxisAligment),
                             @(mainAxisAligment),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (XHSSLayoutAxisAligment)mainAxisAligment {
    return [objc_getAssociatedObject(self, @selector(mainAxisAligment)) integerValue];
}

// ** crossAxisAligment;
- (void)setCrossAxisAligment:(XHSSLayoutAxisAligment)crossAxisAligment {
    objc_setAssociatedObject(self,
                             @selector(crossAxisAligment),
                             @(crossAxisAligment),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (XHSSLayoutAxisAligment)crossAxisAligment {
    return [objc_getAssociatedObject(self, @selector(crossAxisAligment)) integerValue];
}


// ** mainAxisCrossAligment;
- (void)setMainAxisCrossAligment:(XHSSLayoutAxisAligment)mainAxisCrossAligment {
    objc_setAssociatedObject(self,
                             @selector(mainAxisCrossAligment),
                             @(mainAxisCrossAligment),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (XHSSLayoutAxisAligment)mainAxisCrossAligment {
    return [objc_getAssociatedObject(self, @selector(mainAxisCrossAligment)) integerValue];
}

// ** padingOption;
//- (void)setPadingOption:(XHSSLayoutPadingOption)padingOption {
//    objc_setAssociatedObject(self,
//                             @selector(padingOption),
//                             @(padingOption),
//                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//- (XHSSLayoutPadingOption)padingOption {
//    return [objc_getAssociatedObject(self, @selector(padingOption)) integerValue];
//}

// ** padingValue;
- (void)setPadingValue:(CGFloat)padingValue {
    self.padingTopValue = padingValue;
    self.padingLeftValue = padingValue;
    self.padingBottomValue = padingValue;
    self.padingRightValue = padingValue;
}
- (CGFloat)padingValue {
    return -MAXFLOAT;
}

// ** padingTopValue;
- (void)setPadingTopValue:(CGFloat)padingTopValue {
    objc_setAssociatedObject(self,
                             @selector(padingTopValue),
                             @(padingTopValue),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)padingTopValue {
    return [objc_getAssociatedObject(self, @selector(padingTopValue)) floatValue];
}

// ** padingLeftValue;
- (void)setPadingLeftValue:(CGFloat)padingLeftValue {
    objc_setAssociatedObject(self,
                             @selector(padingLeftValue),
                             @(padingLeftValue),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)padingLeftValue {
    return [objc_getAssociatedObject(self, @selector(padingLeftValue)) floatValue];
}

// ** padingBottomValue;
- (void)setPadingBottomValue:(CGFloat)padingBottomValue {
    objc_setAssociatedObject(self,
                             @selector(padingBottomValue),
                             @(padingBottomValue),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)padingBottomValue {
    return [objc_getAssociatedObject(self, @selector(padingBottomValue)) floatValue];
}

// ** padingRightValue;
- (void)setPadingRightValue:(CGFloat)padingRightValue {
    objc_setAssociatedObject(self,
                             @selector(padingRightValue),
                             @(padingRightValue),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)padingRightValue {
    return [objc_getAssociatedObject(self, @selector(padingRightValue)) floatValue];
}

// ** borderOption;
//- (void)setBorderOption:(XHSSLayoutBorderOption)borderOption {
//    objc_setAssociatedObject(self,
//                             @selector(borderOption),
//                             @(borderOption),
//                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//- (XHSSLayoutBorderOption)borderOption {
//    return [objc_getAssociatedObject(self, @selector(borderOption)) integerValue];
//}

// ** borderValue;
- (void)setBorderValue:(CGFloat)borderValue {
    self.borderTopValue = borderValue;
    self.borderLeftValue = borderValue;
    self.borderBottomValue = borderValue;
    self.borderRightValue = borderValue;
}
- (CGFloat)borderValue {
    return -MAXFLOAT;
}

// ** borderTopValue;
- (void)setBorderTopValue:(CGFloat)borderTopValue {
    objc_setAssociatedObject(self,
                             @selector(borderTopValue),
                             @(borderTopValue),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)borderTopValue {
    return [objc_getAssociatedObject(self, @selector(borderTopValue)) floatValue];
}

// ** borderLeftValue;
- (void)setBorderLeftValue:(CGFloat)borderLeftValue {
    objc_setAssociatedObject(self,
                             @selector(borderLeftValue),
                             @(borderLeftValue),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)borderLeftValue {
    return [objc_getAssociatedObject(self, @selector(borderLeftValue)) floatValue];
}

// ** borderBottomValue;
- (void)setBorderBottomValue:(CGFloat)borderBottomValue {
    objc_setAssociatedObject(self,
                             @selector(borderBottomValue),
                             @(borderBottomValue),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)borderBottomValue {
    return [objc_getAssociatedObject(self, @selector(borderBottomValue)) floatValue];
}

// ** borderRightValue;
- (void)setBorderRightValue:(CGFloat)borderRightValue {
    objc_setAssociatedObject(self,
                             @selector(borderRightValue),
                             @(borderRightValue),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)borderRightValue {
    return [objc_getAssociatedObject(self, @selector(borderRightValue)) floatValue];
}

// ** marginOption;
//- (void)setMarginOption:(XHSSLayoutMarginOption)marginOption {
//    objc_setAssociatedObject(self,
//                             @selector(marginOption),
//                             @(marginOption),
//                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//- (XHSSLayoutMarginOption)marginOption {
//    return [objc_getAssociatedObject(self, @selector(marginOption)) integerValue];
//}

// ** marginValue;
- (void)setMarginValue:(CGFloat)marginValue {
    self.marginTopValue = marginValue;
    self.marginLeftValue = marginValue;
    self.marginBottomValue = marginValue;
    self.marginRightValue = marginValue;
}
- (CGFloat)marginValue {
    return -MAXFLOAT;
}

// ** marginTopValue;
- (void)setMarginTopValue:(CGFloat)marginTopValue {
    objc_setAssociatedObject(self,
                             @selector(marginTopValue),
                             @(marginTopValue),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)marginTopValue {
    return [objc_getAssociatedObject(self, @selector(marginTopValue)) floatValue];
}

// ** marginLeftValue;
- (void)setMarginLeftValue:(CGFloat)marginLeftValue {
    objc_setAssociatedObject(self,
                             @selector(marginLeftValue),
                             @(marginLeftValue),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)marginLeftValue {
    return [objc_getAssociatedObject(self, @selector(marginLeftValue)) floatValue];
}

// ** marginBottomValue;
- (void)setMarginBottomValue:(CGFloat)marginBottomValue {
    objc_setAssociatedObject(self,
                             @selector(marginBottomValue),
                             @(marginBottomValue),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)marginBottomValue {
    return [objc_getAssociatedObject(self, @selector(marginBottomValue)) floatValue];
}

// ** marginRightValue;
- (void)setMarginRightValue:(CGFloat)marginRightValue {
    objc_setAssociatedObject(self,
                             @selector(marginRightValue),
                             @(marginRightValue),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)marginRightValue {
    return [objc_getAssociatedObject(self, @selector(marginRightValue)) floatValue];
}

// ** layoutWidth;
- (void)setLayoutWidth:(CGFloat)layoutWidth {
    objc_setAssociatedObject(self,
                             @selector(layoutWidth),
                             @(layoutWidth),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)layoutWidth {
    CGFloat width = [objc_getAssociatedObject(self, @selector(layoutWidth)) floatValue];
    return width > 0 ? width : CGRectGetWidth(self.frame);
}

// ** layoutHeight;
- (void)setLayoutHeight:(CGFloat)layoutHeight {
    objc_setAssociatedObject(self,
                             @selector(layoutHeight),
                             @(layoutHeight),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)layoutHeight {
    CGFloat height = [objc_getAssociatedObject(self, @selector(layoutHeight)) floatValue];
    return height > 0 ? height : CGRectGetHeight(self.frame);
}

// ** layoutMinWidth;
- (void)setLayoutMinWidth:(CGFloat)layoutMinWidth {
    objc_setAssociatedObject(self,
                             @selector(layoutMinWidth),
                             @(layoutMinWidth),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)layoutMinWidth {
    return [objc_getAssociatedObject(self, @selector(layoutMinWidth)) floatValue];
}

// ** layoutMinHeight;
- (void)setLayoutMinHeight:(CGFloat)layoutMinHeight {
    objc_setAssociatedObject(self,
                             @selector(layoutMinHeight),
                             @(layoutMinHeight),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)layoutMinHeight {
    return [objc_getAssociatedObject(self, @selector(layoutMinHeight)) floatValue];
}


// ** isExpending;
- (void)setIsExpending:(BOOL)isExpending {
    self.isMainAxisExpending = isExpending;
    self.isCrossAxisExpending = isExpending;
}
- (BOOL)isExpending {
    NSAssert(NO, @"‘isExpending‘ 只用在便捷同时设置 ‘isMainAxisExpending’ 、‘isCrossAxisExpending’");
    return NO;
}

// ** isMainAxisExpending;
- (void)setIsMainAxisExpending:(BOOL)isMainAxisExpending {
    objc_setAssociatedObject(self,
                             @selector(isMainAxisExpending),
                             @(isMainAxisExpending),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isMainAxisExpending {
    return [objc_getAssociatedObject(self, @selector(isMainAxisExpending)) boolValue];
}

// ** isCrossAxisExpending;
- (void)setIsCrossAxisExpending:(BOOL)isCrossAxisExpending {
    objc_setAssociatedObject(self,
                             @selector(isCrossAxisExpending),
                             @(isCrossAxisExpending),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isCrossAxisExpending {
    return [objc_getAssociatedObject(self, @selector(isCrossAxisExpending)) boolValue];
}

// ** layoutFlex;
- (void)setLayoutFlex:(CGFloat)layoutFlex {
    objc_setAssociatedObject(self,
                             @selector(layoutFlex),
                             @(layoutFlex),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)layoutFlex {
    return [objc_getAssociatedObject(self, @selector(layoutFlex)) floatValue];
}

// ** layoutPriority;
- (void)setLayoutPriority:(NSInteger)layoutPriority {
    objc_setAssociatedObject(self,
                             @selector(layoutPriority),
                             @(layoutPriority),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)layoutPriority {
    return [objc_getAssociatedObject(self, @selector(layoutPriority)) integerValue];
}

// ** layoutSizeMode;
- (void)setLayoutSizeMode:(XHSSLayoutSizeMode)layoutSizeMode {
    objc_setAssociatedObject(self,
                             @selector(layoutSizeMode),
                             @(layoutSizeMode),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (XHSSLayoutSizeMode)layoutSizeMode {
    return [objc_getAssociatedObject(self, @selector(layoutSizeMode)) integerValue];
}

// ** layoutWHRatio;
- (void)setLayoutWHRatio:(CGFloat)layoutWHRatio {
    objc_setAssociatedObject(self,
                             @selector(layoutWHRatio),
                             @(layoutWHRatio),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)layoutWHRatio {
    CGFloat whRatio = [objc_getAssociatedObject(self, @selector(layoutWHRatio)) floatValue];
    return whRatio > 0 ? whRatio : 1.0;
}

// ** needResizeSelfBySubview;
- (void)setNeedResizeSelfBySubview:(BOOL)needResizeSelfBySubview {
    objc_setAssociatedObject(self,
                             @selector(needResizeSelfBySubview),
                             @(needResizeSelfBySubview),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)needResizeSelfBySubview {
    return [objc_getAssociatedObject(self, @selector(needResizeSelfBySubview)) boolValue];
}

//@property (nonatomic, assign) BOOL allowOutOfBounds;    // 是否允许超出自身 frame 边界布局
 
@end

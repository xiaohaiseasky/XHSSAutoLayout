//
//  UIView+AutoLayoutPointAndValueUtils.m
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import "UIView+XHSSAutoLayoutPointAndValueUtils.h"
#import "UIView+XHSSAutoLayoutProperty.h"


@implementation UIView (AutoLayoutPointAndValueUtils)

// top
- (CGFloat)xhss_TopValueForAutoLayout {
    return CGRectGetMinY(self.frame);
}
- (CGFloat)xhss_TopValueWithPadingForAutoLayout {
    CGFloat top = [self xhss_TopValueForAutoLayout];
    CGFloat padingTop = top +self.padingTopValue;
    return padingTop;
}
- (CGFloat)xhss_TopValueWithBorderForAutoLayout {
    CGFloat top = [self xhss_TopValueForAutoLayout];
    CGFloat borderTop = top -self.borderTopValue;
    return borderTop;
}
- (CGFloat)xhss_TopValueWithMarginForAutoLayout {
    CGFloat top = [self xhss_TopValueForAutoLayout];
    CGFloat marginTop = top -self.borderTopValue -self.marginTopValue;
    return marginTop;
}

// left
- (CGFloat)xhss_LeftValueForAutoLayout {
    return CGRectGetMinX(self.frame);
}
- (CGFloat)xhss_LeftValueWithPadingForAutoLayout {
    CGFloat left = [self xhss_LeftValueForAutoLayout];
    CGFloat padingLeft = left +self.padingLeftValue;
    return padingLeft;
}
- (CGFloat)xhss_LeftValueWithBorderForAutoLayout {
    CGFloat left = [self xhss_LeftValueForAutoLayout];
    CGFloat borderLeft = left -self.borderLeftValue;
    return borderLeft;
}
- (CGFloat)xhss_LeftValueWithMarginForAutoLayout {
    CGFloat left = [self xhss_LeftValueForAutoLayout];
    CGFloat marginLeft = left -self.borderLeftValue -self.marginLeftValue;
    return marginLeft;
}

// bottom
- (CGFloat)xhss_BottomValueForAutoLayout {
    return CGRectGetMaxY(self.frame);
}
- (CGFloat)xhss_BottomValueWithPadingForAutoLayout {
    CGFloat bottom = [self xhss_BottomValueForAutoLayout];
    CGFloat padingBottom = bottom -self.padingBottomValue;
    return padingBottom;
}
- (CGFloat)xhss_BottomValueWithBorderForAutoLayout {
    CGFloat bottom = [self xhss_BottomValueForAutoLayout];
    CGFloat borderBottom = bottom +self.borderBottomValue;
    return borderBottom;
}
- (CGFloat)xhss_BottomValueWithMarginForAutoLayout {
    CGFloat bottom = [self xhss_BottomValueForAutoLayout];
    CGFloat marginBottom = bottom +self.borderBottomValue +self.marginBottomValue;
    return marginBottom;
}

// right
- (CGFloat)xhss_RightValueForAutoLayout {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)xhss_RightValueWithPadingForAutoLayout {
    CGFloat right = [self xhss_RightValueForAutoLayout];
    CGFloat padingRight = right -self.padingRightValue;
    return padingRight;
}
- (CGFloat)xhss_RightValueWithBorderForAutoLayout {
    CGFloat right = [self xhss_RightValueForAutoLayout];
    CGFloat borderRight = right +self.borderRightValue;
    return borderRight;
}
- (CGFloat)xhss_RightValueWithMarginForAutoLayout {
    CGFloat right = [self xhss_RightValueForAutoLayout];
    CGFloat marginRight = right +self.borderRightValue +self.marginRightValue;
    return marginRight;
}

// width
- (CGFloat)xhss_WidthValueForAutoLayout {
    return self.layoutWidth;
}
- (CGFloat)xhss_WidthValueWithPadingForAutoLayout {
    CGFloat width = [self xhss_WidthValueForAutoLayout];
    CGFloat padingWidth = width -self.padingLeftValue -self.padingRightValue;
    return padingWidth;
}
- (CGFloat)xhss_WidthValueWithBorderForAutoLayout {
    CGFloat width = [self xhss_WidthValueForAutoLayout];
    CGFloat borderWidth = self.borderLeftValue +width +self.borderRightValue;
    return borderWidth;
}
- (CGFloat)xhss_WidthValueWithMarginForAutoLayout {
    CGFloat width = [self xhss_WidthValueForAutoLayout];
    CGFloat marginWidth = self.marginLeftValue +self.borderLeftValue
                            +width
                            +self.borderRightValue +self.marginRightValue;
    return marginWidth;
}

// height
- (CGFloat)xhss_HeightValueForAutoLayout {
    return self.layoutHeight;
}
- (CGFloat)xhss_HeightValueWithPadingForAutoLayout {
    CGFloat height = [self xhss_HeightValueForAutoLayout];
    CGFloat padingHeight = height -self.padingTopValue -self.padingBottomValue;
    return padingHeight;
}
- (CGFloat)xhss_HeightValueWithBorderForAutoLayout {
    CGFloat height = [self xhss_HeightValueForAutoLayout];
    CGFloat borderHeight = self.borderTopValue +height +self.borderBottomValue;
    return borderHeight;
}
- (CGFloat)xhss_HeightValueWithMarginForAutoLayout {
    CGFloat height = [self xhss_HeightValueForAutoLayout];
    CGFloat marginHeight = self.marginTopValue +self.borderTopValue
                            +height
                            +self.borderBottomValue +self.marginBottomValue;
    return marginHeight;
}


// origin
- (CGPoint)xhss_OriginPointForAutoLayout {
    return CGPointMake([self xhss_LeftValueForAutoLayout],
                       [self xhss_TopValueForAutoLayout]);
}
- (CGPoint)xhss_OriginPointWithPadingForAutoLayout {
    return CGPointMake([self xhss_LeftValueWithPadingForAutoLayout],
                       [self xhss_TopValueWithPadingForAutoLayout]);
}
- (CGPoint)xhss_OriginPointWithBorderForAutoLayout {
    return CGPointMake([self xhss_LeftValueWithBorderForAutoLayout],
                       [self xhss_TopValueWithBorderForAutoLayout]);
}
- (CGPoint)xhss_OriginPointWithMarginForAutoLayout {
    return CGPointMake([self xhss_LeftValueWithMarginForAutoLayout],
                       [self xhss_TopValueWithMarginForAutoLayout]);
}

@end

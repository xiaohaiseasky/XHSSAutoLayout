//
//  UIView+AutoLayoutPointAndValueUtils.h
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIView (AutoLayoutPointAndValueUtils)

// top
//- (CGFloat)xhss_TopValueForAutoLayout;
//- (CGFloat)xhss_TopValueWithPadingForAutoLayout;
//- (CGFloat)xhss_TopValueWithBorderForAutoLayout;
//- (CGFloat)xhss_TopValueWithMarginForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_TopValueForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_TopValueWithPadingForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_TopValueWithBorderForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_TopValueWithMarginForAutoLayout;

// left
//- (CGFloat)xhss_LeftValueForAutoLayout;
//- (CGFloat)xhss_LeftValueWithPadingForAutoLayout;
//- (CGFloat)xhss_LeftValueWithBorderForAutoLayout;
//- (CGFloat)xhss_LeftValueWithMarginForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_LeftValueForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_LeftValueWithPadingForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_LeftValueWithBorderForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_LeftValueWithMarginForAutoLayout;

// bottom
//- (CGFloat)xhss_BottomValueForAutoLayout;
//- (CGFloat)xhss_BottomValueWithPadingForAutoLayout;
//- (CGFloat)xhss_BottomValueWithBorderForAutoLayout;
//- (CGFloat)xhss_BottomValueWithMarginForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_BottomValueForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_BottomValueWithPadingForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_BottomValueWithBorderForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_BottomValueWithMarginForAutoLayout;

// right
//- (CGFloat)xhss_RightValueForAutoLayout;
//- (CGFloat)xhss_RightValueWithPadingForAutoLayout;
//- (CGFloat)xhss_RightValueWithBorderForAutoLayout;
//- (CGFloat)xhss_RightValueWithMarginForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_RightValueForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_RightValueWithPadingForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_RightValueWithBorderForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_RightValueWithMarginForAutoLayout;

// width
//- (CGFloat)xhss_WidthValueForAutoLayout;
//- (CGFloat)xhss_WidthValueWithPadingForAutoLayout;
//- (CGFloat)xhss_WidthValueWithBorderForAutoLayout;
//- (CGFloat)xhss_WidthValueWithMarginForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_WidthValueForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_WidthValueWithPadingForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_WidthValueWithBorderForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_WidthValueWithMarginForAutoLayout;

// height
//- (CGFloat)xhss_HeightValueForAutoLayout;
//- (CGFloat)xhss_HeightValueWithPadingForAutoLayout;
//- (CGFloat)xhss_HeightValueWithBorderForAutoLayout;
//- (CGFloat)xhss_HeightValueWithMarginForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_HeightValueForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_HeightValueWithPadingForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_HeightValueWithBorderForAutoLayout;
@property (nonatomic, assign, readonly) CGFloat xhss_HeightValueWithMarginForAutoLayout;


// origin
//- (CGPoint)xhss_OriginPointForAutoLayout;
//- (CGPoint)xhss_OriginPointWithPadingForAutoLayout;
//- (CGPoint)xhss_OriginPointWithBorderForAutoLayout;
//- (CGPoint)xhss_OriginPointWithMarginForAutoLayout;
@property (nonatomic, assign, readonly) CGPoint xhss_OriginPointForAutoLayout;
@property (nonatomic, assign, readonly) CGPoint xhss_OriginPointWithPadingForAutoLayout;
@property (nonatomic, assign, readonly) CGPoint xhss_OriginPointWithBorderForAutoLayout;
@property (nonatomic, assign, readonly) CGPoint xhss_OriginPointWithMarginForAutoLayout;

@end

NS_ASSUME_NONNULL_END

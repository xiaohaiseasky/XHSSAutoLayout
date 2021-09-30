//
//  UIView+AutoLayoutSizeUtils.h
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AutoLayoutSizeUtils)

#pragma mark - MinSize
//- (CGSize)xhss_MinSizeForAutoLayout;
//- (CGSize)xhss_MinSizeWithBorderForAutoLayout;
//- (CGSize)xhss_MinSizeWithPadingForAutoLayout;
//- (CGSize)xhss_MinSizeWithMarginForAutoLayout;
@property (nonatomic, assign, readonly) CGSize xhss_MinSizeForAutoLayout;
@property (nonatomic, assign, readonly) CGSize xhss_MinSizeWithBorderForAutoLayout;
@property (nonatomic, assign, readonly) CGSize xhss_MinSizeWithPadingForAutoLayout;
@property (nonatomic, assign, readonly) CGSize xhss_MinSizeWithMarginForAutoLayout;

#pragma mark - MaxSize
//- (CGSize)xhss_MaxSizeForAutoLayout;
//- (CGSize)xhss_MaxSizeWithBorderForAutoLayout;
//- (CGSize)xhss_MaxSizeWithPadingForAutoLayout;
//- (CGSize)xhss_MaxSizeWithMarginForAutoLayout;
@property (nonatomic, assign, readonly) CGSize xhss_MaxSizeForAutoLayout;
@property (nonatomic, assign, readonly) CGSize xhss_MaxSizeWithBorderForAutoLayout;
@property (nonatomic, assign, readonly) CGSize xhss_MaxSizeWithPadingForAutoLayout;
@property (nonatomic, assign, readonly) CGSize xhss_MaxSizeWithMarginForAutoLayout;

#pragma mark - Size Tool
// Width 固定
- (CGSize)xhss_FixedWidth:(CGFloat)widthValue forSize:(CGSize)size;
// Width 尽量大
- (CGSize)xhss_AsBigAsPossibleWidthForSize:(CGSize)size;
// Width 尽量小
- (CGSize)xhss_AsSmallAsPossibleWidthForSize:(CGSize)size;

// Height 固定
- (CGSize)xhss_FixedHeight:(CGFloat)heightValue forSize:(CGSize)size;
// Height 尽量大
- (CGSize)xhss_AsBigAsPossibleHeightForSize:(CGSize)size;
// Height 尽量小
- (CGSize)xhss_AsSmallAsPossibleHeightForSize:(CGSize)size;

// 用来布局子视图的参考 Width
- (CGFloat)xhss_BaseWidth;
// 用来布局子视图的参考 Height
- (CGFloat)xhss_BaseHeight;


//- (CGSize)xhss_marginSizeWithSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END

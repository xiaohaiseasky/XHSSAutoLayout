//
//  UIView+XHSSAutoLayoutCoreUtils.h
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XHSSAutoLayoutCoreUtils)

/* 某个视图是否能够进行布局 */
- (BOOL)__xhss_isViewLayoutAvailable:(UIView*)view;
/* 某个视图是否需要自动调整布局尺寸 */
- (BOOL)__xhss_ifViewNeedFlexLayout:(UIView*)view;
/* 是否 单行 或 单列 布局模式 */
- (BOOL)__xhss_isSingleLineLayout;
/* 是否副轴方向的整体布局方式可调整 */
- (BOOL)__xhss_isCrossAxisAligmentAvailable;

/* 获取给定长度下带外边距和边框宽度的长度 */
- (CGFloat)__xhss_marginLengthOfView:(UIView*)view
                          fromLength:(CGFloat)length
                        isAtMainAxis:(BOOL)isMainAxis;
/* 获取给定长度下不带外边距和边框宽度的长度 */
- (CGFloat)__xhss_lengthOfView:(UIView*)view
              fromMarginLength:(CGFloat)marginLength
                  isAtMainAxis:(BOOL)isMainAxis;
/* 给定 宽度/高度 通过宽高比计算对应 高度/宽度 */
- (CGFloat)__xhss_lengthOfView:(UIView*)view
          withWHRatioRefLength:(CGFloat)refLength
         refLengthIsAtMainAxis:(BOOL)refLengthIsAtMainAxis;
/* 给定主轴长度确定副轴长度 */
- (CGFloat)__xhss_crossAxisLayoutLengthOfView:(UIView*)view
                     withMainAxisLayoutLength:(CGFloat)mainAxisLength;

/* 通过给定 主轴/副轴 的长度获取一个参考布局 frame */
- (CGRect)__xhss_refLayoutFrameWithMainAxisLength:(CGFloat)mainAxisLength
                                  crossAxisLength:(CGFloat)crossAxisLength;
/* 获取一个 viewFrame 的 origin 在 主轴/副轴 的原点分量 */
- (CGFloat)__xhss_originComponentOfViewFrame:(CGRect)frame isMainAxis:(BOOL)isMainAxis;
/* 获取 Size 在 主轴/副轴 方向的长度 */
- (CGFloat)__xhss_lengthOfViewSize:(CGSize)viewSize isMainAxis:(BOOL)isMainAxis;
/* 获取 View 在 主轴/副轴 方向的长度 */
- (CGFloat)__xhss_layoutLengthOfView:(UIView*)view isMainAxis:(BOOL)isMainAxis;
/* 获取 View 在 主轴/副轴 方向的最小布局长度 */
- (CGFloat)__xhss_layoutMinLengthOfView:(UIView*)view isMainAxis:(BOOL)isMainAxis;
/* 获取 View 在 主轴/副轴 方向对子视图布局的起点 */
- (CGFloat)__xhss_layoutStartIsMainAxis:(BOOL)isMainAxis;
/* 检查布局意图是否合法 */
- (void)__xhss_CheckLayoutAvailable;
/* 如果自身设置了固定的 Width 或 Height 则获取固定的 Width 或 Height */
- (CGFloat)__xhss_fixedLength;
/* 获取视图自身在 主轴/副轴 方向的固定长度 */
- (CGFloat)__xhss_fixedLengthIsMainAxis:(BOOL)isMainAxis;
/* 副轴方向开始布局的位置 */
- (CGFloat)__xhss_crossAxisLayoutStart;
/* 布局参考的 Size */
- (CGSize)__xhss_PreLayoutSizeWithMargin;

@end

NS_ASSUME_NONNULL_END

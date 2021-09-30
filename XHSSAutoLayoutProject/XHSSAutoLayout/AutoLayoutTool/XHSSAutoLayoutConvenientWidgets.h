//
//  XHSSAutoLayoutConvenientWidgets.h
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XHSSAutoLayoutConvenientWidgets : UIView

+ (UIView*)flexSpace;
+ (UIView*)flexSpaceWithFlexValue:(CGFloat)flex;
+ (UIView*)flexSpaceWithFlexValue:(CGFloat)flex priority:(NSInteger)priority;

@end

NS_ASSUME_NONNULL_END

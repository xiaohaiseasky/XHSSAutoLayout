//
//  UIView+AutoLayoutCore.h
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import <UIKit/UIKit.h>
#import "UIView+XHSSAutoLayoutProperty.h"


NS_ASSUME_NONNULL_BEGIN


#define kXHSS_ALLOW_LAYOUT_SPACE 60


@interface UIView (AutoLayoutCore)

- (void)xhss_PerformAutoLayout;

@end

NS_ASSUME_NONNULL_END

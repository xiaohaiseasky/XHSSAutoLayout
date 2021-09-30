//
//  UIView+AutoLayoutFrameUtils.m
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import "UIView+XHSSAutoLayoutFrameUtils.h"
#import "UIView+XHSSAutoLayoutProperty.h"
#import "UIView+XHSSAutoLayoutPointAndValueUtils.h"
#import "UIView+XHSSAutoLayoutSizeUtils.h"


@implementation UIView (AutoLayoutFrameUtils)

- (CGRect)xhss_RealFrameForAutoLayout {
    return self.frame;
}

- (CGRect)xhss_FrameWithPadingForAutoLayout {
    CGPoint pdgingOrigin = self.xhss_OriginPointWithPadingForAutoLayout;
    CGSize pdgingSize = self.xhss_MinSizeWithPadingForAutoLayout;
    CGRect padingFrame = CGRectMake(pdgingOrigin.x,
                                    pdgingOrigin.y,
                                    pdgingSize.width,
                                    pdgingSize.height);
    return padingFrame;
}

- (CGRect)xhss_FrameWithBorderForAutoLayout {
    CGPoint borderedOrigin = self.xhss_OriginPointWithBorderForAutoLayout;
    CGSize borderedSize = self.xhss_MinSizeWithBorderForAutoLayout;
    CGRect borderFrame = CGRectMake(borderedOrigin.x,
                                    borderedOrigin.y,
                                    borderedSize.width,
                                    borderedSize.height);
    return borderFrame;
}

- (CGRect)xhss_FrameWithMarginForAutoLayout {
    CGPoint marginOrigin = self.xhss_OriginPointWithMarginForAutoLayout;
    CGSize marginSize = self.xhss_MinSizeWithMarginForAutoLayout;
    CGRect marginFrame = CGRectMake(marginOrigin.x,
                                    marginOrigin.y,
                                    marginSize.width,
                                    marginSize.height);
    return marginFrame;
}

- (void)setXhss_FrameWithMarginForAutoLayout:(CGRect)marginFrame {
    CGRect frame = CGRectMake(marginFrame.origin.x
                              +self.marginLeftValue
                              +self.borderLeftValue,
                              
                              marginFrame.origin.y
                              +self.marginTopValue
                              +self.borderTopValue,
                              
                              marginFrame.size.width
                              -self.marginLeftValue
                              -self.borderLeftValue
                              -self.borderRightValue
                              -self.marginRightValue,
                              
                              marginFrame.size.height
                              -self.marginTopValue
                              -self.borderTopValue
                              -self.borderBottomValue
                              -self.marginBottomValue);
    self.frame = frame;
}

@end

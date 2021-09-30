//
//  XHSSAutoLayoutConvenientWidgets.m
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import "XHSSAutoLayoutConvenientWidgets.h"
#import "UIView+XHSSAutoLayoutProperty.h"


@implementation XHSSAutoLayoutConvenientWidgets

#pragma mark - Space
+ (UIView*)flexSpace {
    return [self flexSpaceWithFlexValue:1];
}

+ (UIView*)flexSpaceWithFlexValue:(CGFloat)flex {
    return [self flexSpaceWithFlexValue:flex priority:1];
}

+ (UIView*)flexSpaceWithFlexValue:(CGFloat)flex priority:(NSInteger)priority {
    UIView* flexSpace = [[UIView alloc] init];
    flexSpace.layoutFlex = flex;
    flexSpace.layoutPriority = priority;
    flexSpace.layoutSizeMode = XHSSLayoutSizeMode_Flexable;
    flexSpace.layoutWidth = 0.5;
    flexSpace.layoutHeight = 0.5;
    return flexSpace;
}

#pragma mark - Row


#pragma mark - Column


@end

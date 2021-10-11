//
//  XHSSAutoLayoutConvenientWidgets.m
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import "XHSSAutoLayoutConvenientWidgets.h"
#import "UIView+XHSSAutoLayoutProperty.h"

typedef NS_ENUM(NSUInteger, XHSSALType) {
    __XHSSALContainer,
    __XHSSALCenter,
    __XHSSALAlign,
    __XHSSALRow,
    __XHSSALColum,
    __XHSSALFlexSpace,
    __XHSSALSizedSpace,
};




@implementation XHSSAutoLayoutConvenientWidgets

+ (UIView*)autoLayoutContainnerByType:(XHSSALType)ALType {
    switch (ALType) {
        case __XHSSALContainer: {
            return [self __xhss_createAutoLayoutContainner];
        } break;
        case __XHSSALCenter: {
            return [self __xhss_createAutoLayoutCenter];
        } break;
        case __XHSSALAlign: {
            return [self __xhss_createAutoLayoutAlign];
        } break;
        case __XHSSALRow: {
            return [self __xhss_createAutoLayoutRow];
        } break;
        case __XHSSALColum: {
            return [self __xhss_createAutoLayoutColum];
        } break;
        case __XHSSALFlexSpace: {
            return [self __xhss_createAutoLayoutFlexSpace];
        } break;
        case __XHSSALSizedSpace: {
            return [self __xhss_createAutoLayoutSizedSpace];
        } break;
            
        default:
            break;
    }
    return [[UIView alloc] init];
}


#pragma mark - XHSSALContainer
+ (UIView*)__xhss_createAutoLayoutContainner {
    UIView* containner = [[UIView alloc] init];
    return containner;
}

#pragma mark - XHSSALCenter
+ (UIView*)__xhss_createAutoLayoutCenter {
    UIView* center = [[UIView alloc] init];
    center.mainAxisAligment = XHSSLayoutAxisAligment_Center;
    center.crossAxisAligment = XHSSLayoutAxisAligment_Center;
    return center;
}

#pragma mark - XHSSALAlign
+ (UIView*)__xhss_createAutoLayoutAlign {
    UIView* align = [[UIView alloc] init];
    align.mainAxisAligment = XHSSLayoutAxisAligment_Start;
    align.crossAxisAligment = XHSSLayoutAxisAligment_Start;
    return align;
}

#pragma mark - XHSSALRow
+ (UIView*)__xhss_createAutoLayoutRow {
    UIView* row = [[UIView alloc] init];
    row.mainLayoutType = XHSSLayoutType_Row;
    row.mainAxisCrossAligment = XHSSLayoutAxisAligment_Center;
    return row;
}

#pragma mark - XHSSALColum
+ (UIView*)__xhss_createAutoLayoutColum {
    UIView* colum = [[UIView alloc] init];
    colum.mainLayoutType = XHSSLayoutType_Column;
    colum.mainAxisCrossAligment = XHSSLayoutAxisAligment_Center;
    return colum;
}

#pragma mark - XHSSALFlexSpace
+ (UIView*)__xhss_createAutoLayoutFlexSpace {
    return [self __xhss_flexSpace];
}
+ (UIView*)__xhss_flexSpace {
    return [self __xhss_flexSpaceWithFlexValue:1];
}
+ (UIView*)__xhss_flexSpaceWithFlexValue:(CGFloat)flex {
    return [self __xhss_flexSpaceWithFlexValue:flex priority:1];
}
+ (UIView*)__xhss_flexSpaceWithFlexValue:(CGFloat)flex priority:(NSInteger)priority {
    UIView* flexSpace = [[UIView alloc] init];
    flexSpace.layoutFlex = flex;
    flexSpace.layoutPriority = priority;
    flexSpace.layoutSizeMode = XHSSLayoutSizeMode_Flexable;
    flexSpace.layoutWidth = 0.5;
    flexSpace.layoutHeight = 0.5;
    return flexSpace;
}

#pragma mark - XHSSALSizedSpace
+ (UIView*)__xhss_createAutoLayoutSizedSpace {
    UIView* sizedSpace = [[UIView alloc] init];
    sizedSpace.layoutWidth = 60;
    sizedSpace.layoutHeight = 60;
    return sizedSpace;
}

@end


kXHSS_CLASS_IMPLEMENTATION(XHSSALContainer)
kXHSS_CLASS_IMPLEMENTATION(XHSSALCenter)
kXHSS_CLASS_IMPLEMENTATION(XHSSALAlign)
kXHSS_CLASS_IMPLEMENTATION(XHSSALRow)
kXHSS_CLASS_IMPLEMENTATION(XHSSALColum)
kXHSS_CLASS_IMPLEMENTATION(XHSSALFlexSpace)
kXHSS_CLASS_IMPLEMENTATION(XHSSALSizedSpace)

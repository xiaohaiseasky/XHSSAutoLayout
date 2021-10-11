//
//  UIView+AutoLayoutProperty.h
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    XHSSLayoutType_HorizontalFlow,
    XHSSLayoutType_VerticleFlow,
    XHSSLayoutType_Row,
    XHSSLayoutType_Column,
    XHSSLayoutType_Stack,
} XHSSLayoutType;

typedef enum : NSUInteger {
    XHSSLayoutAxisAligment_Start,
    XHSSLayoutAxisAligment_Center,
    XHSSLayoutAxisAligment_End,
} XHSSLayoutAxisAligment;

typedef enum : NSUInteger {
    XHSSLayoutSizeMode_Fixed,
    XHSSLayoutSizeMode_Compress,
    XHSSLayoutSizeMode_Stretch,
    XHSSLayoutSizeMode_Flexable,
} XHSSLayoutSizeMode;


typedef NS_OPTIONS(NSUInteger, XHSSLayoutPadingOption) {
    Pading_None     = 0x00U,
    Pading_Top      = (1UL << 0),
    Pading_Left     = (1UL << 1),
    Pading_Bottom   = (1UL << 2),
    Pading_Right    = (1UL << 3),
    Pading_All      = 0x0FU,
};

typedef NS_OPTIONS(NSUInteger, XHSSLayoutBorderOption) {
    Border_None     = 0x00U,
    Border_Top      = (1UL << 0),
    Border_Left     = (1UL << 1),
    Border_Bottom   = (1UL << 2),
    Border_Right    = (1UL << 3),
    Border_All      = 0x0FU,
};

typedef NS_OPTIONS(NSUInteger, XHSSLayoutMarginOption) {
    Margin_None     = 0x00U,
    Margin_Top      = (1UL << 0),
    Margin_Left     = (1UL << 1),
    Margin_Bottom   = (1UL << 2),
    Margin_Right    = (1UL << 3),
    Margin_All      = 0x0FU,
};




@interface UIView (AutoLayoutProperty)

/*
 * 视图布局的方式，枚举类型 [XHSSLayoutType] 枚举值含义如下：
    XHSSLayoutType_HorizontalFlow,  水平方向优先流式布局，一行内容纳不下自动布局到下一行
    XHSSLayoutType_VerticleFlow,    垂直方向优先流式布局，一列内容纳不下自动布局到下一列
    XHSSLayoutType_Row,             水平方向优先单行布局，一行内容纳不下不会自动换行
    XHSSLayoutType_Column,          垂直方向优先单列布局，一列内容纳不下不会自动换列
*/
@property (nonatomic, assign) XHSSLayoutType mainLayoutType;

/*
 * 布局主轴方向的整体对齐方式，枚举类型 [XHSSLayoutAxisAligment] 枚举值含义如下：
    XHSSLayoutAxisAligment_Start,   主轴方向是水平方向则整体靠左对齐，主轴方向是垂直方向则整体靠上对齐
    XHSSLayoutAxisAligment_Center,  主轴方向整体居中对齐
    XHSSLayoutAxisAligment_End,     主轴方向是水平方向则整体靠右对齐，主轴方向是垂直方向则整体靠下对齐
 */
@property (nonatomic, assign) XHSSLayoutAxisAligment mainAxisAligment;

/*
 * 布局副轴方向的整体对齐方式，枚举类型 [XHSSLayoutAxisAligment] 枚举值含义如下：
    XHSSLayoutAxisAligment_Start,   副轴方向是水平方向则整体靠左对齐，副轴方向是垂直方向则整体靠上对齐
    XHSSLayoutAxisAligment_Center,  副轴方向整体居中对齐
    XHSSLayoutAxisAligment_End,     副轴方向是水平方向则整体靠右对齐，副轴方向是垂直方向则整体靠下对齐
 */
@property (nonatomic, assign) XHSSLayoutAxisAligment crossAxisAligment;

/*
 * 布局主轴方向的 每一行/列 在和主轴垂直方向的对齐方式，枚举类型 [XHSSLayoutAxisAligment] 枚举值含义如下：
     XHSSLayoutAxisAligment_Start,   主轴方向是水平方向则 每一行子视图顶部对齐，主轴方向是垂直方向则 每一列子视图左边对齐
     XHSSLayoutAxisAligment_Center,  主轴方向是水平方向则 每一行子视图水平居中对齐，主轴方向是垂直方向则 每一列子视图垂直居中对齐
     XHSSLayoutAxisAligment_End,     主轴方向是水平方向则 每一行子视图底部对齐，主轴方向是垂直方向则 每一列子视图右边对齐
 */
@property (nonatomic, assign) XHSSLayoutAxisAligment mainAxisCrossAligment;

// ~~ Pading ~~
//@property (nonatomic, assign) XHSSLayoutPadingOption padingOption;
/*
 设置当前布局视图的内边距，设置内边距后此视图的子视图会从相应的边对应的内边距值开始布局。此属性只用在同时设置视图的 上下左右 四个内边距，不可用来获取内边距。
 */
@property (nonatomic, assign) CGFloat padingValue;
/* 设置当前布局视图的顶部内边距 */
@property (nonatomic, assign) CGFloat padingTopValue;
/* 设置当前布局视图的左侧内边距 */
@property (nonatomic, assign) CGFloat padingLeftValue;
/* 设置当前布局视图的下部内边距 */
@property (nonatomic, assign) CGFloat padingBottomValue;
/* 设置当前布局视图的右侧内边距 */
@property (nonatomic, assign) CGFloat padingRightValue;

// ~~ Border ~~
//@property (nonatomic, assign) XHSSLayoutBorderOption borderOption;
/*
 设置当前布局视图的边框宽度，设置边框宽度后此视图的自身布局尺寸会在其size基础上加上相应的边框宽度【边框宽度可以使用 外边距  达到效果，所以边框属性不常用】。此属性只用在同时设置视图的 上下左右 四个边框宽度，不可用来获取边框宽度。
 */
@property (nonatomic, assign) CGFloat borderValue;
/* 设置当前布局视图的顶部边框宽度 */
@property (nonatomic, assign) CGFloat borderTopValue;
/* 设置当前布局视图的左侧边框宽度 */
@property (nonatomic, assign) CGFloat borderLeftValue;
/* 设置当前布局视图的下部边框宽度 */
@property (nonatomic, assign) CGFloat borderBottomValue;
/* 设置当前布局视图的右侧边框宽度 */
@property (nonatomic, assign) CGFloat borderRightValue;

// ~~ Margin ~~
//@property (nonatomic, assign) XHSSLayoutMarginOption marginOption;
/*
 设置当前布局视图的外边距，设置外边距后此视图的自身布局尺寸会在其size基础上加上相应的外边距。此属性只用在同时设置视图的 上下左右 四个外边距，不可用来获取外边距。
 */
@property (nonatomic, assign) CGFloat marginValue;
/* 设置当前布局视图的顶部外边距 */
@property (nonatomic, assign) CGFloat marginTopValue;
/* 设置当前布局视图的左侧外边距 */
@property (nonatomic, assign) CGFloat marginLeftValue;
/* 设置当前布局视图的下部外边距 */
@property (nonatomic, assign) CGFloat marginBottomValue;
/* 设置当前布局视图的右侧外边距 */
@property (nonatomic, assign) CGFloat marginRightValue;

// ~~ Width & Height ~~
/* 设置当前布局视图的宽度 */
@property (nonatomic, assign) CGFloat layoutWidth;
/* 设置当前布局视图的高度 */
@property (nonatomic, assign) CGFloat layoutHeight;
/* 设置当前布局视图的最小宽度，只在当前视图需要被压缩以适应布局宽度的时候生效 */
@property (nonatomic, assign) CGFloat layoutMinWidth;
/* 设置当前布局视图的最小高度，只在当前视图需要被压缩以适应布局高度的时候生效 */
@property (nonatomic, assign) CGFloat layoutMinHeight;

//
/*
 每一 行/列 子视图之间的间距是否平分【只在 单行/列 布局生效】。此属性只用在同时设置视图的 主轴/副轴 方向子视图之间的间距是否平分，不可用来获取相应值。
 */
@property (nonatomic, assign) BOOL isExpending;

/*
 主轴方向是水平方向则 每一行子视图之间的间距是否平分，主轴方向是垂直方向则 每一列子视图之间的间距是否平分。【只在 单行/列 布局生效】
 */
@property (nonatomic, assign) BOOL isMainAxisExpending;

/*
 主轴方向是水平方向则 每一列子视图之间的间距是否平分，主轴方向是垂直方向则 每一行子视图之间的间距是否平分。【只在 单行/列 布局生效】
 */
@property (nonatomic, assign) BOOL isCrossAxisExpending;

/* 用来指定当视图需要在主轴/副轴方向被拉伸或压缩来适应布局空间时候的权重，当同时有多个视图需要被拉伸或压缩时权重分配的越大视图占据的空间越多，分配规则是 : 所有剩余布局空间*(当前视图的权重值/所有需要伸缩布局的视图的权重和)。
 */
@property (nonatomic, assign) CGFloat layoutFlex;

/*
 用来指定当视图需要在主轴/副轴方向被拉伸或压缩来适应布局空间时候的优先级，当同时有多个视图需要被拉伸或压缩时优先级越高的视图越会优先被拉伸/压缩，当高优先级的视图被压缩到最小宽度/长度，才会对更低优先级的视图进行拉伸/压缩。【只在 单行/列 布局生效】
 */
@property (nonatomic, assign) NSInteger layoutPriority;

/*
 当视图需要拉伸/压缩布局时指定拉伸行为【只在 单行/列 布局生效】。枚举类型 [XHSSLayoutSizeMode] 枚举值含义如下：
     XHSSLayoutSizeMode_Fixed, 不可被拉伸或压缩
     XHSSLayoutSizeMode_Compress, 只能被压缩，不能被拉伸
     XHSSLayoutSizeMode_Stretch, 只能被拉伸，不能被压缩
     XHSSLayoutSizeMode_Flexable, 可以被拉伸或压缩
 */
@property (nonatomic, assign) XHSSLayoutSizeMode layoutSizeMode;

/* 当视图的宽度或高度没有被指定时，通过指定的比例用已知的宽度或高度设置未被指定的高度或宽度 */
@property (nonatomic, assign) CGFloat layoutWHRatio;

/* 当视图的所有子视图布局完成后是否根据子视图的布局情况调整自身尺寸 */
@property (nonatomic, assign) BOOL needResizeSelfBySubview;

//@property (nonatomic, assign) BOOL floatType;
//@property (nonatomic, assign) BOOL allowOutOfBounds;    // 是否允许超出自身 frame 边界布局

@end

NS_ASSUME_NONNULL_END

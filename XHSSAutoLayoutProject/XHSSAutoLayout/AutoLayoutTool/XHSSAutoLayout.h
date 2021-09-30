//
//  XHSSAutoLayout.h
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//


#import "UIView+XHSSAutoLayoutCore.h"
#import "XHSSAutoLayoutConvenientWidgets.h"


/*
 ** 注意：此工具只是实现了OC中以声明的方式进行布局的想法，还未进行严格的测试调优，并且还有很多地方需要完善和补充 **
 
 一个参考盒子模型的自动布局工具，以声明的方式对视图进行布局，相关说明如下：
 
 一、布局规则(以横向布局为主布局方向为列)：
    1、流式布局：
        1.1) 当前子视图是固定宽度不可被拉伸或压缩：
            (1.1.1) 如果父视图宽度可以容纳当前布局的子视图，则在行末布局当前子视图
            (1.1.2) 如果父视图宽度无法容纳当前布局的子视图，则当前子视图自动换行到下一行开始布局
        1.2) 当前子视图可以被拉伸或压缩：
            (1.2.1) 如果当前子视图是当前行的第一个子视图：
                <1.2.1.1> 下一个子视图是不可被拉伸或压缩的，则当前子视图和后续若干个(宽度和 <= 父视图宽度 - 最小可允许布局空间 )固定宽度子视图在同一行布局
                <1.2.1.2> 后续有一个或多个连续的可被拉伸或压缩的子视图，则当前子视图和后续的连续可被拉伸或压缩子视图放在当前一行布局，每个子视图的宽度由自身分配的权重(layoutFlex)决定，权重越大分配的宽度越大
                <1.2.1.3> 如果当前子视图是最后一个需要布局的子视图(这一行只有这一个子视图)，则当前子视图放在当前行适应父视图宽度
            (1.2.2) 如果当前子视图不是当前行的第一个子视图：
                <1.2.2.1> 当前行所剩布局空间大于等于某个允许的值(最小可允许布局空间)，则当前子视图放在本行末尾布局，宽度适应本行剩余可用空间
                <1.2.2.2> 当前行所剩布局空间小于某个允许的值(最小可允许布局空间)，则当前子视图放在下一行的开始布局(转到 1.2.1)
 
    2、单行布局：
        1) 如果所有子视图都是固定宽度不可被拉伸或压缩，则计算所有子视图宽度，如果所有子视图宽度小于父视图宽度则可以正常布局，否则报错
        2) 如果有子视图设置了可以被拉伸或压缩，则根据可被拉伸或压缩的所有子视图的 尺寸模式(layoutSizeMode)、权重(layoutFlex)、优先级(layoutPriority) 计算出最小固定宽度，如果最小固定宽度小于父视图宽度则可以正常布局，否则报错
            (2.1) 如果所有子视图的宽度大于父视图的宽度，则处于压缩布局模式
                压缩模式下计算所有子视图中 尺寸模式(layoutSizeMode) 为固定宽度(XHSSLayoutSizeMode_Fixed)、只能拉伸(XHSSLayoutSizeMode_Stretch) 的子视图的宽度和，可用布局空间是父视图宽度减去这个宽度和，其余自动适应宽度的每个子视图的宽度在大于等于自身最小宽度(layoutMinWidth)前提下由自身分配的权重(layoutFlex)决定，权重越大分配的宽度越大。如果子视图设置了优先级(layoutPriority)， 则根据优先级从高到低决定哪些子视图首先被压缩
            (2.1) 如果所有子视图的宽度小于等于父视图的宽度，则处于拉伸布局模式
                拉伸模式下计算所有子视图中 尺寸模式(layoutSizeMode) 为固定宽度(XHSSLayoutSizeMode_Fixed)、只能压缩(XHSSLayoutSizeMode_Compress) 的子视图的宽度和，可用布局空间是父视图宽度减去这个宽度和，其余自动适应宽度的每个子视图的宽度在大于等于自身最小宽度(layoutMinWidth)前提下由自身分配的权重(layoutFlex)决定，权重越大分配的宽度越大。如果子视图设置了优先级(layoutPriority)， 则根据优先级从高到低决定哪些子视图首先被拉伸
 
 
 二、属性说明：
    * mainLayoutType 视图布局的方式，枚举类型 [XHSSLayoutType] 枚举值含义如下：
       XHSSLayoutType_HorizontalFlow,  水平方向优先流式布局，一行内容纳不下自动布局到下一行
       XHSSLayoutType_VerticleFlow,    垂直方向优先流式布局，一列内容纳不下自动布局到下一列
       XHSSLayoutType_Row,             水平方向优先单行布局，一行内容纳不下不会自动换行
       XHSSLayoutType_Column,          垂直方向优先单列布局，一列内容纳不下不会自动换列

    * mainAxisAligment 布局主轴方向的整体对齐方式，枚举类型 [XHSSLayoutAxisAligment] 枚举值含义如下：
       XHSSLayoutAxisAligment_Start,   主轴方向是水平方向则整体靠左对齐，主轴方向是垂直方向则整体靠上对齐
       XHSSLayoutAxisAligment_Center,  主轴方向整体居中对齐
       XHSSLayoutAxisAligment_End,     主轴方向是水平方向则整体靠右对齐，主轴方向是垂直方向则整体靠下对齐

    * crossAxisAligment 布局副轴方向的整体对齐方式，枚举类型 [XHSSLayoutAxisAligment] 枚举值含义如下：
       XHSSLayoutAxisAligment_Start,   副轴方向是水平方向则整体靠左对齐，副轴方向是垂直方向则整体靠上对齐
       XHSSLayoutAxisAligment_Center,  副轴方向整体居中对齐
       XHSSLayoutAxisAligment_End,     副轴方向是水平方向则整体靠右对齐，副轴方向是垂直方向则整体靠下对齐

    * mainAxisCrossAligment 布局主轴方向的 每一行/列 在和主轴垂直方向的对齐方式，枚举类型 [XHSSLayoutAxisAligment] 枚举值含义如下：
        XHSSLayoutAxisAligment_Start,   主轴方向是水平方向则 每一行子视图顶部对齐，主轴方向是垂直方向则 每一列子视图左边对齐
        XHSSLayoutAxisAligment_Center,  主轴方向是水平方向则 每一行子视图水平居中对齐，主轴方向是垂直方向则 每一列子视图垂直居中对齐
        XHSSLayoutAxisAligment_End,     主轴方向是水平方向则 每一行子视图底部对齐，主轴方向是垂直方向则 每一列子视图右边对齐

//// Pading
    * padingValue 设置当前布局视图的内边距，设置内边距后此视图的子视图会从相应的边对应的内边距值开始布局。此属性只用在同时设置视图的 上下左右 四个内边距，不可用来获取内边距。
    * padingTopValue 设置当前布局视图的顶部内边距
    * padingLeftValue 设置当前布局视图的左侧内边距
    * padingBottomValue 设置当前布局视图的下部内边距
    * padingRightValue 设置当前布局视图的右侧内边距

//// Border
    * borderValue 设置当前布局视图的边框宽度，设置边框宽度后此视图的自身布局尺寸会在其size基础上加上相应的边框宽度【边框宽度可以使用 外边距  达到效果，所以边框属性不常用】。此属性只用在同时设置视图的 上下左右 四个边框宽度，不可用来获取边框宽度。
    * borderTopValue 设置当前布局视图的顶部边框宽度
    * borderLeftValue 设置当前布局视图的左侧边框宽度
    * borderBottomValue 设置当前布局视图的下部边框宽度
    * borderRightValue 设置当前布局视图的右侧边框宽度

//// Margin
    * marginValue 设置当前布局视图的外边距，设置外边距后此视图的自身布局尺寸会在其size基础上加上相应的外边距。此属性只用在同时设置视图的 上下左右 四个外边距，不可用来获取外边距。
    * marginTopValue 设置当前布局视图的顶部外边距
    * marginLeftValue 设置当前布局视图的左侧外边距
    * marginBottomValue 设置当前布局视图的下部外边距
    * marginRightValue 设置当前布局视图的右侧外边距

//// Width & Height
    * layoutWidth 设置当前布局视图的宽度
    * layoutHeight 设置当前布局视图的高度
    * layoutMinWidth 设置当前布局视图的最小宽度，只在当前视图需要被压缩以适应布局宽度的时候生效
    * layoutMinHeight 设置当前布局视图的最小高度，只在当前视图需要被压缩以适应布局高度的时候生效

    * isExpending 每一 行/列 子视图之间的间距是否平分【只在 单行/列 布局生效】。此属性只用在同时设置视图的 主轴/副轴 方向子视图之间的间距是否平分，不可用来获取相应值。
    * isMainAxisExpending 主轴方向是水平方向则 每一行子视图之间的间距是否平分，主轴方向是垂直方向则 每一列子视图之间的间距是否平分。【只在 单行/列 布局生效】
    * isCrossAxisExpending 主轴方向是水平方向则 每一列子视图之间的间距是否平分，主轴方向是垂直方向则 每一行子视图之间的间距是否平分。【只在 单行/列 布局生效】
    * layoutFlex 用来指定当视图需要在主轴/副轴方向被拉伸或压缩来适应布局空间时候的权重，当同时有多个视图需要被拉伸或压缩时权重分配的越大视图占据的空间越多，分配规则是 : 所有剩余布局空间*(当前视图的权重值/所有需要伸缩布局的视图的权重和)。
    * layoutPriority 用来指定当视图需要在主轴/副轴方向被拉伸或压缩来适应布局空间时候的优先级，当同时有多个视图需要被拉伸或压缩时优先级越高的视图越会优先被拉伸/压缩，当高优先级的视图被压缩到最小宽度/长度，才会对更低优先级的视图进行拉伸/压缩。【只在 单行/列 布局生效】
    * layoutSizeMode 当视图需要拉伸/压缩布局时指定拉伸行为【只在 单行/列 布局生效】。枚举类型 [XHSSLayoutSizeMode] 枚举值含义如下：
        XHSSLayoutSizeMode_Fixed, 不可被拉伸或压缩
        XHSSLayoutSizeMode_Compress, 只能被压缩，不能被拉伸
        XHSSLayoutSizeMode_Stretch, 只能被拉伸，不能被压缩
        XHSSLayoutSizeMode_Flexable, 可以被拉伸或压缩

    * layoutWHRatio 当视图的宽度或高度没有被指定时，通过指定的比例用已知的宽度或高度设置未被指定的高度或宽度。
    * needResizeSelfBySubview 当视图的所有子视图布局完成后是否根据子视图的布局情况调整自身尺寸。
*/

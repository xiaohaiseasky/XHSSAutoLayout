//
//  XHSSAutoLayoutConvenientWidgets.h
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 基础布局组件：
            Container(容器布局)，
            Center(居中布局)，
            Padding(填充布局)，
            Align(对齐布局)，
            Colum（垂直布局），
            Row（水平布局），
            Expanded（配合Colum，Row使用），
            FittedBox（缩放布局），
            Stack（堆叠布局），
            overflowBox(溢出父视图容器)。
 
 * 宽高尺寸处理：
            SizedBox（设置具体尺寸），
            ConstrainedBox（限定最大最小宽高布局），
            LimitedBox（限定最大宽高布局），
            AspectRatio（调整宽高比），
            FractionallySizedBox（百分比布局）
        
 * 列表和表格处理：
            ListView（列表），
            GridView（网格），
            Table（表格）
 
 * 其它布局处理：
            Transform（矩阵转换），
            Baseline（基准线布局），
            Offstage（控制是否显示组件），
            Wrap（按宽高自动换行布局）
 */


#define kXHSS_CLASS_INTERFACE(className) \
            @interface className : UIView \
            + (UIView*)create; \
            @end

#define kXHSS_CLASS_IMPLEMENTATION(className) \
            @implementation className \
            + (UIView*)create { \
                return [XHSSAutoLayoutConvenientWidgets autoLayoutContainnerByType:__##className]; \
            } \
            @end


@interface XHSSAutoLayoutConvenientWidgets : NSObject
@end

kXHSS_CLASS_INTERFACE(XHSSALContainer)
kXHSS_CLASS_INTERFACE(XHSSALCenter)
kXHSS_CLASS_INTERFACE(XHSSALAlign)
kXHSS_CLASS_INTERFACE(XHSSALRow)
kXHSS_CLASS_INTERFACE(XHSSALColum)
kXHSS_CLASS_INTERFACE(XHSSALFlexSpace)
kXHSS_CLASS_INTERFACE(XHSSALSizedSpace)

NS_ASSUME_NONNULL_END

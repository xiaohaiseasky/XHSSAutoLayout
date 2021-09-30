//
//  UIView+AutoLayoutSizeUtils.m
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import "UIView+XHSSAutoLayoutSizeUtils.h"
#import "UIView+XHSSAutoLayoutProperty.h"
#import "UIView+XHSSAutoLayoutPointAndValueUtils.h"


@implementation UIView (AutoLayoutSizeUtils)

#pragma mark - MinSize
- (CGSize)xhss_MinSizeForAutoLayout {
    // 有文本内容的 UIView 子类需要计算文本内容尺寸
    NSString* text = @"";
    UIColor* textColor = nil;
    UIFont* font = nil;
    
    // Label
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel* label = self;
        text = label.text;
        textColor = label.textColor;
        font = label.font;
    }
    // TextField
    else if ([self isKindOfClass:[UITextField class]]) {
        UITextField* textField = self;
        text = textField.text;
        textColor = textField.textColor;
        font = textField.font;
    }
    // TextView
    else if ([self isKindOfClass:[UITextView class]]) {
        UITextView* textView = self;
        text = textView.text;
        textColor = textView.textColor;
        font = textView.font;
    }
    // Button
    else if ([self isKindOfClass:[UIButton class]]) {
        UIButton* btn = self;
        text = btn.titleLabel.text;
        textColor = btn.titleLabel.textColor;
        font = btn.titleLabel.font;
    }
    // UICollectionView
    else if ([self isKindOfClass:[UICollectionView class]]) {
        return CGSizeMake(self.layoutWidth, self.layoutHeight);
    }
    // UITableView
    else if ([self isKindOfClass:[UITableView class]]) {
        return CGSizeMake(self.layoutWidth, self.layoutHeight);
    }
    // UIScrollView
    else if ([self isKindOfClass:[UIScrollView class]]) {
        return CGSizeMake(self.layoutWidth, self.layoutHeight);
    }
    // 没有文本内容的 UIView 或 UIView 的子类
    else {
        return CGSizeMake(self.layoutWidth, self.layoutHeight);
    }
    
    return [self __xhss_autoTextSize:text textAttribute:@{
                                                            NSFontAttributeName: font,
                                                            NSForegroundColorAttributeName: textColor,
                                                        }];
}

- (CGSize)xhss_MinSizeWithPadingForAutoLayout {
    CGSize size = [self xhss_MinSizeForAutoLayout];
    //CGSize borderSize = [self xhss_MinSizeWithBorderForAutoLayout];
    CGSize padingSize = CGSizeMake( size.width
                                   -self.padingLeftValue
                                   -self.padingRightValue, // width
                                    size.height
                                   -self.padingTopValue
                                   -self.padingBottomValue // height
                                   );
    return padingSize;
}

- (CGSize)xhss_MinSizeWithBorderForAutoLayout {
    CGSize size = [self xhss_MinSizeForAutoLayout];
    CGSize borderSize = CGSizeMake( self.borderLeftValue
                                   +size.width
                                   +self.borderRightValue, // width
                                    self.borderTopValue
                                   +size.height
                                   +self.borderBottomValue // height
                                   );
    return borderSize;
}

- (CGSize)xhss_MinSizeWithMarginForAutoLayout {
    CGSize borderSize = [self xhss_MinSizeWithBorderForAutoLayout];
    CGSize marginSize = CGSizeMake( self.marginLeftValue
                                         //+self.borderLeftValue
                                         +borderSize.width
                                         //+self.borderRightValue
                                         +self.marginRightValue, // width
                                          self.marginTopValue
                                         //+self.borderTopValue
                                         +borderSize.height
                                         //+self.borderBottomValue
                                         +self.marginBottomValue // height
                                         );
    return marginSize;
}

#pragma mark - MaxSize
- (CGSize)xhss_MaxSizeForAutoLayout {
    // 没有文本内容的 UIView 或 UIView 的子类 默认最大尺寸为父视图尺寸，没有父视图默认为屏幕尺寸
    if (self.superview) {
        return self.superview.bounds.size;
    } else {
        return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds),
                          CGRectGetHeight([UIScreen mainScreen].bounds));
    }
}

- (CGSize)xhss_MaxSizeWithBorderForAutoLayout {
    CGSize size = [self xhss_MaxSizeForAutoLayout];
    CGSize borderSize = CGSizeMake( self.borderLeftValue
                                   +size.width
                                   +self.borderRightValue, // width
                                   self.borderTopValue
                                   +size.height
                                   +self.borderBottomValue // height
                                   );
    return borderSize;
}

- (CGSize)xhss_MaxSizeWithPadingForAutoLayout {
    CGSize size = [self xhss_MaxSizeForAutoLayout];
    //CGSize borderSize = [self xhss_MaxSizeWithBorderForAutoLayout];
    CGSize padingSize = CGSizeMake( size.width
                                   -self.padingLeftValue
                                   -self.padingRightValue, // width
                                    size.height
                                   -self.padingTopValue
                                   -self.padingBottomValue // height
                                   );
    return padingSize;
}

- (CGSize)xhss_MaxSizeWithMarginForAutoLayout {
    CGSize borderSize = [self xhss_MaxSizeWithBorderForAutoLayout];
    CGSize marginSize = CGSizeMake( self.marginLeftValue
                                   //+self.borderLeftValue
                                   +borderSize.width
                                   //+self.borderRightValue
                                   +self.marginRightValue, // width
                                    self.marginTopValue
                                   //+self.borderTopValue
                                   +borderSize.height
                                   //+self.borderBottomValue
                                   +self.marginBottomValue // height
                                   );
    return marginSize;
}


#pragma mark - Size Tool
/**
 Width 固定
 */
- (CGSize)xhss_FixedWidth:(CGFloat)widthValue forSize:(CGSize)size {
    CGSize marginSize = CGSizeMake( self.marginLeftValue
                                   +self.borderLeftValue
                                   +widthValue
                                   +self.borderRightValue
                                   +self.marginRightValue,
                                    size.height);
    return marginSize;
}
/**
 Width 尽量大
 */
- (CGSize)xhss_AsBigAsPossibleWidthForSize:(CGSize)size {
    CGSize marginSize = size;
    marginSize.height = self.xhss_MaxSizeWithMarginForAutoLayout.width;
    return marginSize;
}
/**
 Width 尽量小
 */
- (CGSize)xhss_AsSmallAsPossibleWidthForSize:(CGSize)size {
    CGSize marginSize = size;
    marginSize.height = self.xhss_MinSizeWithMarginForAutoLayout.width;
    return marginSize;
}

/**
 Height 固定
 */
- (CGSize)xhss_FixedHeight:(CGFloat)heightValue forSize:(CGSize)size {
    CGSize marginSize = CGSizeMake( size.width,
                                    self.marginTopValue
                                   +self.borderTopValue
                                   +heightValue
                                   +self.borderBottomValue
                                   +self.marginBottomValue);
    return marginSize;
}
/**
 Height 尽量大
 */
- (CGSize)xhss_AsBigAsPossibleHeightForSize:(CGSize)size {
    CGSize marginSize = size;
    size.height = self.xhss_MaxSizeWithMarginForAutoLayout.height;
    return marginSize;
}
/**
 Height 尽量小
 */
- (CGSize)xhss_AsSmallAsPossibleHeightForSize:(CGSize)size {
    CGSize marginSize = size;
    size.height = self.xhss_MinSizeWithMarginForAutoLayout.height;
    return marginSize;
}


/**
 用来布局子视图的参考 Width
 */
- (CGFloat)xhss_BaseWidth {
    if (self.layoutWidth > 0) {
        return self.xhss_WidthValueWithPadingForAutoLayout;
    }
    return [self.superview xhss_BaseWidth];
}
/**
 用来布局子视图的参考 Height
 */
- (CGFloat)xhss_BaseHeight {
    if (self.layoutHeight > 0) {
        return self.xhss_HeightValueWithPadingForAutoLayout;
    }
    return [self.superview xhss_BaseHeight];
}


/**
 size 加入 border、margin 后的大小
 */
- (CGSize)xhss_marginSizeWithSize:(CGSize)size {
   CGSize marginSize = CGSizeMake( self.marginLeftValue
                                  +self.borderLeftValue
                                  +size.width
                                  +self.borderRightValue
                                  +self.marginRightValue,
                                   self.marginTopValue
                                  +self.borderTopValue
                                  +size.height
                                  +self.borderBottomValue
                                  +self.marginBottomValue);
    return marginSize;
}


#pragma mark - Utils
- (CGSize)__xhss_autoTextSize:(NSString*)text textAttribute:(NSDictionary*)textAttr {
    CGSize textSize = [text sizeWithAttributes:textAttr];
    if (textSize.width > self.superview.layoutWidth
        || (self.xhss_LeftValueForAutoLayout +textSize.width) > self.superview.layoutWidth) {
        return [self __xhss_autoHeightForMultiLinesText:text textAttribute:textAttr];
    } else {
        return textSize;
    }
}

- (CGSize)__xhss_autoHeightForMultiLinesText:(NSString*)text textAttribute:(NSDictionary*)textAttr {
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(self.layoutWidth, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:textAttr
                                         context:nil].size;
    
    return textSize;
}

@end

//
//  ViewController.m
//  XHSSAutoLayout
//
//  Created by XHSS on 2021/9/26.
//

#import "ViewController.h"
#import "XHSSAutoLayout.h"


#pragma mark - LayoutView
@interface LayoutView : UIView

@end
@implementation LayoutView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.layoutWidth = 80;
    self.layoutHeight = 80;
    self.marginValue = 6;
    self.mainLayoutType = XHSSLayoutType_Column;
    self.crossAxisAligment = XHSSLayoutAxisAligment_Center;
    self.mainAxisCrossAligment = XHSSLayoutAxisAligment_Center;
//    self.padingValue = 5;
    
    UIImageView* imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"picture_1"];
    imageView.layoutWidth = 50;
    imageView.layoutHeight = 50;
    [self addSubview:imageView];
    
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"标题";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.layoutWidth = 80;
    titleLabel.layoutHeight = 20;
    titleLabel.marginTopValue = 6;
    [self addSubview:titleLabel];
}

@end




#pragma mark - StepView
@interface StepView : UIView

@end
@implementation StepView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.layoutWidth = 100;
    self.layoutHeight = 20;
    self.mainLayoutType = XHSSLayoutType_Row;
    self.crossAxisAligment = XHSSLayoutAxisAligment_Center;
    self.padingValue = 5;
    
    UIImageView* imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"picture_1"];
    imageView.layer.cornerRadius = 10;
    imageView.clipsToBounds = YES;
    imageView.layoutWidth = 20;
    imageView.layoutHeight = 20;
    [self addSubview:imageView];
    
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"几个步骤";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.layoutFlex = 1;
    titleLabel.layoutSizeMode = XHSSLayoutSizeMode_Flexable;
    titleLabel.layoutWidth = 60;
    titleLabel.layoutHeight = 20;
    titleLabel.marginLeftValue = 4;
    [self addSubview:titleLabel];
}

@end




#pragma mark - ViewController
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    UIView* logleContainerView = [[UIView alloc] init];
    logleContainerView.mainLayoutType = XHSSLayoutType_Row;
    logleContainerView.mainAxisCrossAligment = XHSSLayoutAxisAligment_Center;
    logleContainerView.layoutWidth = CGRectGetWidth(self.view.frame);
    logleContainerView.layoutHeight = 40;
    [self.view addSubview:logleContainerView];
    
    UIImageView* logleIcon = [[UIImageView alloc] init];
    logleIcon.image = [UIImage imageNamed:@"picture_1"];
    logleIcon.marginLeftValue = 10;
    logleIcon.layoutWidth = 28;
    logleIcon.layoutHeight = 28;
    [logleContainerView addSubview:logleIcon];
    
    UIImageView* logleText = [[UIImageView alloc] init];
    logleText.image = [UIImage imageNamed:@"picture"];
    logleText.layoutWidth = 100;
    logleText.layoutHeight = 28;
    logleText.marginLeftValue = 4;
    [logleContainerView addSubview:logleText];
    
    [logleContainerView addSubview:[XHSSAutoLayoutConvenientWidgets flexSpace]];
    
    UIImageView* loginIcon = [[UIImageView alloc] init];
    loginIcon.image = [UIImage imageNamed:@"picture_1"];
    loginIcon.layoutWidth = 20;
    loginIcon.layoutHeight = 20;
    [logleContainerView addSubview:loginIcon];
    
    UILabel* loginText = [[UILabel alloc] init];
    loginText.text = @"登录";
    loginText.marginLeftValue = 2;
    loginText.marginRightValue = 10;
    loginText.layoutWidth = 36;
    loginText.layoutHeight = 36;
    [logleContainerView addSubview:loginText];
    
    
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    UIView* topMenuContainerView = [[UIView alloc] init];
    topMenuContainerView.layoutWidth = CGRectGetWidth(self.view.frame);
    topMenuContainerView.layoutHeight = 118;
    topMenuContainerView.mainLayoutType = XHSSLayoutType_Row;
    topMenuContainerView.isExpending = YES;
    [self.view addSubview:topMenuContainerView];

    LayoutView* topMenu1 = [[LayoutView alloc] init];
    LayoutView* topMenu2 = [[LayoutView alloc] init];
    LayoutView* topMenu3 = [[LayoutView alloc] init];
    [topMenuContainerView addSubview:topMenu1];
    [topMenuContainerView addSubview:topMenu2];
    [topMenuContainerView addSubview:topMenu3];
    
    
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    UIView* stContainerView = [[UIView alloc] init];
    stContainerView.layoutWidth = CGRectGetWidth(self.view.frame);
    stContainerView.layoutHeight = 40;
    stContainerView.mainLayoutType = XHSSLayoutType_Row;
    stContainerView.isExpending = YES;
    [self.view addSubview:stContainerView];
    
    StepView* st1V = [[StepView alloc] init];
    StepView* st2V = [[StepView alloc] init];
    StepView* st3V = [[StepView alloc] init];
    
    [stContainerView addSubview:st1V];
    [stContainerView addSubview:st2V];
    [stContainerView addSubview:st3V];
        
    
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    UIView* btnContainerView = [[UIView alloc] init];
    btnContainerView.layoutWidth = CGRectGetWidth(self.view.frame);
    btnContainerView.layoutHeight = 40;
    btnContainerView.marginBottomValue = 40;
    btnContainerView.mainLayoutType = XHSSLayoutType_Row;
    btnContainerView.isExpending = YES;
    [self.view addSubview:btnContainerView];
    
    UILabel* btnLabel = [[UILabel alloc] init];
    btnLabel.backgroundColor = [UIColor orangeColor];
    btnLabel.text = @"自动布局哈哈";
    btnLabel.layer.cornerRadius = 20;
    btnLabel.clipsToBounds = YES;
    btnLabel.textAlignment = NSTextAlignmentCenter;
    btnLabel.textColor = [UIColor whiteColor];
    btnLabel.layoutWidth = 160;
    btnLabel.layoutHeight = 40;
    [btnContainerView addSubview:btnLabel];

    
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    LayoutView* v1 = [[LayoutView alloc] init];
    LayoutView* v2 = [[LayoutView alloc] init];
    LayoutView* v3 = [[LayoutView alloc] init];
    LayoutView* v4 = [[LayoutView alloc] init];
    LayoutView* v5 = [[LayoutView alloc] init];
    LayoutView* v6 = [[LayoutView alloc] init];
    LayoutView* v7 = [[LayoutView alloc] init];
    LayoutView* v8 = [[LayoutView alloc] init];
    LayoutView* v9 = [[LayoutView alloc] init];
    
    [self.view addSubview:v1];
    [self.view addSubview:v2];
    [self.view addSubview:v3];
    [self.view addSubview:v4];
    [self.view addSubview:v5];
    [self.view addSubview:v6];
    [self.view addSubview:v7];
    [self.view addSubview:v8];
    [self.view addSubview:v9];
    
    
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    UIImageView* imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"picture"];
    imageV.layoutWidth = CGRectGetWidth(self.view.frame);
    imageV.layoutHeight = 100;
    imageV.marginTopValue = 20;
    [self.view addSubview:imageV];

    
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//    self.view.backgroundColor = [UIColor purpleColor];
    self.view.mainLayoutType = XHSSLayoutType_HorizontalFlow;
//    self.view.mainAxisAligment = XHSSLayoutAxisAligment_Center;
//    self.view.mainAxisCrossAligment = XHSSLayoutAxisAligment_Start;
//    self.view.crossAxisAligment = XHSSLayoutAxisAligment_Center;
    self.view.isMainAxisExpending = YES;
    self.view.padingTopValue = 60;
    
    [self.view xhss_PerformAutoLayout];
}

@end

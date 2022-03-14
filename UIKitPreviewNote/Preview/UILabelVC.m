//
//  UILabelStringViewController.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import "UILabelVC.h"
#import "SettingVC.h"
#import "SettingEnumValueVC.h"

@interface UILabelVC ()

@end

@implementation UILabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"UILabel";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UILabel *lb = UILabel.new;
    lb.textColor = UIColor.blackColor;
    lb.text = @"这是UILabel控件这是UILabel控件这是UILabel控件这是UILabel控件这是UILabel控件这是UILabel控件这是UILabel控件";
    
    SettingVC *vc = [[SettingVC alloc] init];
    [self addChildViewController:vc];
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[lb, vc.view]];
    stackView.axis = UILayoutConstraintAxisVertical;
    [self.view addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.mas_equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.mas_equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            // Fallback on earlier versions
            make.edges.offset(0);
        }
    }];
    
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(128);
    }];
    
    __weak UILabel *wlb = lb;
    vc.keyVC.getModelBlock = ^NSArray<SettingKeyModel *> * _Nonnull{
        NSMutableArray <SettingKeyModel*> *keyModels = NSMutableArray.new;
        {
            NSArray *desces = @[@"NSTextAlignmentLeft",
                                @"NSTextAlignmentCenter",
                                @"NSTextAlignmentRight",
                                @"NSTextAlignmentJustified",
                                @"NSTextAlignmentNatural"];
            NSArray *values = @[@(NSTextAlignmentLeft),
                                @(NSTextAlignmentCenter),
                                @(NSTextAlignmentRight),
                                @(NSTextAlignmentJustified),
                                @(NSTextAlignmentNatural)];
            NSInteger defaultIndex = [values indexOfObject:@(wlb.textAlignment)];
            SettingKeyModel *keyModel = [SettingKeyVC createEnumKModelWithPtName:@"textAlignment"
                                                                       descArray:desces
                                                                          values:values
                                                                    defaultIndex:defaultIndex
                                                                    selectChange:^(NSInteger value) {
                wlb.textAlignment = value;
            }];
            [keyModels addObject:keyModel];
        }
        {
            NSArray *desces = @[@"NSLineBreakByWordWrapping",
                                @"NSLineBreakByCharWrapping",
                                @"NSLineBreakByClipping",
                                @"NSLineBreakByTruncatingHead",
                                @"NSLineBreakByTruncatingTail",
                                @"NSLineBreakByTruncatingMiddle"];
            NSArray *values = @[@(NSLineBreakByWordWrapping),
                                @(NSLineBreakByCharWrapping),
                                @(NSLineBreakByClipping),
                                @(NSLineBreakByTruncatingHead),
                                @(NSLineBreakByTruncatingTail),
                                @(NSLineBreakByTruncatingMiddle)];
            NSInteger defaultIndex = [values indexOfObject:@(wlb.lineBreakMode)];
            SettingKeyModel *keyModel = [SettingKeyVC createEnumKModelWithPtName:@"lineBreakMode"
                                                                       descArray:desces
                                                                          values:values
                                                                    defaultIndex:defaultIndex
                                                                    selectChange:^(NSInteger value) {
                wlb.lineBreakMode = value;
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingKeyModel *keyModel = [SettingKeyVC createStepKModelWithPtName:@"numberOfLines"
                                        value:wlb.numberOfLines
                                        minimumValue:0
                                        maximumValue:100
                                        stepValue:1
                                        valueChage:^(double value) {
                wlb.numberOfLines = value;
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingKeyModel *keyModel = [SettingKeyVC createFomtModelWithPtName:@"font" valueChage:^(UIFont * _Nonnull font) {
                wlb.font = font;
            }];
            [keyModels addObject:keyModel];
        }
        return keyModels;
    };
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

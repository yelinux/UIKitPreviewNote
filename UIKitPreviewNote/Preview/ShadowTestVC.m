//
//  ShadowTestVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/12.
//

#import "ShadowTestVC.h"
#import "SettingVC.h"
#import "SettingEnumValueVC.h"
#import "SettingNumCell.h"

@interface ShadowTestVC ()

@end

@implementation ShadowTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Shadow";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIView *container = [[UIView alloc] init];
    container.backgroundColor = UIColor.whiteColor;
    
    UIView *testView = [[UIView alloc] init];
    testView.backgroundColor = UIColor.whiteColor;
    testView.layer.cornerRadius = 0;
    testView.layer.shadowOpacity = 1;
    testView.layer.shadowColor = [UIColor blackColor].CGColor;// 阴影的颜色
    testView.layer.shadowRadius = 5;// 阴影扩散的范围控制
    testView.layer.shadowOffset = CGSizeMake(2, 2);// 阴影的范围
    
    [container addSubview:testView];
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(30, 30, 30, 30));
    }];
    
    SettingVC *vc = [[SettingVC alloc] init];
    [self addChildViewController:vc];
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[container, vc.view]];
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
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(128);
    }];
    
    __weak UIView *wkView = testView;
    vc.keyVC.getModelBlock = ^NSArray<SettingKeyModel *> * _Nonnull{
        NSMutableArray <SettingKeyModel*> *keyModels = NSMutableArray.new;
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"layer.cornerRadius"
                                                                                      value:wkView.layer.cornerRadius
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:1
                                                                                 valueChage:^(double value) {
                wkView.layer.cornerRadius = value;
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"layer.shadowOpacity"
                                                                                      value:wkView.layer.shadowOpacity
                                                                               minimumValue:0
                                                                               maximumValue:1
                                                                                  stepValue:0.1
                                                                                 valueChage:^(double value) {
                wkView.layer.shadowOpacity = value;
            }];
            [keyModels addObject:keyModel];
        }
        {
            UIColor *color = [UIColor colorWithCGColor:wkView.layer.shadowColor];
            SettingKeyModel *keyModel = [SettingKeyVC createColorModelWithPtName:@"layer.shadowColor" value:color valueChage:^(UIColor * _Nonnull color) {
                wkView.layer.shadowColor = color.CGColor;
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"layer.shadowRadius"
                                                                                      value:wkView.layer.shadowRadius
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:1
                                                                                 valueChage:^(double value) {
                wkView.layer.shadowRadius = value;
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"layer.shadowOffset.width"
                                                                                      value:wkView.layer.shadowOffset.width
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:0.5
                                                                                 valueChage:^(double value) {
                CGSize size = wkView.layer.shadowOffset;
                size.width = value;
                wkView.layer.shadowOffset = size;
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingNumCellModel *keyModel = [SettingNumCellModel createStepKModelWithPtName:@"layer.shadowOffset.height"
                                                                                      value:wkView.layer.shadowOffset.height
                                                                               minimumValue:0
                                                                               maximumValue:100
                                                                                  stepValue:0.5
                                                                                 valueChage:^(double value) {
                CGSize size = wkView.layer.shadowOffset;
                size.height = value;
                wkView.layer.shadowOffset = size;
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

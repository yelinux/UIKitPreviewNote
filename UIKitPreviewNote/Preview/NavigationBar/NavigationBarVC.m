//
//  NavigationBarVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/2.
//

#import "NavigationBarVC.h"
#import "SettingVC.h"
#import "SettingEnumValueVC.h"
#import "SettingNumCell.h"
#import "SettingBoolCell.h"
#import "SettingClickCell.h"

API_AVAILABLE(ios(13.0))
UINavigationBarAppearance *getStandardAppearanceBlock(UINavigationBar *navigationBar){
    if (!navigationBar.standardAppearance) {
        UINavigationBarAppearance *appearnace = [[UINavigationBarAppearance alloc] init];
        navigationBar.standardAppearance = appearnace;
    }
    return navigationBar.standardAppearance;
}

API_AVAILABLE(ios(13.0))
UINavigationBarAppearance *getCompactAppearanceBlock(UINavigationBar *navigationBar){
    if (!navigationBar.compactAppearance) {
        UINavigationBarAppearance *appearnace = [[UINavigationBarAppearance alloc] init];
        navigationBar.compactAppearance = appearnace;
    }
    return navigationBar.compactAppearance;
}

API_AVAILABLE(ios(13.0))
UINavigationBarAppearance *getScrollEdgeAppearanceBlock(UINavigationBar *navigationBar){
    if (!navigationBar.scrollEdgeAppearance) {
        UINavigationBarAppearance *appearnace = [[UINavigationBarAppearance alloc] init];
        navigationBar.scrollEdgeAppearance = appearnace;
    }
    return navigationBar.scrollEdgeAppearance;
}

API_AVAILABLE(ios(15.0))
UINavigationBarAppearance *getCompactScrollEdgeAppearanceBlock(UINavigationBar *navigationBar){
    if (!navigationBar.compactScrollEdgeAppearance) {
        UINavigationBarAppearance *appearnace = [[UINavigationBarAppearance alloc] init];
        navigationBar.compactScrollEdgeAppearance = appearnace;
    }
    return navigationBar.compactScrollEdgeAppearance;
}

@interface NavigationBarVC ()

@property (nonatomic, strong) UIView *pView;

@end

@implementation NavigationBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UINavigationBar";
    self.view.backgroundColor = UIColor.whiteColor;
    
//    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    SettingVC *vc = [[SettingVC alloc] init];
    [self addChildViewController:vc];
    
    [self.view addSubview:vc.view];
    _pView = vc.view;
    [_pView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    UILabel *lb = UILabel.new;
    lb.backgroundColor = UIColor.blackColor;
    lb.textColor = UIColor.whiteColor;
    lb.text = @"0,0";
    [self.view addSubview:lb];
    [lb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    __weak UILabel *wlb = lb;
    
    __weak typeof(self)weakSelf = self;
    vc.keyVC.getModelBlock = ^NSArray<SettingKeyModel *> * _Nonnull{
        NSMutableArray <SettingKeyModel*> *keyModels = NSMutableArray.new;
        
        {
            SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"navigationBar.isHidden" value:weakSelf.navigationController.navigationBar.isHidden valueChage:^(BOOL value) {
                [weakSelf.navigationController setNavigationBarHidden:value animated:YES];
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"navigationBar.translucent" value:weakSelf.navigationController.navigationBar.translucent valueChage:^(BOOL value) {
                weakSelf.navigationController.navigationBar.translucent = value;
                if (value) {
                    [wlb mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.left.offset(0);
                        make.size.mas_equalTo(CGSizeMake(100, 100));
                    }];
                } else {
                    [wlb mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.left.offset(0);
                        make.size.mas_equalTo(CGSizeMake(100, 20));
                    }];
                }
            }];
            [keyModels addObject:keyModel];
        }
        {
            NSArray *desces = @[@"UIBarStyleDefault",
                                @"UIBarStyleBlack"];
            NSArray *values = @[@(UIBarStyleDefault),
                                @(UIBarStyleBlack)];
            NSInteger defaultIndex = [values indexOfObject:@(weakSelf.navigationController.navigationBar.barStyle)];
            SettingKeyModel *keyModel = [SettingEnumValueVCModel createEnumKModelWithPtName:@"navigationBar.barStyle"
                                                                                  descArray:desces
                                                                                     values:values
                                                                               defaultIndex:defaultIndex
                                                                               selectChange:^(NSInteger value) {
                weakSelf.navigationController.navigationBar.barStyle = value;
            }];
            [keyModels addObject:keyModel];
        }
        {
            NSArray *desces = @[@"configureWithDefaultBackground",
                                @"configureWithOpaqueBackground",
                                @"configureWithTransparentBackground"];
            NSArray *values = @[@(0),
                                @(1),
                                @(2)];
            SettingKeyModel *keyModel = [SettingEnumValueVCModel createEnumKModelWithPtName:@"#StandardAppearance.confXXXBackground"
                                                                                  descArray:desces
                                                                                     values:values
                                                                               defaultIndex:-1
                                                                               selectChange:^(NSInteger value) {
                if (value == 0) {
                    [getStandardAppearanceBlock(weakSelf.navigationController.navigationBar) configureWithDefaultBackground];
                } else if(value == 1){
                    [getStandardAppearanceBlock(weakSelf.navigationController.navigationBar) configureWithOpaqueBackground];
                } else if(value == 2){
                    [getStandardAppearanceBlock(weakSelf.navigationController.navigationBar) configureWithTransparentBackground];
                }
            }];
            [keyModels addObject:keyModel];
        }
        {
            NSArray *desces = @[@"configureWithDefaultBackground",
                                @"configureWithOpaqueBackground",
                                @"configureWithTransparentBackground"];
            NSArray *values = @[@(0),
                                @(1),
                                @(2)];
            SettingKeyModel *keyModel = [SettingEnumValueVCModel createEnumKModelWithPtName:@"#CompactAppearance.confXXXBackground"
                                                                                  descArray:desces
                                                                                     values:values
                                                                               defaultIndex:-1
                                                                               selectChange:^(NSInteger value) {
                if (value == 0) {
                    [getCompactAppearanceBlock(weakSelf.navigationController.navigationBar) configureWithDefaultBackground];
                } else if(value == 1){
                    [getCompactAppearanceBlock(weakSelf.navigationController.navigationBar) configureWithOpaqueBackground];
                } else if(value == 2){
                    [getCompactAppearanceBlock(weakSelf.navigationController.navigationBar) configureWithTransparentBackground];
                }
            }];
            [keyModels addObject:keyModel];
        }
        {
            NSArray *desces = @[@"configureWithDefaultBackground",
                                @"configureWithOpaqueBackground",
                                @"configureWithTransparentBackground"];
            NSArray *values = @[@(0),
                                @(1),
                                @(2)];
            SettingKeyModel *keyModel = [SettingEnumValueVCModel createEnumKModelWithPtName:@"ScrollEdgeAppearance.confXXXBackground"
                                                                                  descArray:desces
                                                                                     values:values
                                                                               defaultIndex:-1
                                                                               selectChange:^(NSInteger value) {
                if (value == 0) {
                    [getScrollEdgeAppearanceBlock(weakSelf.navigationController.navigationBar) configureWithDefaultBackground];
                } else if(value == 1){
                    [getScrollEdgeAppearanceBlock(weakSelf.navigationController.navigationBar) configureWithOpaqueBackground];
                } else if(value == 2){
                    [getScrollEdgeAppearanceBlock(weakSelf.navigationController.navigationBar) configureWithTransparentBackground];
                }
            }];
            [keyModels addObject:keyModel];
        }
        {
            NSArray *desces = @[@"configureWithDefaultBackground",
                                @"configureWithOpaqueBackground",
                                @"configureWithTransparentBackground"];
            NSArray *values = @[@(0),
                                @(1),
                                @(2)];
            SettingKeyModel *keyModel = [SettingEnumValueVCModel createEnumKModelWithPtName:@"#CompactScrollEdgeAppearance.confXXXBackground"
                                                                                  descArray:desces
                                                                                     values:values
                                                                               defaultIndex:-1
                                                                               selectChange:^(NSInteger value) {
                if (value == 0) {
                    [getCompactScrollEdgeAppearanceBlock(weakSelf.navigationController.navigationBar) configureWithDefaultBackground];
                } else if(value == 1){
                    [getCompactScrollEdgeAppearanceBlock(weakSelf.navigationController.navigationBar) configureWithOpaqueBackground];
                } else if(value == 2){
                    [getCompactScrollEdgeAppearanceBlock(weakSelf.navigationController.navigationBar) configureWithTransparentBackground];
                }
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingKeyModel *keyModel = [SettingKeyVC createColorModelWithPtName:@"standardAppearance.backgroundColor" value:getStandardAppearanceBlock(weakSelf.navigationController.navigationBar).backgroundColor valueChage:^(UIColor * _Nonnull color) {
                getStandardAppearanceBlock(weakSelf.navigationController.navigationBar).backgroundColor = color;
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingKeyModel *keyModel = [SettingKeyVC createColorModelWithPtName:@"scrollEdgeAppearance.backgroundColor" value:getScrollEdgeAppearanceBlock(weakSelf.navigationController.navigationBar).backgroundColor valueChage:^(UIColor * _Nonnull color) {
                getScrollEdgeAppearanceBlock(weakSelf.navigationController.navigationBar).backgroundColor = color;
            }];
            [keyModels addObject:keyModel];
        }
//        {
//            SettingKeyModel *keyModel = [SettingClickCellModel createClickKModelWithPtName:@"push nav" clickBlock:^{
//                UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"CusNavItem"];
//                [weakSelf.navigationController.navigationBar pushNavigationItem:navItem animated:YES];
//            }];
//            [keyModels addObject:keyModel];
//        }
        return keyModels;
    };
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"self.view.bounds = %@", NSStringFromCGRect(self.view.bounds));
    
//    [_pView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        if (@available(iOS 11.0, *)) {
//            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
//            make.left.mas_equalTo(self.view.mas_safeAreaLayoutGuideLeft);
//            make.right.mas_equalTo(self.view.mas_safeAreaLayoutGuideRight);
//            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
//        } else {
//            // Fallback on earlier versions
//            make.edges.offset(0);
//        }
//    }];
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

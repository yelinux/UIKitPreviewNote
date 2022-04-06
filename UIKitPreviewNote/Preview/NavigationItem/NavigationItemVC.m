//
//  NavigationItemVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/6.
//

#import "NavigationItemVC.h"
#import "SettingVC.h"
#import "SettingEnumValueVC.h"
#import "SettingNumCell.h"
#import "SettingBoolCell.h"
#import "SettingClickCell.h"
#import "CustomTitleView.h"

API_AVAILABLE(ios(13.0))
UINavigationBarAppearance *standardAppearanceBlock(UINavigationItem *navigationItem){
    if (!navigationItem.standardAppearance) {
        UINavigationBarAppearance *appearnace = [[UINavigationBarAppearance alloc] init];
        navigationItem.standardAppearance = appearnace;
    }
    return navigationItem.standardAppearance;
}

API_AVAILABLE(ios(13.0))
UINavigationBarAppearance *compactAppearanceBlock(UINavigationItem *navigationItem){
    if (!navigationItem.compactAppearance) {
        UINavigationBarAppearance *appearnace = [[UINavigationBarAppearance alloc] init];
        navigationItem.compactAppearance = appearnace;
    }
    return navigationItem.compactAppearance;
}

API_AVAILABLE(ios(13.0))
UINavigationBarAppearance *scrollEdgeAppearanceBlock(UINavigationItem *navigationItem){
    if (!navigationItem.scrollEdgeAppearance) {
        UINavigationBarAppearance *appearnace = [[UINavigationBarAppearance alloc] init];
        navigationItem.scrollEdgeAppearance = appearnace;
    }
    return navigationItem.scrollEdgeAppearance;
}

API_AVAILABLE(ios(15.0))
UINavigationBarAppearance *compactScrollEdgeAppearanceBlock(UINavigationItem *navigationItem){
    if (!navigationItem.compactScrollEdgeAppearance) {
        UINavigationBarAppearance *appearnace = [[UINavigationBarAppearance alloc] init];
        navigationItem.compactScrollEdgeAppearance = appearnace;
    }
    return navigationItem.compactScrollEdgeAppearance;
}

@interface NavigationItemVC ()

@property (nonatomic, strong) UIView *pView;
@property (nonatomic, strong) CustomTitleView *titleView;
@property (nonatomic, strong) UIBarButtonItem *backBarButton;
@property (nonatomic, copy) NSArray<UIBarButtonItem *> *leftBarButtonItems;
@property (nonatomic, strong) UIBarButtonItem *rightBarButton;
@property (nonatomic, copy) NSArray<UIBarButtonItem *> *rightBarButtonItems;

@end

@implementation NavigationItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"NavigationItem";
    self.view.backgroundColor = UIColor.whiteColor;
    
//    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    CustomTitleView *titleView = CustomTitleView.new;
    titleView.frame = CGRectMake(0, 0, 1000, 80);
    titleView.backgroundColor = UIColor.redColor;
    self.navigationItem.titleView = titleView;//自定义titleView
    self.navigationItem.leftBarButtonItem = self.backBarButton;
    self.navigationItem.leftItemsSupplementBackButton = YES;//同时显示backBarBtn和leftBarBtn
    
//
//    self.navigationItem.rightBarButtonItems = self.rightBarButtonItems;
    
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
            SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"navigationItem.titleView!=nil" value:weakSelf.navigationItem.titleView!=nil valueChage:^(BOOL value) {
                weakSelf.navigationItem.titleView = value ? weakSelf.titleView : nil;
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"navigationItem.hidesBackButton" value:weakSelf.navigationItem.hidesBackButton valueChage:^(BOOL value) {
                weakSelf.navigationItem.hidesBackButton = value;
//                [weakSelf.navigationItem setHidesBackButton:value animated:YES];
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"navigationItem.leftBarButtonItem!=nil" value:weakSelf.navigationItem.leftBarButtonItem!=nil valueChage:^(BOOL value) {
                weakSelf.navigationItem.leftBarButtonItem = value?weakSelf.backBarButton:nil;
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"navigationItem.leftItemsSupplementBackButton" value:weakSelf.navigationItem.leftItemsSupplementBackButton valueChage:^(BOOL value) {
                weakSelf.navigationItem.leftItemsSupplementBackButton = value;
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"navigationItem.leftBarButtonItems!=nil" value:weakSelf.navigationItem.leftBarButtonItems!=nil valueChage:^(BOOL value) {
                weakSelf.navigationItem.leftBarButtonItems = value?weakSelf.leftBarButtonItems:nil;
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"navigationItem.rightBarButtonItem!=nil" value:weakSelf.navigationItem.rightBarButtonItem!=nil valueChage:^(BOOL value) {
                weakSelf.navigationItem.rightBarButtonItem = value?weakSelf.rightBarButton:nil;
            }];
            [keyModels addObject:keyModel];
        }
        {
            SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"navigationItem.rightBarButtonItems!=nil" value:weakSelf.navigationItem.rightBarButtonItems!=nil valueChage:^(BOOL value) {
                weakSelf.navigationItem.rightBarButtonItems = value?weakSelf.rightBarButtonItems:nil;
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
                    [standardAppearanceBlock(weakSelf.navigationItem) configureWithDefaultBackground];
                } else if(value == 1){
                    [standardAppearanceBlock(weakSelf.navigationItem) configureWithOpaqueBackground];
                } else if(value == 2){
                    [standardAppearanceBlock(weakSelf.navigationItem) configureWithTransparentBackground];
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
                    [compactAppearanceBlock(weakSelf.navigationItem) configureWithDefaultBackground];
                } else if(value == 1){
                    [compactAppearanceBlock(weakSelf.navigationItem) configureWithOpaqueBackground];
                } else if(value == 2){
                    [compactAppearanceBlock(weakSelf.navigationItem) configureWithTransparentBackground];
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
                    [scrollEdgeAppearanceBlock(weakSelf.navigationItem) configureWithDefaultBackground];
                } else if(value == 1){
                    [scrollEdgeAppearanceBlock(weakSelf.navigationItem) configureWithOpaqueBackground];
                } else if(value == 2){
                    [scrollEdgeAppearanceBlock(weakSelf.navigationItem) configureWithTransparentBackground];
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
                    [compactScrollEdgeAppearanceBlock(weakSelf.navigationItem) configureWithDefaultBackground];
                } else if(value == 1){
                    [compactScrollEdgeAppearanceBlock(weakSelf.navigationItem) configureWithOpaqueBackground];
                } else if(value == 2){
                    [compactScrollEdgeAppearanceBlock(weakSelf.navigationItem) configureWithTransparentBackground];
                }
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
            SettingKeyModel *keyModel = [SettingKeyVC createColorModelWithPtName:@"scrollEdgeAppearance.backgroundColor" value:scrollEdgeAppearanceBlock(weakSelf.navigationItem).backgroundColor valueChage:^(UIColor * _Nonnull color) {
                scrollEdgeAppearanceBlock(weakSelf.navigationItem).backgroundColor = color;
            }];
            [keyModels addObject:keyModel];
        }
        return keyModels;
    };
}

// Mark - Getter
-(CustomTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[CustomTitleView alloc] init];
    }
    return _titleView;
}

-(UIBarButtonItem *)backBarButton{
    if (!_backBarButton) {
        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        btnBack.backgroundColor = UIColor.blackColor;
        [btnBack setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btnBack setTitle:@"bk" forState:UIControlStateNormal];
        _backBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    }
    return _backBarButton;
}

-(UIBarButtonItem *)rightBarButton{
    if (!_rightBarButton) {
        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        btnBack.backgroundColor = UIColor.blackColor;
        [btnBack setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btnBack setTitle:@"rg" forState:UIControlStateNormal];
        _rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    }
    return _rightBarButton;
}

-(NSArray<UIBarButtonItem *> *)leftBarButtonItems{
    if (!_leftBarButtonItems) {
        NSMutableArray *barButtonItems = [NSMutableArray array];
        UIButton *(^bFunc)(NSString *title) = ^(NSString *title) {
            UIButton *btn = [[UIButton alloc] init];
            btn.backgroundColor = UIColor.blackColor;
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            [btn setTitle:title forState:UIControlStateNormal];
            return btn;
        };
        [barButtonItems addObject:[[UIBarButtonItem alloc] initWithCustomView:bFunc(@"1")]];
        [barButtonItems addObject:[[UIBarButtonItem alloc] initWithCustomView:bFunc(@"2")]];
        [barButtonItems addObject:[[UIBarButtonItem alloc] initWithCustomView:bFunc(@"3")]];
        _leftBarButtonItems = barButtonItems;
    }
    return _leftBarButtonItems;
}

-(NSArray<UIBarButtonItem *> *)rightBarButtonItems{
    if (!_rightBarButtonItems) {
        NSMutableArray *barButtonItems = [NSMutableArray array];
        UIButton *(^bFunc)(NSString *title) = ^(NSString *title) {
            UIButton *btn = [[UIButton alloc] init];
            btn.backgroundColor = UIColor.blackColor;
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            [btn setTitle:title forState:UIControlStateNormal];
            return btn;
        };
        [barButtonItems addObject:[[UIBarButtonItem alloc] initWithCustomView:bFunc(@"1")]];
        [barButtonItems addObject:[[UIBarButtonItem alloc] initWithCustomView:bFunc(@"2")]];
        [barButtonItems addObject:[[UIBarButtonItem alloc] initWithCustomView:bFunc(@"3")]];
        _rightBarButtonItems = barButtonItems;
    }
    return _rightBarButtonItems;
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

//
//  TabBarPreviewVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/7.
//

#import "TabBarPreviewVC.h"
#import "SettingVC.h"
#import "SettingEnumValueVC.h"
#import "SettingNumCell.h"
#import "SettingBoolCell.h"
#import "SettingClickCell.h"
#import "TabBarDemoVC.h"

@interface TabBarPreviewVC ()

@property (nonatomic, strong) TabBarDemoVC *tabBarVC;

@end

@implementation TabBarPreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UITabBarViewController";
    self.view.backgroundColor = UIColor.whiteColor;
    
    TabBarDemoVC *tabBarVC = [[TabBarDemoVC alloc] init];
    [self addChildViewController:tabBarVC];
    [self.view addSubview:tabBarVC.view];
    [tabBarVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(200);
    }];
    _tabBarVC = tabBarVC;
    
    SettingVC *vc = [[SettingVC alloc] init];
    [self addChildViewController:vc];
    
    [self.view addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tabBarVC.view.mas_bottom);
        make.left.right.offset(0);
        make.bottom.offset(-20);
    }];
    
    __weak typeof(self)weakSelf = self;
    vc.keyVC.getModelBlock = ^NSArray<SettingKeyModel *> * _Nonnull{
        NSMutableArray <SettingKeyModel*> *keyModels = NSMutableArray.new;
        
        if (@available(iOS 13.0, *)) {
            {
                NSArray *desces = @[@"configureWithDefaultBackground",
                                    @"configureWithOpaqueBackground",
                                    @"configureWithTransparentBackground"];
                NSArray *values = @[@(0),
                                    @(1),
                                    @(2)];
                SettingKeyModel *keyModel = [SettingEnumValueVCModel createEnumKModelWithPtName:@"confXXXBackground"
                                                                                      descArray:desces
                                                                                         values:values
                                                                                   defaultIndex:-1
                                                                                   selectChange:^(NSInteger value) {
                    
                    UITabBarAppearance *appearnace = weakSelf.tabBarVC.tabBar.standardAppearance.copy;
                    if (value == 0) {
                        [appearnace configureWithDefaultBackground];
                    } else if(value == 1){
                        [appearnace configureWithOpaqueBackground];
                    } else if(value == 2){
                        [appearnace configureWithTransparentBackground];
                    }
                    weakSelf.tabBarVC.tabBar.standardAppearance = appearnace;
                    weakSelf.tabBarVC.tabBar.scrollEdgeAppearance = appearnace;
                }];
                [keyModels addObject:keyModel];
            }
        } else {
            // Fallback on earlier versions
            
        }
        
//        {
//            SettingKeyModel *keyModel = [SettingKeyVC createFontModelWithPtName:@"NSFontAttributeName" valueChage:^(UIFont * _Nonnull font) {
//                [weakSelf.attrMutDic setValue:font forKey:NSFontAttributeName];
//                [weakSelf refreshUI];
//            }];
//            [keyModels addObject:keyModel];
//        }
        {
            UIColor *color = weakSelf.tabBarVC.tabBar.backgroundColor;
            SettingKeyModel *keyModel = [SettingKeyVC createColorModelWithPtName:@"tabBar.backgroundColor" value:color valueChage:^(UIColor * _Nonnull color) {
                weakSelf.tabBarVC.tabBar.backgroundColor = color;
            }];
            [keyModels addObject:keyModel];
        }
        
        return keyModels;
    };
}

- (void)refreshUI{
    
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

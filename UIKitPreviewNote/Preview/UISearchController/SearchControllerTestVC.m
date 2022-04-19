//
//  SearchControllerTestVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/12.
//

#import "SearchControllerTestVC.h"
#import "SearchResultVC.h"
#import "SettingVC.h"
#import "SettingEnumValueVC.h"
#import "SettingNumCell.h"
#import "SettingBoolCell.h"
#import "SettingClickCell.h"

@interface SearchControllerTestVC ()<UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *svc;
@property (nonatomic, strong) SearchResultVC *retVC;

@end

@implementation SearchControllerTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UISearchController";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UISearchController *svc = [[UISearchController alloc] initWithSearchResultsController:self.retVC];
    svc.searchResultsUpdater = self;
    svc.delegate = self;
    svc.searchBar.barStyle = UIBarStyleDefault;
    svc.searchBar.delegate = self;
//    svc.searchBar.text = @"hello world";//默认文本
//    svc.searchBar.prompt = @"prompt";//不知道是什么东西
    svc.searchBar.placeholder = @"placeholder";//提示语
//    svc.searchBar.showsBookmarkButton = YES;//编辑框右边会出现📚的图标
//    svc.searchBar.searchTextField;//iOS 13以上使用
//    svc.searchBar.showsCancelButton = YES;//建议使用UISearchController -automaticallyShowsCancelButton
//    svc.searchBar.showsSearchResultsButton = YES;//不知有什么鬼用
    svc.searchBar.scopeButtonTitles = @[@"item1",@"item2",@"item3"];//搜索栏下面的tab，一般不用
    svc.searchBar.selectedScopeButtonIndex = 1;
    _svc = svc;
//    svc.hidesNavigationBarDuringPresentation = NO;//是否隐藏导航栏，默认为YES
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = svc;
        self.navigationItem.hidesSearchBarWhenScrolling = NO;//侧滑返回时取消侧滑，searchController就消失不出来了
    } else {
        // Fallback on earlier versions
    }
    /** Specify that this view controller determines how the search controller is presented.
            The search controller should be presented modally and match the physical size of this view controller.
        */
    self.definesPresentationContext = YES;
    
    
    SettingVC *vc = [[SettingVC alloc] init];
    [self addChildViewController:vc];
    
    [self.view addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    __weak typeof(self)weakSelf = self;
    vc.keyVC.getModelBlock = ^NSArray<SettingKeyModel *> * _Nonnull{
        NSMutableArray <SettingKeyModel*> *keyModels = NSMutableArray.new;
        if (@available(iOS 11.0, *)) {
            {
                SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"active" value:weakSelf.navigationItem.searchController.active valueChage:^(BOOL value) {
                    weakSelf.navigationItem.searchController.active = value;
                }];
                [keyModels addObject:keyModel];
            }
            {
                SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"dimsBackgroundDuringPresentation\n编辑搜索框时是否显示遮罩" value:weakSelf.navigationItem.searchController.dimsBackgroundDuringPresentation valueChage:^(BOOL value) {
                    weakSelf.navigationItem.searchController.dimsBackgroundDuringPresentation = value;
                }];
                [keyModels addObject:keyModel];
            }
            {
                SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"obscuresBackgroundDuringPresentation\n编辑搜索框时是否显示遮罩" value:weakSelf.navigationItem.searchController.obscuresBackgroundDuringPresentation valueChage:^(BOOL value) {
                    weakSelf.navigationItem.searchController.obscuresBackgroundDuringPresentation = value;
                }];
                [keyModels addObject:keyModel];
            }
            if (@available(iOS 13.0, *)) {
                {
                    SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"automaticallyShowsSearchResultsController\n编辑搜索时是否显示resultVC，默认为yes" value:weakSelf.navigationItem.searchController.automaticallyShowsSearchResultsController valueChage:^(BOOL value) {
                            weakSelf.navigationItem.searchController.automaticallyShowsSearchResultsController = value;
                    }];
                    [keyModels addObject:keyModel];
                }
                {
                    SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"showsSearchResultsController\n搜索获取焦点时是否显示resultVC" value:weakSelf.navigationItem.searchController.showsSearchResultsController valueChage:^(BOOL value) {
                        // If you set this property, automaticallyShowsSearchResultsController becomes NO.
                            weakSelf.navigationItem.searchController.showsSearchResultsController = value;
                    }];
                    [keyModels addObject:keyModel];
                }
                {
                    SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"automaticallyShowsCancelButton\n是否显示取消按钮" value:weakSelf.navigationItem.searchController.automaticallyShowsCancelButton valueChage:^(BOOL value) {
                            weakSelf.navigationItem.searchController.automaticallyShowsCancelButton = value;
                    }];
                    [keyModels addObject:keyModel];
                }
                {
                    SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"automaticallyShowsScopeBar" value:weakSelf.navigationItem.searchController.automaticallyShowsScopeBar valueChage:^(BOOL value) {
                            weakSelf.navigationItem.searchController.automaticallyShowsScopeBar = value;
                    }];
                    [keyModels addObject:keyModel];
                }
            }
            {
                SettingBoolCellModel *keyModel = [SettingBoolCellModel createBoolKModelWithPtName:@"searchBar.setShowsCancelButton" value:weakSelf.navigationItem.searchController.searchBar.showsCancelButton valueChage:^(BOOL value) {
                    [weakSelf.navigationItem.searchController.searchBar setShowsCancelButton:value animated:YES];
                }];
                [keyModels addObject:keyModel];
            }
            
//            {
//                NSArray *desces = @[@"UISearchBarStyleDefault",
//                                    @"UISearchBarStyleProminent",
//                                    @"UISearchBarStyleMinimal"];
//                NSArray *values = @[@(UISearchBarStyleDefault),
//                                    @(UISearchBarStyleProminent),
//                                    @(UISearchBarStyleMinimal)];
//                NSInteger defaultIndex = [values indexOfObject:@(weakSelf.navigationItem.searchController.searchBar.searchBarStyle)];
//                SettingKeyModel *keyModel = [SettingEnumValueVCModel createEnumKModelWithPtName:@"searchBar.searchBarStyle"
//                                                                                      descArray:desces
//                                                                                         values:values
//                                                                                   defaultIndex:defaultIndex
//                                                                                   selectChange:^(NSInteger value) {
//                    weakSelf.navigationItem.searchController.searchBar.searchBarStyle = value;
//                }];
//                [keyModels addObject:keyModel];
//            }
        } else {
            // Fallback on earlier versions
        }
        return keyModels;
    };
}

// Mark - UISearchResultsUpdating
// 搜索文本发生改变，焦点发生改变等
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSLog(@"%s", __func__);
}

// Mark - UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController{
    NSLog(@"%s", __func__);
}

- (void)didPresentSearchController:(UISearchController *)searchController{
    NSLog(@"%s", __func__);
    self.yh_interactivePopType = YHViewControllerInteractivePopTypeNone;//侧滑会出bug，暂时禁用
}

- (void)willDismissSearchController:(UISearchController *)searchController{
    NSLog(@"%s", __func__);
}

- (void)didDismissSearchController:(UISearchController *)searchController{
    NSLog(@"%s", __func__);
    self.yh_interactivePopType = YHViewControllerInteractivePopTypeFollowNav;
}
- (void)presentSearchController:(UISearchController *)searchController{
    NSLog(@"%s", __func__);
}

// Mark - UISearchBarDelegate
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;                      // return NO to not become first responder
// called when text starts editing
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"%s", __func__);
}
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;                        // return NO to not resign first responder
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"%s", __func__);
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%s", __func__);
}

//- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s", __func__);
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s", __func__);
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s", __func__);
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s", __func__);
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    NSLog(@"%s", __func__);
}

-(SearchResultVC *)retVC{
    if (!_retVC) {
        _retVC = [[SearchResultVC alloc] init];
    }
    return _retVC;
}

@end

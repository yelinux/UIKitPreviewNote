//
//  SettingVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import "SettingVC.h"

@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.yh_interactivePopType = YHNavigationInteractivePopTypeNone;
    self.navigationBar.translucent = NO;
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearnace = [[UINavigationBarAppearance alloc] init];
        [appearnace configureWithOpaqueBackground];
        appearnace.backgroundColor = UIColor.whiteColor;//背景色
        self.navigationBar.standardAppearance = appearnace;
        self.navigationBar.scrollEdgeAppearance = appearnace;
    } else {
        // Fallback on earlier versions
        [self.navigationBar setBarTintColor:UIColor.whiteColor];//背景色
    }
    
    SettingKeyVC *vc = [[SettingKeyVC alloc] init];
    [self pushViewController:vc animated:YES];
    _keyVC = vc;
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

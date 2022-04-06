//
//  ViewController.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import "ViewController.h"
#import "UIFontFamilysVC.h"
#import "UILabelVC.h"
#import "UIFontSystemVC.h"
#import "NSAttributeStringVC.h"
#import "UICollectionVC.h"
#import "NavigationBarVC.h"
#import "NavigationItemVC.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *btnBack;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UIKit 预览&笔记";
    
    //替换系统的“<"图标
//       [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"fan_hui.png"]];
//       [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"fan_hui.png"]];
    //其实设置无效，无法显示自定义btn
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnBack];
    //只能设置
    self.navigationItem.backBarButtonItem.title = @"close";
}

- (IBAction)clickFontSystem:(id)sender {
    UIFontSystemVC *vc = [[UIFontSystemVC alloc] init];
    vc.title = @"UIFont system";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickFontFamilys:(id)sender {
    UIFontFamilysVC *vc = [[UIFontFamilysVC alloc] init];
    vc.title = @"UIFont familyNames";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)click1:(id)sender {
    UILabelVC *vc = [[UILabelVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)click2:(id)sender {
    NSAttributeStringVC *vc = [[NSAttributeStringVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)click3:(id)sender {
    UICollectionVC *vc = [[UICollectionVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)click4:(id)sender {
    NavigationBarVC *vc = [[NavigationBarVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)click5:(id)sender {
    NavigationItemVC *vc = [[NavigationItemVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// Mark - Getter
-(UIButton *)btnBack{
    if (!_btnBack) {
        _btnBack = [[UIButton alloc] init];
        _btnBack.backgroundColor = UIColor.blackColor;
        [_btnBack setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_btnBack setTitle:@"bk" forState:UIControlStateNormal];
//        _btnBack.frame = CGRectMake(0, 0, 57, 44);
    }
    return _btnBack;
}

@end

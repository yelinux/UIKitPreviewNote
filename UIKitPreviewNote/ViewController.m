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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UIKit 预览&笔记";
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

@end

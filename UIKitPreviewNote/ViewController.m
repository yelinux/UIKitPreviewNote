//
//  ViewController.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import "ViewController.h"
#import "UIFontVC.h"
#import "UILabelVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UIKit 预览&笔记";
}

- (IBAction)clickFont:(id)sender {
    UIFontVC *vc = [[UIFontVC alloc] init];
    vc.title = @"UIFont";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)click1:(id)sender {
    UILabelVC *vc = [[UILabelVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end

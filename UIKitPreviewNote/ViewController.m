//
//  ViewController.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import "ViewController.h"
#import "UILabelStringViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UIKit 预览&笔记";
}
- (IBAction)click1:(id)sender {
    UILabelStringViewController *vc = [[UILabelStringViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end

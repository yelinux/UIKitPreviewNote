//
//  SettingFontVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/14.
//

#import "SettingFontVC.h"
#import "UIFontSystemVC.h"
#import "UIFontFamilysVC.h"

@interface SettingFontVC ()

@end

@implementation SettingFontVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *btn1 = UIButton.new;
    [btn1 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [btn1 setTitle:@"UIFont system" forState:UIControlStateNormal];
    btn1.backgroundColor = UIColor.whiteColor;
    [btn1 addTarget:self action:@selector(clickSystem) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = UIButton.new;
    [btn2 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [btn2 setTitle:@"UIFont familyNames" forState:UIControlStateNormal];
    btn2.backgroundColor = UIColor.whiteColor;
    [btn2 addTarget:self action:@selector(clickFamily) forControlEvents:UIControlEventTouchUpInside];
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[btn1, btn2]];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.backgroundColor = UIColor.lightGrayColor;
    stackView.spacing = 0.3;
    stackView.distribution = UIStackViewDistributionFillEqually;
    [self.view addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_equalTo(100);
    }];
}

-(void)clickSystem{
    UIFontSystemVC *vc = [[UIFontSystemVC alloc] init];
    vc.title = self.title;
    vc.clickBlock = self.valueChange;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickFamily{
    UIFontFamilysVC *vc = [[UIFontFamilysVC alloc] init];
    vc.title = self.title;
    vc.clickBlock = self.valueChange;
    [self.navigationController pushViewController:vc animated:YES];
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

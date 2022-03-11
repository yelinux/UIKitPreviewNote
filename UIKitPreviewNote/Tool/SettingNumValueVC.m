//
//  SettingNumValueVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import "SettingNumValueVC.h"

@interface SettingNumValueVC ()

@property (nonatomic, strong) UILabel *lb;
@property (nonatomic, strong) UIStepper *stepper;

@end

@implementation SettingNumValueVC

+(SettingNumValueVC*)createStepKModelWithPtName: (NSString*)name
                                          value: (double)value
                                   minimumValue: (double)minimumValue
                                   maximumValue: (double)maximumValue
                                      stepValue: (double)stepValue
                                     valueChage: (void(^)(double value))block{
    SettingNumValueVC *vc = [[SettingNumValueVC alloc] init];
    vc.title = name;
    vc.value = value;
    vc.minimumValue = minimumValue;
    vc.maximumValue = maximumValue;
    vc.stepValue = stepValue;
    vc.valueChageBlock = block;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    UILabel *lb = UILabel.new;
    lb.textColor = UIColor.blackColor;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.numberOfLines = 0;
    [self.view addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_greaterThanOrEqualTo(50);
    }];
    _lb = lb;
    
    UIStepper *stepper = [[UIStepper alloc] init];
    stepper.value = self.value;
    stepper.minimumValue = self.minimumValue;
    stepper.maximumValue = self.maximumValue;
    stepper.stepValue = self.stepValue;
    [stepper addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:stepper];
    [stepper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lb.mas_bottom).offset(0);
        make.centerX.offset(0);
    }];
    
    [self refreshUI];
}

-(void)refreshUI{
    _lb.text = [NSString stringWithFormat:@"%@=%f", self.title, self.value];
}

-(void)change: (UIStepper*)sender{
    self.value = sender.value;
    [self refreshUI];
    self.valueChageBlock(sender.value);
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

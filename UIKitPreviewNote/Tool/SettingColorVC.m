//
//  SettingColorVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/14.
//

#import "SettingColorVC.h"

@interface SettingColorVC ()

@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UILabel *lb;
@property (nonatomic, strong) UISlider *sliderRed;
@property (nonatomic, strong) UISlider *sliderGreen;
@property (nonatomic, strong) UISlider *sliderBlue;
@property (nonatomic, strong) UISlider *sliderAlpha;

@end

@implementation SettingColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIView *colorView = UIView.new;
    [self.view addSubview:colorView];
    [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(8);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    _colorView = colorView;
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 10;
    [self.view addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.mas_equalTo(colorView.mas_bottom);
    }];
    
    UILabel *lb = UILabel.new;
    lb.textColor = UIColor.blackColor;
    lb.textAlignment = NSTextAlignmentCenter;
    [stackView addArrangedSubview:lb];
    _lb = lb;
    
    UISlider*(^blockFunc)(CGFloat maximumValue) = ^(CGFloat maximumValue){
        UISlider *slider = UISlider.new;
        slider.minimumValue = 0.0f;
        slider.maximumValue = maximumValue;
        return slider;
    };
    
    _sliderRed = blockFunc(255);
    [stackView addArrangedSubview:_sliderRed];
    [_sliderRed addTarget:self action:@selector(changeEvent:) forControlEvents:UIControlEventValueChanged];
    
    _sliderGreen = blockFunc(255);
    [stackView addArrangedSubview:_sliderGreen];
    [_sliderGreen addTarget:self action:@selector(changeEvent:) forControlEvents:UIControlEventValueChanged];
    
    _sliderBlue = blockFunc(255);
    [stackView addArrangedSubview:_sliderBlue];
    [_sliderBlue addTarget:self action:@selector(changeEvent:) forControlEvents:UIControlEventValueChanged];
    
    _sliderAlpha = blockFunc(1);
    [stackView addArrangedSubview:_sliderAlpha];
    [_sliderAlpha addTarget:self action:@selector(changeEvent:) forControlEvents:UIControlEventValueChanged];
    
    self.colorView.backgroundColor = self.color;
    CGFloat r = 0, g, b, a;
    [self.color getRed:&r green:&g blue:&b alpha:&a];
    _lb.text = [NSString stringWithFormat:@"%.2f, %.2f, %.2f, %.2f", r * 255, g * 255, b * 255, a];
    _sliderRed.value = r * 255;
    _sliderGreen.value = g * 255;
    _sliderBlue.value = b * 255;
    _sliderAlpha.value = a;//CGColorGetAlpha(self.color.CGColor)
}

-(void)refreshUI{
    CGFloat r = _sliderRed.value;
    CGFloat g = _sliderGreen.value;
    CGFloat b = _sliderBlue.value;
    CGFloat a = _sliderAlpha.value;
    self.color = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:a];
    self.colorView.backgroundColor = self.color;
    _lb.text = [NSString stringWithFormat:@"%.2f, %.2f, %.2f, %.2f", r, g, b, a];
    if (self.valueChange) {
        self.valueChange(self.color);
    }
}

-(void)changeEvent: (UISlider*)slider{
    [self refreshUI];
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

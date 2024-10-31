//
//  GradientTestVC.m
//  UIKitPreviewNote
//
//  Created by EDY on 2024/5/24.
//

#import "GradientTestVC.h"

@interface GradientTestVC ()

@property (nonatomic, strong) UILabel *startPointLb;

@property (nonatomic, strong) UISlider *startXSlider;

@property (nonatomic, strong) UISlider *startYSlider;

@property (nonatomic, strong) UILabel *endPointLb;

@property (nonatomic, strong) UISlider *endXSlider;

@property (nonatomic, strong) UISlider *endYSlider;

@property (nonatomic, strong) UIView *previewView;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) UIView *startPointView;

@property (nonatomic, strong) UIView *endPointView;

@end

@implementation GradientTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.yh_interactivePopType = YHViewControllerInteractivePopTypeLeftScreen;
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.startPointLb, self.startXSlider, self.startYSlider, self.endPointLb, self.endXSlider, self.endYSlider]];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFill;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.spacing = 20;
    [self.view addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(300);
    }];
    
    [self.view addSubview:self.previewView];
    [self.previewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(stackView.mas_bottom);
        make.width.height.mas_equalTo(300);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self refreshUI];
    });
}

- (void)sliderValueChanged:(UISlider*)slider forEvent:(UIEvent*)event {
    [self refreshUI];
}

- (void)refreshUI {
    self.startPointLb.text = [NSString stringWithFormat:@"startPoint = CGPointMake(%f, %f)", self.startXSlider.value, self.startYSlider.value];
    self.endPointLb.text = [NSString stringWithFormat:@"endPoint = CGPointMake(%f, %f)", self.endXSlider.value, self.endYSlider.value];
    
    [self.gradientLayer removeFromSuperlayer];
    self.gradientLayer.startPoint = CGPointMake(self.startXSlider.value, self.startYSlider.value);
    self.gradientLayer.endPoint = CGPointMake(self.endXSlider.value, self.endYSlider.value);
    [self.previewView.layer insertSublayer:self.gradientLayer atIndex:0];
    self.gradientLayer.frame = self.previewView.bounds;
    
    [self.startPointView removeFromSuperview];
    [self.endPointView removeFromSuperview];
    [self.previewView addSubview:self.startPointView];
    [self.previewView addSubview:self.endPointView];
    
    CGFloat preWidth = self.previewView.bounds.size.width;
    CGFloat preHeight = self.previewView.bounds.size.height;
    
    self.startPointView.bounds = CGRectMake(0, 0, 2, 2);
    self.startPointView.center = CGPointMake(self.startXSlider.value * preWidth, self.startYSlider.value * preHeight);
    
    self.endPointView.bounds = CGRectMake(0, 0, 2, 2);
    self.endPointView.center = CGPointMake(self.endXSlider.value * preWidth, self.endYSlider.value * preHeight);
}

- (UILabel *)startPointLb {
    if (_startPointLb == nil) {
        UILabel *lb = [[UILabel alloc] init];
        lb.font = [UIFont systemFontOfSize:18];
        lb.textColor = [UIColor blackColor];
        lb.numberOfLines = 0;
        _startPointLb = lb;
    }
    return _startPointLb;
}

- (UISlider *)startXSlider {
    if (_startXSlider == nil) {
        _startXSlider = [[UISlider alloc] init];
        _startXSlider.minimumValue = 0;
        _startXSlider.maximumValue = 1;
        _startXSlider.value = 0;
        [_startXSlider addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _startXSlider;
}

- (UISlider *)startYSlider {
    if (_startYSlider == nil) {
        _startYSlider = [[UISlider alloc] init];
        _startYSlider.minimumValue = 0;
        _startYSlider.maximumValue = 1;
        _startYSlider.value = 0;
        [_startYSlider addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _startYSlider;
}

- (UILabel *)endPointLb {
    if (_endPointLb == nil) {
        UILabel *lb = [[UILabel alloc] init];
        lb.font = [UIFont systemFontOfSize:18];
        lb.textColor = [UIColor blackColor];
        lb.numberOfLines = 0;
        _endPointLb = lb;
    }
    return _endPointLb;
}

- (UISlider *)endXSlider {
    if (_endXSlider == nil) {
        _endXSlider = [[UISlider alloc] init];
        _endXSlider.minimumValue = 0;
        _endXSlider.maximumValue = 1;
        _endXSlider.value = 2;
        [_endXSlider addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _endXSlider;
}

- (UISlider *)endYSlider {
    if (_endYSlider == nil) {
        _endYSlider = [[UISlider alloc] init];
        _endYSlider.minimumValue = 0;
        _endYSlider.maximumValue = 1;
        _endYSlider.value = 1;
        [_endYSlider addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _endYSlider;
}

- (UIView *)previewView {
    if (_previewView == nil) {
        _previewView = [[UIView alloc] init];
//        _previewView.layer.borderColor = [UIColor redColor].CGColor;
//        _previewView.layer.borderWidth = 1;
    }
    return _previewView;
}

- (CAGradientLayer *)gradientLayer {
    if (_gradientLayer == nil) {
        _gradientLayer = [CAGradientLayer new];
        // 设置渐变的方向
//        _gradientLayer.startPoint = CGPointMake(0.5, 0.0); // 从上到下，起点为中间顶部
//        _gradientLayer.endPoint = CGPointMake(0.5, 1.0); // 终点为中间底部
        self.gradientLayer.colors = @[(id)[UIColor whiteColor].CGColor, (id)[UIColor blackColor].CGColor];
    }
    return _gradientLayer;
}

- (UIView *)startPointView {
    if (_startPointView == nil) {
        _startPointView = [[UIView alloc] init];
        _startPointView.backgroundColor = [UIColor redColor];
    }
    return _startPointView;
}

- (UIView *)endPointView {
    if (_endPointView == nil) {
        _endPointView = [[UIView alloc] init];
        _endPointView.backgroundColor = [UIColor redColor];
    }
    return _endPointView;
}

@end

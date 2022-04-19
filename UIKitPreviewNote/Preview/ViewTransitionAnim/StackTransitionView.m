//
//  StackTransitionView.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/19.
//

#import "StackTransitionView.h"

@interface StackTransitionView()

@property (nonatomic, strong) UIStackView *stackViewV;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *lb;

@property (nonatomic, strong) UIStackView *stackViewH1;
@property (nonatomic, strong) UIStackView *stackViewH2;

@end

@implementation StackTransitionView

- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.stackViewV];
    [self.stackViewV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    [self.stackViewV addArrangedSubview:self.btn];
    [self.stackViewV addArrangedSubview:self.lb];
}

- (void)clickBtn{
    if (self.stackViewV.arrangedSubviews.firstObject == self.btn) {
        [self.btn removeFromSuperview];
        [self.lb removeFromSuperview];
        [self.stackViewV addArrangedSubview:self.lb];
        [self.stackViewV addArrangedSubview:self.btn];
    } else {
        [self.lb removeFromSuperview];
        [self.btn removeFromSuperview];
        [self.stackViewV addArrangedSubview:self.btn];
        [self.stackViewV addArrangedSubview:self.lb];
    }
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    }];
}

- (UIButton *)btn{
    if (_btn == nil) {
        _btn = [[UIButton alloc] init];
        [_btn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
        [_btn setTitle:@"btn" forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (UILabel *)lb{
    if (_lb == nil) {
        _lb = UILabel.new;
        _lb.text = @"lb";
    }
    return _lb;
}

- (UIStackView *)stackViewV{
    if (_stackViewV == nil) {
        _stackViewV = [[UIStackView alloc] init];
        _stackViewV.axis = UILayoutConstraintAxisVertical;
    }
    return _stackViewV;
}

- (UIStackView *)stackViewH1{
    if (_stackViewH1 == nil) {
        _stackViewH1 = [[UIStackView alloc] init];
        _stackViewH1.axis = UILayoutConstraintAxisHorizontal;
    }
    return _stackViewH1;
}

@end

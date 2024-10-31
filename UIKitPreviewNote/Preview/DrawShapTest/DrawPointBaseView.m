//
//  DrawPointBaseView.m
//  UIKitPreviewNote
//
//  Created by EDY on 2024/10/31.
//

#import "DrawPointBaseView.h"

@interface DrawPointBaseView()

@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) UILabel *lbDesc;

@property (nonatomic, strong) UIButton *delBtn;

@end

@implementation DrawPointBaseView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.stackView];
        [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)setCheckSubViews:(NSArray<CheckView *> *)checkSubViews {
    _checkSubViews = checkSubViews;
    [self.stackView.arrangedSubviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.stackView addArrangedSubview:self.lbDesc];
    [checkSubViews enumerateObjectsUsingBlock:^(CheckView * _Nonnull checkView, NSUInteger idx, BOOL * _Nonnull stop) {
        [checkView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)]];
        [self.stackView addArrangedSubview:checkView];
    }];
    [self.stackView addArrangedSubview:self.delBtn];
}

- (void)clickTap: (UITapGestureRecognizer*)sender {
    [self.delegate drawPointSelectClick:sender.view];
}

- (void)clickDelete {
    [self.delegate drawPointDelete:self];
}

- (void)drawByPath: (UIBezierPath*)path {
    
}

- (void)exportByRect: (CGRect)rect {
    
}

- (UIStackView *)stackView {
    if (_stackView == nil) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.spacing = 10;
    }
    return _stackView;
}

- (UILabel *)lbDesc {
    if (_lbDesc == nil) {
        _lbDesc = [[UILabel alloc] init];
        _lbDesc.textColor = [UIColor whiteColor];
        _lbDesc.font = [UIFont systemFontOfSize:12];
    }
    return _lbDesc;
}

- (UIButton *)delBtn {
    if (_delBtn == nil) {
        _delBtn = [[UIButton alloc] init];
        _delBtn.backgroundColor = UIColor.lightGrayColor;
        [_delBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _delBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_delBtn setTitle:@"Delete" forState:UIControlStateNormal];
        [_delBtn addTarget:self action:@selector(clickDelete) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delBtn;
}

@end

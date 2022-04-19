//
//  StackMovTestVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/19.
//

#import "StackMovTestVC.h"
#import "StackMov1View.h"

@interface StackMovTestVC ()

@property (nonatomic, strong) StackMov1View *mov1;

@end

@implementation StackMovTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"StackMovTestVC";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    [scrollView addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        make.width.mas_equalTo(scrollView.mas_width);
    }];
    
    [stackView addArrangedSubview:self.mov1];
    [stackView addArrangedSubview:[[StackMov1View alloc] init]];
    [stackView addArrangedSubview:[[StackMov1View alloc] init]];
    [stackView addArrangedSubview:[[StackMov1View alloc] init]];
    [stackView addArrangedSubview:[[StackMov1View alloc] init]];
    [stackView addArrangedSubview:[[StackMov1View alloc] init]];
    [stackView addArrangedSubview:[[StackMov1View alloc] init]];
    [stackView addArrangedSubview:[[StackMov1View alloc] init]];
    [stackView addArrangedSubview:[[StackMov1View alloc] init]];
}

- (StackMov1View *)mov1{
    if (_mov1 == nil) {
        _mov1 = [[StackMov1View alloc] init];
    }
    return _mov1;
}

@end

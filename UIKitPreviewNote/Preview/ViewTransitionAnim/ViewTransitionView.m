//
//  ViewTransitionView.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/13.
//

#import "ViewTransitionView.h"

@interface ViewTransitionView()

@property (nonatomic, strong) UIView *container1;
@property (nonatomic, strong) UIView *container2;
@property (nonatomic, strong) UILabel *lb;
@property (nonatomic, strong) UITextField *tf;

@end

@implementation ViewTransitionView

-(instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    UIView *container1 = [[UIView alloc] init];
    container1.backgroundColor = UIColor.lightTextColor;
    _container1 = container1;
    
    UIView *container2 = [[UIView alloc] init];
    container2.backgroundColor = UIColor.lightTextColor;
    _container2 = container2;
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[container1, container2]];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 1;
    stackView.backgroundColor = UIColor.lightGrayColor;
    [self addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    [container1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
    }];
    
    [container2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.text = @"标题";
    [container1 addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
    _lb = lb;
    
    UITextField *tf = [[UITextField alloc] init];
    tf.backgroundColor = UIColor.whiteColor;
    tf.placeholder = @"placeholder";
    [self addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(container2).offset(5);
        make.bottom.right.mas_equalTo(container2).offset(-5);
    }];
    _tf = tf;
}

-(void)setSw:(BOOL)sw{
    _sw = sw;
    
    [self refreshUI];
}

-(void)refreshUI{
    
    if (self.sw) {
        [_lb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(5);
            make.top.bottom.offset(0);
        }];
        [_lb setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [_lb setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        // 先设置依赖，再设置某高度为0，否则会报警告：Probably at least one of the constraints in the following list is one you don't want.
        [_tf mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.lb.mas_right).offset(5);
            make.top.mas_equalTo(_container1).offset(5);
            make.bottom.right.mas_equalTo(_container1).offset(-5);
        }];
        [_container2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    } else {
        [_lb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
        // 先设置高度，再设置其它依赖，否则会报警告：Probably at least one of the constraints in the following list is one you don't want.
        [_container2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
        }];
        [_tf mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_container2).offset(8);
            make.bottom.right.mas_equalTo(_container2).offset(-8);
        }];
        
    }
    //可以放在vc那边执行动画
//    [UIView animateWithDuration:0.25 animations:^{
//        [self.tf.superview.superview layoutIfNeeded];
//    }];
}

@end

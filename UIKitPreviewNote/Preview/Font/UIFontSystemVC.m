//
//  UIFontSystemVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/14.
//

#import "UIFontSystemVC.h"

@interface UIFontSystemVC ()

@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat weight;

@property (nonatomic, strong) UILabel *lb1;
@property (nonatomic, strong) UILabel *lb2;
@property (nonatomic, strong) UILabel *lb3;
@property (nonatomic, strong) UILabel *lb4;
@property (nonatomic, strong) UILabel *lb5;
@property (nonatomic, strong) UILabel *lb6;

@end

@implementation UIFontSystemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.fontSize = 16.0f;
    self.weight = 1;
    
    UISlider *sdFontSize = UISlider.new;
    sdFontSize.minimumValue = 0.0f;
    sdFontSize.maximumValue = 30.0f;
    sdFontSize.value = self.fontSize;
    [sdFontSize addTarget:self action:@selector(fontSize:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sdFontSize];
    [sdFontSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        
    }];
    
    UISlider *sdWeight = UISlider.new;
    sdWeight.minimumValue = 0.0f;
    sdWeight.maximumValue = 1.0f;
    sdWeight.value = self.weight;
    [sdWeight addTarget:self action:@selector(weight:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sdWeight];
    [sdWeight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(sdFontSize.mas_bottom);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.mas_equalTo(sdWeight.mas_bottom);
    }];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 0.3;
    stackView.backgroundColor = UIColor.lightGrayColor;
    [scrollView addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        make.width.mas_equalTo(scrollView.mas_width);
    }];
    
    UILabel*(^blockFunc)(void) = ^{
        UILabel *lb = UILabel.new;
        lb.numberOfLines = 0;
        lb.userInteractionEnabled = YES;
        lb.backgroundColor = UIColor.whiteColor;
        [lb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];
        [stackView addArrangedSubview:lb];
        return lb;
    };
    
    _lb1 = blockFunc();
    _lb2 = blockFunc();
    _lb3 = blockFunc();
    _lb4 = blockFunc();
    _lb5 = blockFunc();
    _lb6 = blockFunc();
    
    [self refreshUI];
}

-(void)tapClick: (UITapGestureRecognizer*)sender{
    if (self.clickBlock && [sender.view isKindOfClass:[UILabel class]]) {
        UILabel *lb = (UILabel *)sender.view;
        self.clickBlock(lb.font);
    }
}

-(void)refreshUI{
    _lb1.font = [UIFont systemFontOfSize:self.fontSize];
    _lb1.text = [NSString stringWithFormat:@"[UIFont systemFontOfSize:%f]\n0123456789 你我他的得地", self.fontSize];
    _lb2.font = [UIFont boldSystemFontOfSize:self.fontSize];
    _lb2.text = [NSString stringWithFormat:@"[UIFont boldSystemFontOfSize:%f]\n0123456789 你我他的得地", self.fontSize];
    _lb3.font = [UIFont italicSystemFontOfSize:self.fontSize];
    _lb3.text = [NSString stringWithFormat:@"[UIFont italicSystemFontOfSize:%f]\n0123456789 你我他的得地", self.fontSize];
    _lb4.font = [UIFont systemFontOfSize:self.fontSize weight:self.weight];
    _lb4.text = [NSString stringWithFormat:@"[UIFont systemFontOfSize:%f weight:%f]\n0123456789 你我他的得地", self.fontSize, self.weight];
    _lb5.font = [UIFont monospacedDigitSystemFontOfSize:self.fontSize weight:self.weight];
    _lb5.text = [NSString stringWithFormat:@"[UIFont monospacedDigitSystemFontOfSize:%f weight:%f]\n0123456789 你我他的得地", self.fontSize, self.weight];
    _lb6.font = [UIFont monospacedSystemFontOfSize:self.fontSize weight:self.weight];
    _lb6.text = [NSString stringWithFormat:@"[UIFont monospacedSystemFontOfSize:%f weight:%f]\n0123456789 你我他的得地", self.fontSize, self.weight];
}

-(void)fontSize: (UISlider*)slider{
    self.fontSize = slider.value;
    [self refreshUI];
}

-(void)weight: (UISlider*)slider{
    self.weight = slider.value;
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

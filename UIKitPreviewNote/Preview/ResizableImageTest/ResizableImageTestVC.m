//
//  ResizableImageTestVC.m
//  UIKitPreviewNote
//
//  Created by EDY on 2023/5/24.
//

#import "ResizableImageTestVC.h"

@interface ResizableImageTestVC ()

@property (nonatomic, strong) UIImageView *ivOrg;

@property (nonatomic, strong) UIImageView *ivPreview;

@property (nonatomic, strong) UIView *lineTop;

@property (nonatomic, strong) UIView *lineLeft;

@property (nonatomic, strong) UIView *lineRight;

@property (nonatomic, strong) UIView *lineBottom;

@property (nonatomic, strong) UIImage *orgImg;

@property (nonatomic, strong) UISlider *sliderTop;

@property (nonatomic, strong) UISlider *sliderLeft;

@property (nonatomic, strong) UISlider *sliderRight;

@property (nonatomic, strong) UISlider *sliderBottom;

@property (nonatomic, strong) UILabel *lbDes;

@end

@implementation ResizableImageTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.ivOrg];
    [self.ivOrg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
    }];
    
    [self.view addSubview:self.ivPreview];
    [self.ivPreview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ivOrg.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(200);
    }];
    
    [self.ivOrg addSubview:self.lineTop];
    [self.ivOrg addSubview:self.lineLeft];
    [self.ivOrg addSubview:self.lineRight];
    [self.ivOrg addSubview:self.lineBottom];
    
    [self.view addSubview:self.sliderTop];
    [self.sliderTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ivPreview.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.view addSubview:self.sliderLeft];
    [self.sliderLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sliderTop.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.view addSubview:self.sliderRight];
    [self.sliderRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sliderLeft.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.view addSubview:self.sliderBottom];
    [self.sliderBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sliderRight.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.view addSubview:self.lbDes];
    [self.lbDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(self.ivOrg.mas_right).offset(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self refreshUI];
}

- (void)refreshUI {

    UIImage *img = [self.orgImg resizableImageWithCapInsets:UIEdgeInsetsMake(self.sliderTop.value, self.sliderLeft.value, self.sliderBottom.value, self.sliderRight.value) resizingMode:UIImageResizingModeStretch];
    self.ivPreview.image = img;
    self.lbDes.text = [NSString stringWithFormat:@"[self.orgImg resizableImageWithCapInsets:UIEdgeInsetsMake(%f, %f, %f, %f) resizingMode:UIImageResizingModeStretch]", self.sliderTop.value, self.sliderLeft.value, self.sliderBottom.value, self.sliderRight.value];
    [self.lineTop mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.sliderTop.value);
    }];
    [self.lineLeft mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.left.mas_equalTo(self.sliderLeft.value);
    }];
    [self.lineRight mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.right.mas_equalTo(-self.sliderRight.value);
    }];
    [self.lineBottom mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(-self.sliderBottom.value);
    }];
}

-(void)sliderValueChanged:(UISlider*)slider forEvent:(UIEvent*)event {
    [self refreshUI];
}

// MARK: - Getter
- (UIImageView *)ivOrg {
    if (_ivOrg == nil) {
        _ivOrg = [[UIImageView alloc] init];
        _ivOrg.backgroundColor = [UIColor lightGrayColor];
        _ivOrg.image = self.orgImg;
    }
    return _ivOrg;
}

- (UIImageView *)ivPreview {
    if (_ivPreview == nil) {
        _ivPreview = [[UIImageView alloc] init];
        _ivPreview.backgroundColor = [UIColor lightGrayColor];
    }
    return _ivPreview;
}

- (UIImage *)orgImg {
    if (_orgImg == nil) {
        _orgImg = [UIImage imageNamed:@"image_bg"];
    }
    return _orgImg;
}

- (UISlider *)sliderTop {
    if (_sliderTop == nil) {
        _sliderTop = [[UISlider alloc] init];
        _sliderTop.minimumValue = 0;
        _sliderTop.maximumValue = self.orgImg.size.height;
        _sliderTop.tintColor = [UIColor redColor];
        [_sliderTop addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _sliderTop;
}

- (UISlider *)sliderLeft {
    if (_sliderLeft == nil) {
        _sliderLeft = [[UISlider alloc] init];
        _sliderLeft.minimumValue = 0;
        _sliderLeft.maximumValue = self.orgImg.size.width;
        _sliderLeft.tintColor = [UIColor greenColor];
        [_sliderLeft addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _sliderLeft;
}

- (UISlider *)sliderRight {
    if (_sliderRight == nil) {
        _sliderRight = [[UISlider alloc] init];
        _sliderRight.minimumValue = 0;
        _sliderRight.maximumValue = self.orgImg.size.width;
        _sliderRight.tintColor = [UIColor blueColor];
        [_sliderRight addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _sliderRight;
}

- (UISlider *)sliderBottom {
    if (_sliderBottom == nil) {
        _sliderBottom = [[UISlider alloc] init];
        _sliderBottom.minimumValue = 0;
        _sliderBottom.maximumValue = self.orgImg.size.height;
        _sliderBottom.tintColor = [UIColor blackColor];
        [_sliderBottom addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _sliderBottom;
}

- (UILabel *)lbDes {
    if (_lbDes == nil) {
        _lbDes = UILabel.new;
        _lbDes.textColor = [UIColor blackColor];
        _lbDes.font = [UIFont systemFontOfSize:12];
        _lbDes.numberOfLines = 0;
    }
    return _lbDes;
}

- (UIView *)lineTop {
    if (_lineTop == nil) {
        _lineTop = [[UIView alloc] init];
        _lineTop.backgroundColor = [UIColor redColor];
    }
    return _lineTop;
}

- (UIView *)lineLeft {
    if (_lineLeft == nil) {
        _lineLeft = [[UIView alloc] init];
        _lineLeft.backgroundColor = [UIColor greenColor];
    }
    return _lineLeft;
}

- (UIView *)lineRight {
    if (_lineRight == nil) {
        _lineRight = [[UIView alloc] init];
        _lineRight.backgroundColor = [UIColor blueColor];
    }
    return _lineRight;
}

- (UIView *)lineBottom {
    if (_lineBottom == nil) {
        _lineBottom = [[UIView alloc] init];
        _lineBottom.backgroundColor = [UIColor blackColor];
    }
    return _lineBottom;
}

@end

//
//  StretchableImageTestVC.m
//  UIKitPreviewNote
//
//  Created by EDY on 2023/5/24.
//

#import "StretchableImageTestVC.h"

@interface StretchableImageTestVC ()

@property (nonatomic, strong) UIImageView *iv;

@property (nonatomic, strong) UIView *lineW;

@property (nonatomic, strong) UIView *lineH;

@property (nonatomic, strong) UIImage *orgImg;

@property (nonatomic, strong) UISlider *sliderW;

@property (nonatomic, strong) UISlider *sliderH;

@property (nonatomic, strong) UILabel *lbDes;

@end

@implementation StretchableImageTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.iv];
    [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(400);
    }];
    
    [self.iv addSubview:self.lineW];
    [self.iv addSubview:self.lineH];
    
    [self.view addSubview:self.sliderW];
    [self.sliderW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iv.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.view addSubview:self.sliderH];
    [self.sliderH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sliderW.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.view addSubview:self.lbDes];
    [self.lbDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sliderH.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self refreshUI];
}

- (void)refreshUI {
    //resizableImageWithCapInsets
//    [self.orgImg resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIImage *img = [self.orgImg stretchableImageWithLeftCapWidth:self.sliderW.value topCapHeight:self.sliderH.value];
    self.iv.image = img;
    self.lbDes.text = [NSString stringWithFormat:@"[self.orgImg stretchableImageWithLeftCapWidth:%f topCapHeight:%f]", self.sliderW.value, self.sliderH.value];
    [self.lineW mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.left.mas_equalTo(self.sliderW.value);
    }];
    [self.lineH mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.sliderH.value);
    }];
}

-(void)sliderValueChanged:(UISlider*)slider forEvent:(UIEvent*)event {
    [self refreshUI];
}

// MARK: - Getter
- (UIImageView *)iv {
    if (_iv == nil) {
        _iv = [[UIImageView alloc] init];
        _iv.backgroundColor = [UIColor lightGrayColor];
    }
    return _iv;
}

- (UIImage *)orgImg {
    if (_orgImg == nil) {
        _orgImg = [UIImage imageNamed:@"image_bg"];
    }
    return _orgImg;
}

- (UISlider *)sliderW {
    if (_sliderW == nil) {
        _sliderW = [[UISlider alloc] init];
        _sliderW.minimumValue = 0;
        _sliderW.maximumValue = self.orgImg.size.width;
        _sliderW.value = _sliderW.maximumValue;
        [_sliderW addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _sliderW;
}

- (UISlider *)sliderH {
    if (_sliderH == nil) {
        _sliderH = [[UISlider alloc] init];
        _sliderH.minimumValue = 0;
        _sliderH.maximumValue = self.orgImg.size.height;
        _sliderH.value = _sliderH.maximumValue;
        [_sliderH addTarget:self action:@selector(sliderValueChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _sliderH;
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

- (UIView *)lineW {
    if (_lineW == nil) {
        _lineW = [[UIView alloc] init];
        _lineW.backgroundColor = [UIColor redColor];
    }
    return _lineW;
}

- (UIView *)lineH {
    if (_lineH == nil) {
        _lineH = [[UIView alloc] init];
        _lineH.backgroundColor = [UIColor redColor];
    }
    return _lineH;
}

@end

//
//  CheckView.m
//  UIKitPreviewNote
//
//  Created by EDY on 2024/10/31.
//

#import "CheckView.h"

@interface CheckView()

@property (nonatomic, strong) UILabel *lbDesc;

@end

@implementation CheckView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.lbDesc];
        [self.lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
            make.width.mas_equalTo(100);
        }];
    }
    return self;
}

- (void)setPoint:(CGPoint)point {
    _point = point;
    self.lbDesc.text = [NSString stringWithFormat:@"(%.2f, %.2f)", point.x, point.y];
}

- (void)setCheck:(BOOL)check {
    _check = check;
    if (check) {
        self.lbDesc.textColor = [UIColor blackColor];
        self.lbDesc.backgroundColor = [UIColor whiteColor];
    } else {
        self.lbDesc.textColor = [UIColor whiteColor];
        self.lbDesc.backgroundColor = [UIColor blackColor];
    }
}

- (UILabel *)lbDesc {
    if (_lbDesc == nil) {
        _lbDesc = [[UILabel alloc] init];
        _lbDesc.textColor = [UIColor whiteColor];
        _lbDesc.backgroundColor = [UIColor blackColor];
        _lbDesc.font = [UIFont systemFontOfSize:12];
        _lbDesc.text = [NSString stringWithFormat:@"(%.2f, %.2f)", self.point.x, self.point.y];
    }
    return _lbDesc;
}

@end

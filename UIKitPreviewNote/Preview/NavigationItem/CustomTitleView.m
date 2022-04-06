//
//  CustomTitleView.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/6.
//

#import "CustomTitleView.h"

@implementation CustomTitleView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.redColor;
        
        UILabel *lbTitle = UILabel.new;
        lbTitle.textColor = UIColor.whiteColor;
        lbTitle.backgroundColor = UIColor.blackColor;
        lbTitle.text = @"title";
        [self addSubview:lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
        
        UILabel *lbLeft = UILabel.new;
        lbLeft.textColor = UIColor.whiteColor;
        lbLeft.backgroundColor = UIColor.blackColor;
        lbLeft.text = @"left";
        [self addSubview:lbLeft];
        [lbLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(0);
        }];
        
        UILabel *lbRight = UILabel.new;
        lbRight.textColor = UIColor.whiteColor;
        lbRight.backgroundColor = UIColor.blackColor;
        lbRight.text = @"right";
        [self addSubview:lbRight];
        [lbRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.offset(0);
        }];
    }
    return self;
}

//自定义titleView需要的，否则显示异常
- (CGSize)intrinsicContentSize{
    return UILayoutFittingExpandedSize;
}

@end

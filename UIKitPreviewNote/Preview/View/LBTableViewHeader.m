//
//  LBTableViewHeader.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/14.
//

#import "LBTableViewHeader.h"

@implementation LBTableViewHeader

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.grayColor;
        UILabel *lb = UILabel.new;
        lb.numberOfLines = 0;
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(12, 12, 12, 12));
        }];
        _lb = lb;
    }
    return self;
}

@end

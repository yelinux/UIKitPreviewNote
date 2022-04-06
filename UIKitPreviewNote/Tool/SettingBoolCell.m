//
//  SettingBoolCell.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/2.
//

#import "SettingBoolCell.h"

@interface SettingBoolCellModel()

@property(nonatomic, assign) BOOL value;
@property(nonatomic, copy) void(^boolChangeBlock)(BOOL val);

@end

@implementation SettingBoolCellModel

+(SettingBoolCellModel *)createBoolKModelWithPtName:(NSString *)name
                                              value:(BOOL)value
                                         valueChage:(void (^)(BOOL))block{
    SettingBoolCellModel *model = SettingBoolCellModel.new;
    model.propertyName = name;
    model.value = value;
    model.boolChangeBlock = block;
    return model;
}

@end

@interface SettingBoolCell()

@property (nonatomic, strong) UISwitch *sw;
@property (nonatomic, strong) UILabel *lb;

@end

@implementation SettingBoolCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UISwitch *sw = [[UISwitch alloc] init];
        [sw addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:sw];
        [sw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.right.offset(-15);
        }];
        _sw = sw;
        
        UILabel *lb = UILabel.new;
        lb.textColor = UIColor.blackColor;
        lb.font = [UIFont systemFontOfSize:14];
        lb.numberOfLines = 0;
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.offset(0);
            make.left.offset(16);
            make.right.mas_equalTo(sw.mas_left);
            make.height.mas_greaterThanOrEqualTo(50);
        }];
        _lb = lb;
    }
    return self;
}

-(void)setModel:(SettingBoolCellModel *)model{
    _model = model;
    _sw.on = model.value;
    _lb.text = self.model.propertyName;
}

-(void)switchChange: (UISwitch*)sw{
    self.model.value = sw.isOn;
    if (self.model.boolChangeBlock) {
        self.model.boolChangeBlock(sw.isOn);
    }
}

@end

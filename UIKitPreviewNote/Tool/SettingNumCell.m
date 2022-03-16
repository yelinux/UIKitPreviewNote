//
//  SettingNumCell.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/16.
//

#import "SettingNumCell.h"

@interface SettingNumCellModel()

@property(nonatomic) double value;
@property(nonatomic) double minimumValue;
@property(nonatomic) double maximumValue;
@property(nonatomic) double stepValue;
@property(nonatomic, copy) void(^numChangeBlock)(double val);

@end

@implementation SettingNumCellModel

+(SettingNumCellModel*)createStepKModelWithPtName: (NSString*)name
                                        value: (double)value
                                 minimumValue: (double)minimumValue
                                 maximumValue: (double)maximumValue
                                    stepValue: (double)stepValue
                                   valueChage: (void(^)(double value))block{
    SettingNumCellModel *model = SettingNumCellModel.new;
    model.propertyName = name;
    model.value = value;
    model.minimumValue = minimumValue;
    model.maximumValue = maximumValue;
    model.stepValue = stepValue;
    model.numChangeBlock = block;
    return model;
}

@end

@interface SettingNumCell()

@property (nonatomic, strong) UIStepper *stepper;
@property (nonatomic, strong) UILabel *lb;

@end

@implementation SettingNumCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIStepper *stepper = [[UIStepper alloc] init];
        [stepper addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:stepper];
        [stepper mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.right.offset(-15);
        }];
        _stepper = stepper;
        
        UILabel *lb = UILabel.new;
        lb.textColor = UIColor.blackColor;
        lb.numberOfLines = 0;
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.offset(0);
            make.left.offset(16);
            make.right.mas_equalTo(stepper.mas_left);
            make.height.mas_greaterThanOrEqualTo(50);
        }];
        _lb = lb;
    }
    return self;
}

-(void)setModel:(SettingNumCellModel *)model{
    _model = model;
    _stepper.value = self.model.value;
    _stepper.minimumValue = self.model.minimumValue;
    _stepper.maximumValue = self.model.maximumValue;
    _stepper.stepValue = self.model.stepValue;
    [self refreshUI];
}

-(void)refreshUI{
    _lb.text = [NSString stringWithFormat:@"%@:%f", self.model.propertyName, self.model.value];
}

-(void)change: (UIStepper*)sender{
    self.model.value = sender.value;
    [self refreshUI];
    if (self.model.numChangeBlock) {
        self.model.numChangeBlock(sender.value);
    }
}

@end

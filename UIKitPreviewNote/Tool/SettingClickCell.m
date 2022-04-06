//
//  SettingClickCell.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/6.
//

#import "SettingClickCell.h"

@interface SettingClickCellModel()

@property(nonatomic, copy) void(^clickBlock)(void);

@end

@implementation SettingClickCellModel

+ (SettingClickCellModel *)createClickKModelWithPtName:(NSString *)name
                                            clickBlock:(void (^)(void))block{
    SettingClickCellModel *model = SettingClickCellModel.new;
    model.propertyName = name;
    model.clickBlock = block;
    return model;
}

@end

@implementation SettingClickCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = UIColor.blackColor;
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.numberOfLines = 0;
        [self.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
    }
    return self;
}

-(void)setModel:(SettingClickCellModel *)model{
    _model = model;
    self.textLabel.text = model.propertyName;
}

-(void)tapClick{
    if (self.model.clickBlock) {
        self.model.clickBlock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

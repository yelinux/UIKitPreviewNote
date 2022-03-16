//
//  SettingNumCell.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/16.
//

#import <UIKit/UIKit.h>
#import "SettingKeyVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingNumCellModel : SettingKeyModel

+(SettingNumCellModel*)createStepKModelWithPtName: (NSString*)name
                                            value: (double)value
                                     minimumValue: (double)minimumValue
                                     maximumValue: (double)maximumValue
                                        stepValue: (double)stepValue
                                       valueChage: (void(^)(double value))block;

@end

@interface SettingNumCell : UITableViewCell

@property (nonatomic, strong) SettingNumCellModel *model;

@end

NS_ASSUME_NONNULL_END

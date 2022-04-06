//
//  SettingBoolCell.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/2.
//

#import <UIKit/UIKit.h>
#import "SettingKeyVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingBoolCellModel : SettingKeyModel

+(SettingBoolCellModel*)createBoolKModelWithPtName: (NSString*)name
                                             value: (BOOL)value
                                        valueChage: (void(^)(BOOL value))block;

@end

@interface SettingBoolCell : UITableViewCell

@property (nonatomic, strong) SettingBoolCellModel *model;

@end

NS_ASSUME_NONNULL_END

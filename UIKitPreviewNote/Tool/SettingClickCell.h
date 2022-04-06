//
//  SettingClickCell.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/6.
//

#import <UIKit/UIKit.h>
#import "SettingKeyVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingClickCellModel : SettingKeyModel

+(SettingClickCellModel*)createClickKModelWithPtName: (NSString*)name
                                          clickBlock: (void(^)(void))block;

@end

@interface SettingClickCell : UITableViewCell

@property (nonatomic, strong) SettingClickCellModel *model;

@end

NS_ASSUME_NONNULL_END

//
//  SettingEnumValueVC.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import <UIKit/UIKit.h>
#import "SettingKeyVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingEnumValueVCModel : SettingKeyModel

@property (nonatomic, copy) NSArray <NSString*> *values;
@property (nonatomic, assign) NSInteger selectIndex;

+(SettingEnumValueVCModel *)createEnumKModelWithPtName: (NSString*)name
                                             descArray: (NSArray*)descArray
                                                values: (NSArray*)values
                                          defaultIndex: (NSInteger)defaultIndex
                                          selectChange: (void(^)(NSInteger value))block;

@end

@interface SettingEnumValueVC : UIViewController

@property (nonatomic, strong) SettingEnumValueVCModel *model;

@end

NS_ASSUME_NONNULL_END

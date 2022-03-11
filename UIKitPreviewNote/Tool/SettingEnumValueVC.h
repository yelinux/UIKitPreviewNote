//
//  SettingEnumValueVC.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingEnumValueVC : UIViewController

@property (nonatomic, copy) NSArray <NSString*> *values;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, copy) void(^clickBlock)(NSInteger index);
+(SettingEnumValueVC *)createEnumKModelWithPtName: (NSString*)name
                                        descArray: (NSArray*)descArray
                                           values: (NSArray*)values
                                     defaultIndex: (NSInteger)defaultIndex
                                     selectChange: (void(^)(NSInteger value))block;

@end

NS_ASSUME_NONNULL_END

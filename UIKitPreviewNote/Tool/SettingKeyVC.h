//
//  SettingKeyVC.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingKeyModel : NSObject

@property (nonatomic, copy) NSString *propertyName;
@property (nonatomic, copy) UIViewController*(^selectBlock)(void);

@end

@interface SettingKeyVC : UIViewController

@property (nonatomic, copy) NSArray <SettingKeyModel*> *keyModels;
@property (nonatomic, copy) NSArray <SettingKeyModel *> *(^getModelBlock)(void);
+(SettingKeyModel *)createEnumKModelWithPtName: (NSString*)name
                                     descArray: (NSArray*)descArray
                                        values: (NSArray*)values
                                  defaultIndex: (NSInteger)defaultIndex
                                  selectChange: (void(^)(NSInteger value))block;
+(SettingKeyModel*)createStepKModelWithPtName: (NSString*)name
                                        value: (double)value
                                 minimumValue: (double)minimumValue
                                 maximumValue: (double)maximumValue
                                    stepValue: (double)stepValue
                                   valueChage: (void(^)(double value))block;

@end

NS_ASSUME_NONNULL_END

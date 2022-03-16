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
+(SettingKeyModel*)createFontModelWithPtName: (NSString*)name
                                  valueChage: (void(^)(UIFont *font))block;
+(SettingKeyModel*)createColorModelWithPtName: (NSString*)name
                                        value: (UIColor*)color
                                   valueChage: (void(^)(UIColor *color))block;

@end

NS_ASSUME_NONNULL_END

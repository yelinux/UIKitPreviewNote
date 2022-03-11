//
//  SettingNumValueVC.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingNumValueVC : UIViewController

@property(nonatomic) double value;
@property(nonatomic) double minimumValue;
@property(nonatomic) double maximumValue;
@property(nonatomic) double stepValue;
@property (nonatomic, copy) void(^valueChageBlock)(double value);
+(SettingNumValueVC*)createStepKModelWithPtName: (NSString*)name
                                          value: (double)value
                                   minimumValue: (double)minimumValue
                                   maximumValue: (double)maximumValue
                                      stepValue: (double)stepValue
                                     valueChage: (void(^)(double value))block;

@end

NS_ASSUME_NONNULL_END

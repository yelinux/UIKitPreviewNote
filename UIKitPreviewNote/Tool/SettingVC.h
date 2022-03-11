//
//  SettingVC.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import "YHNavigationController.h"
#import "SettingKeyVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingVC : YHNavigationController

@property (nonatomic, strong, readonly) SettingKeyVC *keyVC;

@end

NS_ASSUME_NONNULL_END

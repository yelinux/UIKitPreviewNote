//
//  SettingVC.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import <UIKit/UIKit.h>
#import "SettingKeyVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingVC : UINavigationController

@property (nonatomic, strong, readonly) SettingKeyVC *keyVC;

@end

NS_ASSUME_NONNULL_END

//
//  SettingColorVC.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingColorVC : UIViewController

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) void(^valueChange)(UIColor *color);

@end

NS_ASSUME_NONNULL_END

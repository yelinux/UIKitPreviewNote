//
//  UIFontSystemVC.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFontSystemVC : UIViewController

@property (nonatomic, copy) void(^clickBlock)(UIFont *font);

@end

NS_ASSUME_NONNULL_END

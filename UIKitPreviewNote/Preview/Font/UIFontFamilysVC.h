//
//  UIFontVC.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFontFamilysVC : UIViewController

@property (nonatomic, copy) void(^clickBlock)(UIFont *font);

@end

NS_ASSUME_NONNULL_END

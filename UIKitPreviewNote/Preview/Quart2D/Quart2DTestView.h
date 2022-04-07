//
//  Quart2DTestView.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Quart2DTestView : UIView

@property (nonatomic, copy) void(^drawBlock)(CGRect rect);
-(instancetype)initWithBlock: (void(^)(CGRect rect))block;

@end

NS_ASSUME_NONNULL_END

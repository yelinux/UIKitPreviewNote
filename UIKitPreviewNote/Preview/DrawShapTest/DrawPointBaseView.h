//
//  DrawPointBaseView.h
//  UIKitPreviewNote
//
//  Created by EDY on 2024/10/31.
//

#import <UIKit/UIKit.h>
#import "CheckView.h"

NS_ASSUME_NONNULL_BEGIN

@class DrawPointBaseView;

@protocol DrawPointDelegate <NSObject>

- (void)drawPointSelectClick: (CheckView*)checkView;

- (void)drawPointDelete: (DrawPointBaseView*)view;

@end

@interface DrawPointBaseView : UIView

@property (nonatomic, copy) NSArray <CheckView*> *checkSubViews;

@property (nonatomic, strong, readonly) UILabel *lbDesc;

@property (nonatomic, weak) id<DrawPointDelegate> delegate;

- (void)drawByPath: (UIBezierPath*)path;

- (void)exportByRect: (CGRect)rect;

@end

NS_ASSUME_NONNULL_END

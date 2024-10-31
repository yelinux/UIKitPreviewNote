//
//  DrawShapTestView.h
//  UIKitPreviewNote
//
//  Created by EDY on 2024/10/31.
//

#import <UIKit/UIKit.h>
#import "DrawPointBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrawShapTestView : UIView

@property (nonatomic, copy) NSArray <DrawPointBaseView*> *drawViewList;

@end

NS_ASSUME_NONNULL_END

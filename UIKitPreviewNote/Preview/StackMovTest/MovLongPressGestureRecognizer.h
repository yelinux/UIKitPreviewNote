//
//  MovLongPressGestureRecognizer.h
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MovLongPressGestureRecognizerDelegate <NSObject>

-(BOOL)movLongPressGestureRecognizerBegin: (CGPoint)point;
-(void)movLongPressGestureRecognizerMove: (CGPoint)point;
-(void)movLongPressGestureRecognizerEnd;

@end

@interface MovLongPressGestureRecognizer : UILongPressGestureRecognizer

@property (nonatomic, weak) id<MovLongPressGestureRecognizerDelegate> movDelegate;

@end

NS_ASSUME_NONNULL_END

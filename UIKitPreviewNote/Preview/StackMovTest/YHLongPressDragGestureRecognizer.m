//
//  MovLongPressGestureRecognizer.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/19.
//

#import "YHLongPressDragGestureRecognizer.h"

@interface YHLongPressDragGestureRecognizer()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGPoint touchBeginPoint;

@end

@implementation YHLongPressDragGestureRecognizer

-(instancetype)init{
    if (self = [super initWithTarget:self action:@selector(longPress:)]) {
        self.delegate = self;
    }
    return self;
}

- (void)longPress: (UILongPressGestureRecognizer*)sender{
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            if (!CGPointEqualToPoint(self.touchBeginPoint, CGPointZero)) {
                [self.movDelegate yh_LongPressDragGestureEnd];
            }
            break;
        default:
            break;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return [self.movDelegate yh_LongPressDragGestureBegin:self.touchBeginPoint];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    
    self.touchBeginPoint = point;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged) {
        UITouch *touch = touches.anyObject;
        CGPoint point = [touch locationInView:self.view];
        [self.movDelegate yh_LongPressDragGestureMove:point];
    }
}

@end

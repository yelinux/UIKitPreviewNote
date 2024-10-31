//
//  DrawMoveToPointView.m
//  UIKitPreviewNote
//
//  Created by EDY on 2024/10/31.
//

#import "DrawMoveToPointView.h"

@implementation DrawMoveToPointView

- (instancetype)init {
    if (self = [super init]) {
        CheckView *checkView = [[CheckView alloc] init];
        self.checkSubViews = @[checkView];
        
        self.lbDesc.text = @"moveToPoint";
    }
    return self;
}

- (void)drawByPath: (UIBezierPath*)path {
    CheckView *checkView = self.checkSubViews.firstObject;
    [path moveToPoint:checkView.point];
}

- (void)exportByRect: (CGRect)rect {
    CheckView *checkView = self.checkSubViews.firstObject;
    CGFloat xPercent = checkView.point.x / rect.size.width;
    CGFloat yPercent = checkView.point.y / rect.size.height;
    
    NSLog(@"[path moveToPoint:CGPointMake(%f * rect.size.width, %f * rect.size.height)];", xPercent, yPercent);
}

@end

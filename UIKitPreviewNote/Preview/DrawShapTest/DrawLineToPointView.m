//
//  DrawLineToPointView.m
//  UIKitPreviewNote
//
//  Created by EDY on 2024/10/31.
//

#import "DrawLineToPointView.h"

@implementation DrawLineToPointView

- (instancetype)init {
    if (self = [super init]) {
        CheckView *checkView = [[CheckView alloc] init];
        self.checkSubViews = @[checkView];
        
        self.lbDesc.text = @"addLineToPoint";
    }
    return self;
}

- (void)drawByPath: (UIBezierPath*)path {
    CheckView *checkView = self.checkSubViews.firstObject;
    [path addLineToPoint:checkView.point];
}

- (void)exportByRect: (CGRect)rect {
    CheckView *checkView = self.checkSubViews.firstObject;
    CGFloat xPercent = checkView.point.x / rect.size.width;
    CGFloat yPercent = checkView.point.y / rect.size.height;
    
    NSLog(@"[path addLineToPoint:CGPointMake(%f * rect.size.width, %f * rect.size.height)];", xPercent, yPercent);
}

@end

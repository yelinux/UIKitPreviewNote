//
//  DrawAddQuadCurveToPointView.m
//  UIKitPreviewNote
//
//  Created by EDY on 2024/10/31.
//

#import "DrawAddQuadCurveToPointView.h"

@implementation DrawAddQuadCurveToPointView

- (instancetype)init {
    if (self = [super init]) {
        self.checkSubViews = @[[[CheckView alloc] init], [[CheckView alloc] init]];
        
        self.lbDesc.text = @"addQuadCurveToPoint";
    }
    return self;
}

- (void)drawByPath: (UIBezierPath*)path {
    [path addQuadCurveToPoint:self.checkSubViews.firstObject.point controlPoint:self.checkSubViews.lastObject.point];
}

- (void)exportByRect: (CGRect)rect {
    CheckView *checkView1 = self.checkSubViews.firstObject;
    CGFloat xPercent1 = checkView1.point.x / rect.size.width;
    CGFloat yPercent1 = checkView1.point.y / rect.size.height;
    
    CheckView *checkView2 = self.checkSubViews.lastObject;
    CGFloat xPercent2 = checkView2.point.x / rect.size.width;
    CGFloat yPercent2 = checkView2.point.y / rect.size.height;
    
    NSLog(@"[path addQuadCurveToPoint:CGPointMake(%f * rect.size.width, %f * rect.size.height) controlPoint:CGPointMake(%f * rect.size.width, %f * rect.size.height)];", xPercent1, yPercent1, xPercent2, yPercent2);
}

@end

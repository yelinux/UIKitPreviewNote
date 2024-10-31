//
//  DrawShapTestView.m
//  UIKitPreviewNote
//
//  Created by EDY on 2024/10/31.
//

#import "DrawShapTestView.h"

@interface DrawShapTestView()

@end

@implementation DrawShapTestView

- (void)setDrawViewList:(NSArray<DrawPointBaseView *> *)drawViewList {
    _drawViewList = drawViewList;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色

    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1.0;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    if (self.drawViewList.count > 0) {
        [self.drawViewList enumerateObjectsUsingBlock:^(DrawPointBaseView * _Nonnull baseView, NSUInteger idx, BOOL * _Nonnull stop) {
            [baseView drawByPath:path];
        }];
    } else {
        [path moveToPoint:CGPointMake(0.33 * rect.size.width, 1 * rect.size.height)];
        [path addLineToPoint:CGPointMake(0.33 * rect.size.width, 0 * rect.size.height)];
        [path addLineToPoint:CGPointMake(0.66 * rect.size.width, 1 * rect.size.height)];
        [path addLineToPoint:CGPointMake(0 * rect.size.width, 0.33 * rect.size.height)];
        [path addLineToPoint:CGPointMake(1 * rect.size.width, 0.33 * rect.size.height)];
        [path addLineToPoint:CGPointMake(0.33 * rect.size.width, 1 * rect.size.height)];
    }

    [path stroke];
}


@end

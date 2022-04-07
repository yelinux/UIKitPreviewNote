//
//  Quart2DTestView.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/7.
//

#import "Quart2DTestView.h"

@implementation Quart2DTestView

-(instancetype)initWithBlock: (void(^)(CGRect rect))block{
    if (self = [super init]) {
        self.drawBlock = block;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    if (self.drawBlock) {
        self.drawBlock(rect);
    }
}

@end

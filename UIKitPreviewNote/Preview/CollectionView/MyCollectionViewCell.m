//
//  MyCollectionViewCell.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/25.
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell()

@property (nonatomic, assign) CGAffineTransform transformBegin;

@end

@implementation MyCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *lb = UILabel.new;
        lb.textColor = UIColor.blackColor;
        [self.contentView addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
        _lb = lb;
        
        [self.contentView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)]];
    }
    return self;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gesture {
    CGFloat progress = [gesture translationInView:gesture.view].x / gesture.view.bounds.size.width * 1.2;
    progress = MIN(1.0f, MAX(0.0f, progress));
    CGPoint velocity = [gesture velocityInView:gesture.view];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"1 panGestureAction");
        self.transformBegin = self.lb.transform;
//        self.popTransition = [UIPercentDrivenInteractiveTransition new];
//        [self.navigationController popViewControllerAnimated:YES];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        NSLog(@"2 panGestureAction");
        self.lb.transform = CGAffineTransformTranslate(self.transformBegin, 0, [gesture translationInView:gesture.view].y); // CGAffineTransformScale(self.transformBegin, progress, progress);
//        [self.popTransition updateInteractiveTransition:progress];
    } else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"3 panGestureAction");
        self.lb.transform = self.transformBegin;
        if (velocity.x > 500 || progress > 0.5) {
//            [self.popTransition finishInteractiveTransition];
        } else {
//            [self.popTransition cancelInteractiveTransition];
        }
//        self.popTransition = nil;
    }
}

@end

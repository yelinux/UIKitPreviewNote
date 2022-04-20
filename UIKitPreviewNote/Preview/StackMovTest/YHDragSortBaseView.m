//
//  YHDragSortBaseView.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/19.
//

#import "YHDragSortBaseView.h"
#import "YHLongPressDragGestureRecognizer.h"

@interface YHDragSortBaseView()<YHLongPressDragGestureDelegate>

@property (nonatomic, strong) YHLongPressDragGestureRecognizer *longPressDragGest;

@property (nonatomic, strong) UIView *dragView;
@property (nonatomic, strong) UIImageView *ivDrag;

@end

@implementation YHDragSortBaseView

- (instancetype)init{
    if (self = [super init]) {
        [self addGestureRecognizer:self.longPressDragGest];
    }
    return self;
}

// MARK - ui
-(void)refreshSubItemPosition{

}

// Mark - MovLongPressGestureRecognizerDelegate
-(BOOL)yh_LongPressDragGestureRecognize: (CGPoint)point{
    __block UIView *targetView = nil;
    [self.subItemViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        if (view.alpha > 0) {
            CGRect rect = [self convertRect:view.frame fromView:view.superview];
            if (CGRectContainsPoint(rect, point)) {
                targetView = view;
                *stop = YES;
            }
        }
    }];
    self.dragView = targetView;
    return targetView?YES:NO;
}

-(void)yh_LongPressDragGestureBegin: (CGPoint)point{
    UIView *view = self.dragView;
    CGRect rect = [self convertRect:view.frame fromView:view.superview];
    self.ivDrag.frame = rect;
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, view.window.screen.scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    self.ivDrag.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.ivDrag.transform = CGAffineTransformMakeScale(1.1, 1.1);
    
    [self addSubview:self.ivDrag];
    self.dragView.alpha = 0;
}

-(void)yh_LongPressDragGestureMove: (CGPoint)point{
    self.ivDrag.center = point;

    __block UIView *targetView = nil;
    [self.subItemViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        if (view.alpha > 0) {
            CGRect rect = [self convertRect:view.frame fromView:view.superview];
            if (CGRectContainsPoint(rect, point)) {
                targetView = view;
                *stop = YES;
            }
        }
    }];
    
    if (targetView) {
        NSMutableArray *subItemViews = [NSMutableArray arrayWithArray:self.subItemViews];
        [subItemViews exchangeObjectAtIndex:[self.subItemViews indexOfObject:targetView] withObjectAtIndex:[self.subItemViews indexOfObject:self.dragView]];
        self.subItemViews = subItemViews;
        [self refreshSubItemPosition];
        [self bringSubviewToFront:self.ivDrag];
    }
}

-(void)yh_LongPressDragGestureEnd{
    [self.ivDrag removeFromSuperview];
    self.ivDrag.transform = CGAffineTransformIdentity;
    self.dragView.alpha = 1;
}

// MARK - Getter
- (YHLongPressDragGestureRecognizer *)longPressDragGest{
    if (_longPressDragGest == nil) {
        _longPressDragGest = [[YHLongPressDragGestureRecognizer alloc] init];
        _longPressDragGest.movDelegate = self;
    }
    return _longPressDragGest;
}

- (UIImageView *)ivDrag{
    if (_ivDrag == nil) {
        _ivDrag = [[UIImageView alloc] init];
    }
    return _ivDrag;
}

@end

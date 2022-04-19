//
//  YHDragSortGridView.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/19.
//

#import "YHDragSortGridView.h"
#import "YHLongPressDragGestureRecognizer.h"

@interface YHDragSortGridView()<YHLongPressDragGestureDelegate>

@property (nonatomic, strong) YHLongPressDragGestureRecognizer *longGest;

@property (nonatomic, strong) NSMutableArray *subItemViews;

@property (nonatomic, strong) UIView *movView;
@property (nonatomic, strong) UIImageView *iv;

@property (nonatomic, assign) NSInteger colNum;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end

@implementation YHDragSortGridView

- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    YHLongPressDragGestureRecognizer *longGest = [[YHLongPressDragGestureRecognizer alloc] init];
    longGest.movDelegate = self;
    [self addGestureRecognizer:longGest];
    _longGest = longGest;
}

// Mark - MovLongPressGestureRecognizerDelegate
-(BOOL)yh_LongPressDragGestureBegin: (CGPoint)point{
    __block UIView *targetView = nil;
    [self.subItemViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        if (view.alpha > 0) {
            CGRect rect = [self convertRect:view.frame fromView:view.superview];
            if (CGRectContainsPoint(rect, point)) {
                targetView = view;
                self.iv.frame = rect;
                
                UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, view.window.screen.scale);
                [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
                self.iv.image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                self.iv.transform = CGAffineTransformMakeScale(1.1, 1.1);
                
                [self addSubview:self.iv];
                *stop = YES;
            }
        }
    }];
    self.movView = targetView;
    self.movView.alpha = 0;
    return targetView?YES:NO;
}

-(void)yh_LongPressDragGestureMove: (CGPoint)point{
    self.iv.center = point;

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
        [self.subItemViews exchangeObjectAtIndex:[self.subItemViews indexOfObject:targetView] withObjectAtIndex:[self.subItemViews indexOfObject:self.movView]];
        [self refreshSubItemPosition];
        [self bringSubviewToFront:self.iv];
    }
}

-(void)yh_LongPressDragGestureEnd{
    [self.iv removeFromSuperview];
    self.iv.transform = CGAffineTransformIdentity;
    self.movView.alpha = 1;
}

-(void)setViews: (NSArray<UIView*>*)views
         colNum: (NSInteger)colNum
      itemWidth: (CGFloat)itemWidth
    itemSpacing: (CGFloat)itemSpacing
     itemHeight: (CGFloat)itemHeight
     edgeInsets: (UIEdgeInsets)edgeInsets{
    [self.subItemViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.subItemViews = [NSMutableArray arrayWithArray:views];
    
    if (self.subItemViews.count % colNum > 0) {
        NSInteger count = colNum - (self.subItemViews.count % colNum);
        for(int i = 0 ; i < count; i++){
            UIView *itemView = [[UIView alloc] init];
            itemView.alpha = 0;
            [self.subItemViews addObject:itemView];
        }
    }
    
    _colNum = colNum;
    _itemWidth = itemWidth;
    _itemSpacing = itemSpacing;
    _itemHeight = itemHeight;
    _edgeInsets = edgeInsets;
    
    [self.subItemViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.subItemViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:view];
    }];
    
    [self refreshSubItemPosition];
}

-(void)refreshSubItemPosition{
    [self.subItemViews mas_remakeConstraints:^(MASConstraintMaker *make) {
            
    }];
    NSMutableArray *arrayOfArrays = [NSMutableArray array];
    NSUInteger count = self.subItemViews.count;
    int j = 0;
    while(count) {
        NSRange range = NSMakeRange(j, MIN(_colNum, count));
        NSArray *subArr = [self.subItemViews subarrayWithRange:range];
        [arrayOfArrays addObject:subArr];
        count -= range.length;
        j += range.length;
    }
    __block UIView *perView = nil;
    [arrayOfArrays enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.itemWidth > 0) {
            [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:self.itemWidth leadSpacing:self.edgeInsets.left tailSpacing:self.edgeInsets.right];
        } else {
            [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:self.itemSpacing leadSpacing:self.edgeInsets.left tailSpacing:self.edgeInsets.right];
        }
        [array mas_makeConstraints:^(MASConstraintMaker *make) {
            perView?make.top.mas_equalTo(perView.mas_bottom).offset(self.edgeInsets.top):make.top.offset(self.edgeInsets.top);
            make.height.mas_equalTo(self.itemHeight);
        }];
        perView = array.lastObject;
    }];
    [self.subItemViews.lastObject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-self.edgeInsets.bottom);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

- (UIImageView *)iv{
    if (_iv == nil) {
        _iv = [[UIImageView alloc] init];
    }
    return _iv;
}

@end

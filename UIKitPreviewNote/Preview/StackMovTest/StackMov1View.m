//
//  StackMov1View.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/19.
//

#import "StackMov1View.h"
#import "MovItemView.h"
#import "MovLongPressGestureRecognizer.h"

#define ColNum 4

@interface StackMov1View()<MovLongPressGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *lbTitle;

@property (nonatomic, strong) MovLongPressGestureRecognizer *longGest;

@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) UIView *movView;

@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) NSMutableArray *subItemViews;

@end

@implementation StackMov1View

- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.lbTitle];
    [self.lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.top.offset(12);
    }];
    
//    [self addSubview:self.stackView];
//    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(16);
//        make.top.mas_equalTo(self.lbTitle.mas_bottom).offset(10);
//        make.right.offset(-16);
//        make.bottom.offset(-10);
//    }];
    
    self.models = NSMutableArray.new;
    [self.models addObject:@"0"];
    [self.models addObject:@"1"];
    [self.models addObject:@"2"];
    [self.models addObject:@"3"];
    [self.models addObject:@"4"];
    
    [self createSubItem];
    [self refreshSubItemPosition];
    
    MovLongPressGestureRecognizer *longGest = [[MovLongPressGestureRecognizer alloc] init];
    longGest.movDelegate = self;
    [self addGestureRecognizer:longGest];
    _longGest = longGest;
}

// Mark - MovLongPressGestureRecognizerDelegate
-(BOOL)movLongPressGestureRecognizerBegin: (CGPoint)point{
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

-(void)movLongPressGestureRecognizerMove: (CGPoint)point{
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

-(void)movLongPressGestureRecognizerEnd{
    [self.iv removeFromSuperview];
    self.iv.transform = CGAffineTransformIdentity;
    self.movView.alpha = 1;
}

-(void)createSubItem{
    [self.subItemViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.subItemViews = NSMutableArray.new;
    [self.models enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
        MovItemView *itemView = [[MovItemView alloc] init];
        itemView.lb.text = str;
        [self.subItemViews addObject:itemView];
    }];
    if (self.subItemViews.count % ColNum > 0) {
        for(int i = 0 ; i < ColNum - (self.subItemViews.count % ColNum) ; i++){
            MovItemView *itemView = [[MovItemView alloc] init];
            itemView.alpha = 0;
            [self.subItemViews addObject:itemView];
        }
    }
}

-(void)refreshSubItemPosition{
    [self.subItemViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.subItemViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:view];
    }];
    NSMutableArray *arrayOfArrays = [NSMutableArray array];
    NSUInteger count = self.subItemViews.count;
    int j = 0;
    while(count) {
        NSRange range = NSMakeRange(j, MIN(ColNum, count));
        NSArray *subArr = [self.subItemViews subarrayWithRange:range];
        [arrayOfArrays addObject:subArr];
        count -= range.length;
        j += range.length;
    }
    __block UIView *perView = self.lbTitle;
    [arrayOfArrays enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger idx, BOOL * _Nonnull stop) {
        [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:50 leadSpacing:1 tailSpacing:1];
        [array mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(perView.mas_bottom).offset(1);
            make.height.mas_equalTo(50);
        }];
        perView = array.lastObject;
    }];
    [self.subItemViews.lastObject mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
    }];
}

- (UILabel *)lbTitle{
    if (_lbTitle == nil) {
        _lbTitle = UILabel.new;
        _lbTitle.text = @"标题";
        _lbTitle.backgroundColor = UIColor.grayColor;
    }
    return _lbTitle;
}

- (UIImageView *)iv{
    if (_iv == nil) {
        _iv = [[UIImageView alloc] init];
        _iv.backgroundColor = UIColor.redColor;
    }
    return _iv;
}

//- (void)add: (NSString*)title{
//    MovItemView *(^getItem)(void) = ^{
//        if ([self.stackView.arrangedSubviews.lastObject isKindOfClass:UIStackView.class]) {
//            UIStackView *stH = self.stackView.arrangedSubviews.lastObject;
//            for(MovItemView *lb in stH.arrangedSubviews){
//                if (lb.alpha == 0) {
//                    return lb;
//                }
//            }
//        }
//
//        NSMutableArray <MovItemView *>*lbArr = NSMutableArray.new;
//        for(int i = 0 ; i < ColNum ; i++){
//            MovItemView *lb = [[MovItemView alloc] init];;
//            lb.alpha = 0;
//            [lbArr addObject:lb];
//        }
//
//        UIStackView *stH = [[UIStackView alloc] initWithArrangedSubviews:lbArr];
//        stH.axis = UILayoutConstraintAxisHorizontal;
//        stH.distribution = UIStackViewDistributionEqualSpacing;
//        [self.stackView addArrangedSubview:stH];
//        return lbArr.firstObject;
//    };
//    MovItemView *lb = getItem();
//    lb.alpha = 1;
//    lb.lb.text = title;
//}

@end

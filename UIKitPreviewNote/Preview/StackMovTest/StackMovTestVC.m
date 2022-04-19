//
//  StackMovTestVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/19.
//

#import "StackMovTestVC.h"
#import "YHDragSortGridView.h"
#import "MovItemView.h"

@interface StackMovTestVC ()


@end

@implementation StackMovTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"StackMovTestVC";
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 10;
    [scrollView addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        make.width.mas_equalTo(scrollView.mas_width);
    }];
    
//    YHDragSortGridView *(^createBlock)(void) = ^{
//        YHDragSortGridView *view = [[YHDragSortGridView alloc] init];
//        [view setViews:[self createSubItemViews] colNum:4 itemWidth:50 itemSpacing:0 itemHeight:50 edgeInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
//        return view;
//    };
    
    void(^addStackSubBlock)(void) = ^{
        YHDragSortGridView *view = [[YHDragSortGridView alloc] init];
        [stackView addArrangedSubview:view];
        [view setViews:[self createSubItemViews] colNum:4 itemWidth:50 itemSpacing:0 itemHeight:50 edgeInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    };
    
    addStackSubBlock();
    addStackSubBlock();
    addStackSubBlock();
    addStackSubBlock();
    addStackSubBlock();
    addStackSubBlock();
    addStackSubBlock();
    addStackSubBlock();
    addStackSubBlock();
    addStackSubBlock();
    addStackSubBlock();
    addStackSubBlock();
}

- (NSArray<UIView *> *)createSubItemViews{
    NSMutableArray *models = NSMutableArray.new;
    [models addObject:@"0"];
    [models addObject:@"1"];
    [models addObject:@"2"];
    [models addObject:@"3"];
    [models addObject:@"4"];
    NSMutableArray *views = NSMutableArray.new;
    [models enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * _Nonnull stop) {
        MovItemView *itemView = [[MovItemView alloc] init];
        itemView.lb.text = str;
        [views addObject:itemView];
    }];
    return views;
}

@end

//
//  DrawShapTestVC.m
//  UIKitPreviewNote
//
//  Created by EDY on 2024/10/31.
//

#import "DrawShapTestVC.h"
#import "DrawShapTestView.h"
#import "DrawMoveToPointView.h"
#import "DrawLineToPointView.h"
#import "DrawAddQuadCurveToPointView.h"

@interface DrawShapTestVC ()<DrawPointDelegate>

@property (nonatomic, strong) DrawShapTestView *drawView;

@property (nonatomic, strong) UIButton *createBtn;

@property (nonatomic, strong) UIButton *exportBtn;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation DrawShapTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.drawView];
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(4);
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(400);
    }];
    
    [self.view addSubview:self.createBtn];
    [self.createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
    }];
    
    [self.view addSubview:self.exportBtn];
    [self.exportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.createBtn.mas_bottom).offset(4);
        make.left.mas_equalTo(15);
    }];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.drawView.mas_bottom).offset(4);
        make.left.bottom.right.mas_equalTo(0);
    }];
    
    [self.drawView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)]];
}

- (void)clickCreate {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Create" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"MoveToPoint" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DrawMoveToPointView *view = [[DrawMoveToPointView alloc] init];
        view.delegate = self;
        [self.stackView addArrangedSubview:view];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"addLineToPoint" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DrawLineToPointView *view = [[DrawLineToPointView alloc] init];
        view.delegate = self;
        [self.stackView addArrangedSubview:view];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"addQuadCurveToPoint" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DrawAddQuadCurveToPointView *view = [[DrawAddQuadCurveToPointView alloc] init];
        view.delegate = self;
        [self.stackView addArrangedSubview:view];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)clickExport {
    [self.stackView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([view isKindOfClass:[DrawPointBaseView class]]) {
            DrawPointBaseView *baseView = (DrawPointBaseView*)view;
            [baseView exportByRect:self.drawView.bounds];
        }
    }];
}

- (void)clickTap: (UITapGestureRecognizer*)sender {
    CGPoint point = [sender locationInView:sender.view];
    NSLog(@"clickTap=%@", NSStringFromCGPoint(point));
    __block CheckView *targetView = nil;
    [self.stackView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([view isKindOfClass:[DrawPointBaseView class]]) {
            DrawPointBaseView *baseView = (DrawPointBaseView*)view;
            [baseView.checkSubViews enumerateObjectsUsingBlock:^(CheckView * _Nonnull checkView, NSUInteger idx, BOOL * _Nonnull stop) {
                if (checkView.check) {
                    targetView = checkView;
                }
            }];
        }
    }];
    targetView.point = point;
    
    self.drawView.drawViewList = self.stackView.arrangedSubviews;
}

- (void)drawPointSelectClick:(CheckView *)checkView {
    [self.stackView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([view isKindOfClass:[DrawPointBaseView class]]) {
            DrawPointBaseView *baseView = (DrawPointBaseView*)view;
            [baseView.checkSubViews enumerateObjectsUsingBlock:^(CheckView * _Nonnull checkView, NSUInteger idx, BOOL * _Nonnull stop) {
                checkView.check = NO;
            }];
        }
    }];
    checkView.check = YES;
}

- (void)drawPointDelete:(DrawPointBaseView *)view {
    [view removeFromSuperview];
    
    self.drawView.drawViewList = self.stackView.arrangedSubviews;
}

// MARK: - Getter

- (DrawShapTestView *)drawView {
    if (_drawView == nil) {
        _drawView = [[DrawShapTestView alloc] init];
        _drawView.backgroundColor = [UIColor whiteColor];
    }
    return _drawView;
}

- (UIButton *)createBtn {
    if (_createBtn == nil) {
        _createBtn = [[UIButton alloc] init];
        _createBtn.backgroundColor = UIColor.lightGrayColor;
        [_createBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _createBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_createBtn setTitle:@"Create" forState:UIControlStateNormal];
        [_createBtn addTarget:self action:@selector(clickCreate) forControlEvents:UIControlEventTouchUpInside];
    }
    return _createBtn;
}

- (UIButton *)exportBtn {
    if (_exportBtn == nil) {
        _exportBtn = [[UIButton alloc] init];
        _exportBtn.backgroundColor = UIColor.lightGrayColor;
        [_exportBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _exportBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_exportBtn setTitle:@"export" forState:UIControlStateNormal];
        [_exportBtn addTarget:self action:@selector(clickExport) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exportBtn;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView addSubview:self.stackView];
        [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
            make.width.mas_equalTo(_scrollView);
        }];
    }
    return _scrollView;
}

- (UIStackView *)stackView {
    if (_stackView == nil) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisVertical;
    }
    return _stackView;
}

@end

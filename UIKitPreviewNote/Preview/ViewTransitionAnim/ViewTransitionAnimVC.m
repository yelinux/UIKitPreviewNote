//
//  ViewTransitionAnimVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/13.
//

#import "ViewTransitionAnimVC.h"
#import "ViewTransitionView.h"
#import "StackTransitionView.h"

@interface ViewTransitionAnimVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ViewTransitionView *trView;

@end

@implementation ViewTransitionAnimVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"ViewTransitionAnim";
    self.view.backgroundColor = UIColor.whiteColor;
    
    ViewTransitionView *trView = [[ViewTransitionView alloc] init];
    [self.view addSubview:trView];
    [trView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
    }];
    _trView = trView;
    
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = UIColor.blueColor;
    [btn setTitle:@"转换" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickSw) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.mas_equalTo(trView.mas_bottom).offset(10);
        make.width.mas_equalTo(80);
    }];
    
    StackTransitionView *stView = [[StackTransitionView alloc] init];
    [self.view addSubview:stView];
    [stView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn.mas_bottom).offset(0);
        make.left.right.offset(0);
    }];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 50;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(stView.mas_bottom).offset(0);
        make.left.offset(0);
        make.bottom.right.offset(0);
    }];
}

-(void)clickSw{
    _trView.sw = !_trView.sw;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 300 && !_trView.sw) {
        _trView.sw = YES;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    } else if (scrollView.contentOffset.y <= 300 &&_trView.sw){
        _trView.sw = NO;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"item-%ld", indexPath.row];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

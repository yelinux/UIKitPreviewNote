//
//  TabBarDemoVC.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/4/7.
//

#import "TabBarDemoVC.h"

@interface TabBarSubVC : UIViewController

@end

@interface TabBarDemoVC ()

@end

@implementation TabBarDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIViewController *(^createBlock)(NSString *title) = ^(NSString *title){
        TabBarSubVC *vc = [[TabBarSubVC alloc] init];
        vc.title = title;
        return vc;
    };
    [self addChildViewController:createBlock(@"tab1")];
    [self addChildViewController:createBlock(@"tab2")];
    [self addChildViewController:createBlock(@"tab3")];
    
    //设置未选中的TabBarItem的字体颜色、大小
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor blueColor];
    //设置选中了的TabBarItem的字体颜色、大小
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearnace = [[UITabBarAppearance alloc] init];
        appearnace.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttrs;
        appearnace.stackedLayoutAppearance.normal.titleTextAttributes = attrs;
        
        self.tabBar.standardAppearance = appearnace;
        if (@available(iOS 15.0, *)) {
            self.tabBar.scrollEdgeAppearance = appearnace;
        } else {
            // Fallback on earlier versions
        }
    } else {
        [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
            [vc.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
            [vc.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        }];
    }
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

@implementation TabBarSubVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UILabel *(^createBlock)(NSString *str) = ^(NSString *str){
        UILabel *lb = UILabel.new;
        lb.textColor = UIColor.blackColor;
        lb.text = str;
        return lb;
    };
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    [scrollView addSubview:stackView];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        make.width.mas_equalTo(scrollView.mas_width);
    }];
    
    for (int i = 0 ; i < 100 ; i++){
        [stackView addArrangedSubview:createBlock([NSString stringWithFormat:@"item %d", i])];
    }
    
    //高斯模糊
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, 100, 50);
    [self.view addSubview:effectView];
}

@end

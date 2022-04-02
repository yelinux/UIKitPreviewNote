//
//  AppDelegate.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    ExampleViewController *vc = [[ExampleViewController alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.yh_interactivePopType = YHNavigationInteractivePopTypeFullScreen;
    nav.yh_pushPopAnimated = [[YHNavigationScaleAnimated alloc] init];
    nav.yh_navBackgroundColor = [UIColor whiteColor];
    nav.yh_titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:20/255.0 green:122/255.0 blue:244/255.0 alpha:1]};
    nav.yh_shadowColor = UIColor.blueColor;
    nav.navigationBar.translucent = NO;
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    [UITableView appearance].estimatedRowHeight = 0;
    [UITableView appearance].estimatedSectionHeaderHeight = 0;
    [UITableView appearance].estimatedSectionFooterHeight = 0;
    //适配iOS11的tableView问题
    if (@available(iOS 11, *)) {
      [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; //iOS11 解决SafeArea的问题，同时能解决pop时上级页面scrollView抖动的问题
    }
    //适配iOS15的tableView问题
    if (@available(iOS 15.0, *)) {
        [UITableView appearance].sectionHeaderTopPadding = 0;
    }
    
    return YES;
}


@end

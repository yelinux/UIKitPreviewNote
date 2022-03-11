//
//  AppDelegate.m
//  UIKitPreviewNote
//
//  Created by chenyehong on 2022/3/11.
//

#import "AppDelegate.h"
#import "YHNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    ExampleViewController *vc = [[ExampleViewController alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateInitialViewController];
    
    YHNavigationController *nav = [[YHNavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.translucent = NO;
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearnace = [[UINavigationBarAppearance alloc] init];
        [appearnace configureWithOpaqueBackground];
        appearnace.backgroundColor = UIColor.whiteColor;//背景色
        nav.navigationBar.standardAppearance = appearnace;
        nav.navigationBar.scrollEdgeAppearance = appearnace;
    } else {
        // Fallback on earlier versions
        [nav.navigationBar setBarTintColor:UIColor.whiteColor];//背景色
    }
    
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

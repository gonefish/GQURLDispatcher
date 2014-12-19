//
//  GQAppDelegate.m
//  GQURLDispatcherExample
//
//  Created by Qian GuoQiang on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQAppDelegate.h"
#import "GQTabBarResponder.h"
#import "GQNavigationResponder.h"
#import "GQURLDispatcher.h"
#import "GQFirstViewController.h"
#import "GQSecondViewController.h"

@implementation GQAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launca.
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    GQFirstViewController *firstViewController = [[GQFirstViewController alloc] init];
    
    UINavigationController *nVC1 = [[UINavigationController alloc] initWithRootViewController:firstViewController];
    nVC1.tabBarItem.image = [UIImage imageNamed:@"first"];
    
    GQSecondViewController *secondViewController = [[GQSecondViewController alloc] init];
    
    UINavigationController *nVC2 = [[UINavigationController alloc] initWithRootViewController:secondViewController];
    nVC2.tabBarItem.image = [UIImage imageNamed:@"second"];
    
    tabBarController.viewControllers = @[nVC1, nVC2];
    
    [self setupURLDispatcher];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setupURLDispatcher
{
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    GQTabBarResponder *tabBarResponder =
    [[GQTabBarResponder alloc] initWithTabBarController:tabBarController
                                                withURL:[NSURL URLWithString:@"gqurl://tabBarController/selectedIndex"]];
    [[GQURLDispatcher sharedInstance] registerResponder:tabBarResponder];
    
    
    NSArray *responseURLs = @[[NSURL URLWithString:@"gqurl://firstViewController"], [NSURL URLWithString:@"gqurl://secondViewController"]];
    NSDictionary *classNameMap = @{@"gqurl://firstViewController": @"GQFirstViewController", @"gqurl://secondViewController": @"GQSecondViewController"};
    
    GQNavigationResponder *navigationResponder1 = [[GQNavigationResponder alloc] initWithNavigationController:tabBarController.viewControllers[0]];
    
    navigationResponder1.responseURLs = responseURLs;
    navigationResponder1.classNameMap = classNameMap;
    
    GQNavigationResponder *navigationResponder2 = [[GQNavigationResponder alloc] initWithNavigationController:tabBarController.viewControllers[1]];
    
    navigationResponder2.responseURLs = responseURLs;
    navigationResponder2.classNameMap = classNameMap;
    
    [[GQURLDispatcher sharedInstance] registerResponder:navigationResponder1];
    [[GQURLDispatcher sharedInstance] registerResponder:navigationResponder2];
    
}

@end

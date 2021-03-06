//
//  GQAppDelegate.m
//  GQURLDispatcherExample
//
//  Created by Qian GuoQiang on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQAppDelegate.h"
#import "GQFirstViewController.h"
#import "GQSecondViewController.h"
#import <GQURLDispatcher/GQURLDispatcher.h>
#import <GQURLDispatcher/GQResponers.h>

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
                                                URL:GQURL(@"tab://example/")];
    
    [[GQURLDispatcher sharedInstance] registerResponder:tabBarResponder];
    
    
    NSDictionary *classNameMap = @{@"gqurl://firstViewController": @"GQFirstViewController",
                                   @"gqurl://secondViewController": @"GQSecondViewController"};
    
    NSDictionary *storyboardIdentifierMap = @{@"gqurl://thirdViewController": @"thirdViewController"};
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    GQNavigationResponder *navigationResponder1 = [[GQNavigationResponder alloc] initWithContainerViewController:tabBarController.viewControllers[0] alias:@"nav1"];
    
    navigationResponder1.classNameMap = classNameMap;
    navigationResponder1.storyboardIdentifierMap = storyboardIdentifierMap;
    
    [[GQURLDispatcher sharedInstance] registerResponder:navigationResponder1];
    
    
    GQNavigationResponder *navigationResponder2 = [[GQNavigationResponder alloc] initWithContainerViewController:tabBarController.viewControllers[1] alias:@"nav2"];
    
    navigationResponder2.classNameMap = classNameMap;
    navigationResponder2.storyboardIdentifierMap = storyboardIdentifierMap;
    
    [[GQURLDispatcher sharedInstance] registerResponder:navigationResponder2];
    
    
    GQPresentResponder *presentResponder = [[GQPresentResponder alloc] initWithContainerViewController:tabBarController alias:@"present"];
    
    presentResponder.classNameMap = @{@"modal://firstViewController": @"GQFirstViewController"};;
    
    [[GQURLDispatcher sharedInstance] registerResponder:presentResponder];
}

@end

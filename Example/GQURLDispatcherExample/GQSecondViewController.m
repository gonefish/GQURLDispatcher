//
//  GQSecondViewController.m
//  GQURLDispatcherExample
//
//  Created by Qian GuoQiang on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQSecondViewController.h"
#import "GQURLDispatcher.h"
#import "GQNavigationResponder.h"

@implementation GQSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Second";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectTabBar:(id)sender
{
    [GQURLDispatcher dispatchURL:[NSURL URLWithString:@"tab://example/?selectedIndex=0"]];
}

- (IBAction)pushViewController:(UIButton *)sender
{
    if (sender.tag == 1) {
        [GQURLDispatcher dispatchURL:[NSURL URLWithString:@"gqurl://firstViewController"]];
    } else if (sender.tag == 2) {
        [GQURLDispatcher dispatchURL:[NSURL URLWithString:@"gqurl://secondViewController"]];
    }
}

- (IBAction)backAction:(id)sender
{
    GQNavigationResponder *nav1 = [[GQURLDispatcher sharedInstance] responderForAlias:@"nav1"];
    
    GQNavigationResponder *nav2 = [[GQURLDispatcher sharedInstance] responderForAlias:@"nav2"];
    
    
    if (self.navigationController.tabBarController.selectedViewController == nav1.containerViewController) {
        [(UINavigationController *)nav1.containerViewController popViewControllerAnimated:YES];
    } else {
        [(UINavigationController *)nav2.containerViewController popViewControllerAnimated:YES];
    }
    
    return;
}

@end

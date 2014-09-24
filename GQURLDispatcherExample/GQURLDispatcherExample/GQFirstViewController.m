//
//  GQFirstViewController.m
//  GQURLDispatcherExample
//
//  Created by Qian GuoQiang on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQFirstViewController.h"
#import "GQURLDispatcher.h"


@implementation GQFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"First";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectTabBar:(id)sender
{
    [[GQURLDispatcher sharedInstance] dispatchURL:[NSURL URLWithString:@"gqurl://tabBarController/selectedIndex?GQTabBarIndex=1"]];
}

- (IBAction)pushViewController:(UIButton *)sender
{
    if (sender.tag == 1) {
       [[GQURLDispatcher sharedInstance] dispatchURL:[NSURL URLWithString:@"gqurl://firstViewController"]];
    } else if (sender.tag == 2) {
        [[GQURLDispatcher sharedInstance] dispatchURL:[NSURL URLWithString:@"gqurl://secondViewController"]];
    }
}

@end
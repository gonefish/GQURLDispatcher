//
//  GQSecondViewController.m
//  GQURLDispatcherExample
//
//  Created by Qian GuoQiang on 14-9-12.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQSecondViewController.h"
#import "GQURLDispatcher.h"

@implementation GQSecondViewController

- (void)viewDidLoad
{
    self.tabbarURL = GQURL(@"tab://example/?selectedIndex=0");
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Second View Controller";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

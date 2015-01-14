//
//  ExampleTableViewController.m
//  GQURLDispatcherExample
//
//  Created by 钱国强 on 15/1/7.
//  Copyright (c) 2015年 Qian GuoQiang. All rights reserved.
//

#import "ExampleTableViewController.h"
#import "GQURLDispatcher.h"
#import "GQNavigationResponder.h"
#import "GQPresentResponder.h"
#import "GQCompletionWrapper.h"

@interface ExampleTableViewController ()

@property (nonatomic, strong) NSArray *items;



@end

@implementation ExampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (self.tabbarURL == nil) {
        self.tabbarURL = [NSURL URLWithString:@"tab://example/?selectedIndex=1"];
    }
    
    self.items = @[
  @{@"title": @"Select TabBar", @"url": self.tabbarURL},
  @{@"title": @"Push First View Controller", @"url": [NSURL URLWithString:@"gqurl://firstViewController"]},
  @{@"title": @"Push Second View Controller", @"url": [NSURL URLWithString:@"gqurl://secondViewController"]},
  @{@"title": @"Push Third View Controller", @"url": [NSURL URLWithString:@"gqurl://thirdViewController"]},
  @{@"title": @"Pop View Controller", @"url": @"" },
  @{@"title": @"Present and Dismiss View Controller", @"url": [NSURL URLWithString:@"modal://firstViewController"]}
  ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExampleTableViewCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExampleTableViewCell"];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[self.items objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        GQNavigationResponder *nav1 = [[GQURLDispatcher sharedInstance] responderForAlias:@"nav1"];
        
        GQNavigationResponder *nav2 = [[GQURLDispatcher sharedInstance] responderForAlias:@"nav2"];
        
        
        if (self.navigationController.tabBarController.selectedViewController == nav1.containerViewController) {
            [(UINavigationController *)nav1.containerViewController popViewControllerAnimated:YES];
        } else {
            [(UINavigationController *)nav2.containerViewController popViewControllerAnimated:YES];
        }
    } else if (indexPath.row == 5) {
        GQCompletionWrapper *blockObj = [GQCompletionWrapper completionBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            GQPresentResponder *presentResponder = [[GQURLDispatcher sharedInstance] responderForAlias:@"present"];
                
            [presentResponder.containerViewController dismissViewControllerAnimated:YES
                                                                         completion:nil];
});
        }];
        
        [GQURLDispatcher dispatchURL:[[self.items objectAtIndex:indexPath.row] objectForKey:@"url"]
                          withObject:blockObj];
    } else {
        [GQURLDispatcher dispatchURL:[[self.items objectAtIndex:indexPath.row] objectForKey:@"url"]];
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

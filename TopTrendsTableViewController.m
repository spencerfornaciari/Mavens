//
//  TopTrendsTableViewController.m
//  Mavens
//
//  Created by Spencer Fornaciari on 3/19/14.
//  Copyright (c) 2014 Spencer Fornaciari. All rights reserved.
//

#import "TopTrendsTableViewController.h"
#import <Parse/Parse.h>

@interface TopTrendsTableViewController ()
- (IBAction)sortTrends:(id)sender;

@end

@implementation TopTrendsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Trends"];
//    query.limit = 15;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                NSSortDescriptor *dateSorter = [[NSSortDescriptor alloc] initWithKey:@"numberOfLikes" ascending:NO];
                //                NSLog(@"By age: %@", [objects sortedArrayUsingDescriptors:@[dateSorter]]);
                
                NSMutableArray *tempArray = [NSMutableArray new];
                
                NSLog(@"Object: %@", [objects[0] objectForKey:@"trend"]);
                
                for (PFObject *object in objects) {
                    Trend *trend = [Trend new];
                    trend.trendName = [object objectForKey:@"trend"];
                    trend.likes = [[object objectForKey:@"numberOfLikes"] integerValue];
                    trend.dislikes = [[object objectForKey:@"numberOfDislikes"] integerValue];
                    
                    [tempArray addObject:trend];
                    
                    NSLog(@"%@", trend.trendName);
                }
                
                NSSortDescriptor *dateSorter = [[NSSortDescriptor alloc] initWithKey:@"likes" ascending:NO];
                
                self.topTrendsArray = [tempArray sortedArrayUsingDescriptors:@[dateSorter]]; //[[objects sortedArrayUsingDescriptors:@[dateSorter]]mutableCopy];
                
                [self.tableView reloadData];
            }];
            
            //            for (int i = 0; i < self.array.count; i++) {
            //                NSLog(@"%@", [self.array[i] objectForKey:@"trend"]);
            //                NSLog(@"%@", [self.array[i] objectForKey:@"user"]);
            //            }
            
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            //                    for (PFObject *object in objects) {
            //                        NSString *trend = object[@"trend"];
            //                        NSLog(@"%@", trend);
            //                    }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    for (Trend *trend in self.topTrendsArray) {
        NSLog(@"%d", trend.likes);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.topTrendsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    [cell setTrend:self.topTrendsArray[indexPath.row]];
    
//    cell.textLabel.text = [self.topTrendsArray[indexPath.row] objectForKey:@"trend"];
//    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"Likes: %@, Dislikes: %@", [self.topTrendsArray[indexPath.row] objectForKey:@"numberOfLikes"], [self.topTrendsArray[indexPath.row] objectForKey:@"numberOfDislikes"]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sortTrends:(id)sender {
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Sort Trends" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"By Agrees", @"By Disagress", nil];
    
    [action showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            NSSortDescriptor *dateSorter = [[NSSortDescriptor alloc] initWithKey:@"likes" ascending:NO];
            self.topTrendsArray = [self.topTrendsArray sortedArrayUsingDescriptors:@[dateSorter]];
            [self.tableView reloadData];
        }
            break;
        case 1:
        {
            NSSortDescriptor *dateSorter = [[NSSortDescriptor alloc] initWithKey:@"dislikes" ascending:NO];
            self.topTrendsArray = [self.topTrendsArray sortedArrayUsingDescriptors:@[dateSorter]];
            [self.tableView reloadData];
        }
           
            break;
            
        default:
            break;
    }
}
@end

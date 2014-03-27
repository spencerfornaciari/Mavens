//
//  CurrentTopTrendsTableViewController.m
//  Mavens
//
//  Created by Spencer Fornaciari on 3/18/14.
//  Copyright (c) 2014 Spencer Fornaciari. All rights reserved.
//

#import "TrendResponseTableViewController.h"
#import <Parse/Parse.h>

@interface TrendResponseTableViewController ()

@property (nonatomic) NSArray *array;

- (IBAction)loginButtonAction:(id)sender;

@end

@implementation TrendResponseTableViewController

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
    
    NSLog(@"%@", [PFUser currentUser]);
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Trends"];
    
    // Only retrieve the last twenty
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.array = objects;
                NSSortDescriptor *dateSorter = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
                //                NSLog(@"By age: %@", [objects sortedArrayUsingDescriptors:@[dateSorter]]);
                
                self.array = [objects sortedArrayUsingDescriptors:@[dateSorter]];
                
                [self.tableView reloadData];
            }];
            
            //            for (int i = 0; i < self.array.count; i++) {
            //                NSLog(@"%@", [self.array[i] objectForKey:@"trend"]);
            //                NSLog(@"%@", [self.array[i] objectForKey:@"user"]);
            //            }
            
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
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.array[indexPath.row] objectForKey:@"trend"];
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    EvaluationViewController *viewController = [segue destinationViewController];
    viewController.title = [self.array[indexPath.row] objectForKey:@"trend"];
    viewController.currentObject = self.array[indexPath.row];
}


- (IBAction)loginButtonAction:(id)sender {
    
    if (![PFUser currentUser]) {
        [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
            if (!user) {
                NSLog(@"Uh oh. The user cancelled the Twitter login.");
                return;
            } else if (user.isNew) {
                NSLog(@"User signed up and logged in with Twitter!");
            } else {
                NSLog(@"User logged in with Twitter!");
                
                //Querying Parse for trends
                
            }
        }];
    } else {
        NSLog(@"%@", [PFUser currentUser]);
    }
}
@end

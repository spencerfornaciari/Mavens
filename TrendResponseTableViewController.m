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
@property (nonatomic) PFObject *trendResponse;
@property (nonatomic) NSArray *secondArray;

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
    /*
    PFQuery *query = [PFQuery queryWithClassName:@"Trends"];
//    [query orderByAscending:@"createdAt"];
    [query orderByDescending:@"createdAt"];
    query.limit = 10;

    [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        if (comments.count) {
            for (PFObject *object in comments) {
                self.trendResponse = object;
            
            
            PFRelation *relation = self.trendResponse[@"agrees"];
            
            PFQuery *query2 = relation.query;
            [query2 orderByDescending:@"createdAt"];
            [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (objects) {
                    NSLog(@"%@", objects);
                } else {
                    NSLog(@"Didn't Work");
                }
            }];
            }
        }
    }];
    */
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName
           value:@"Trend Response Screen"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];

    PFQuery *query = [PFQuery queryWithClassName:@"Activity"];
    
    // Only retrieve the last twenty´
    //    [query whereKey:(NSString *) notEqualTo:<#(id)#>
    [query whereKey:@"fromUser" notEqualTo:[PFUser currentUser]];
    
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            
            
            NSMutableSet* existingNames = [NSMutableSet set];
            NSMutableArray* filteredArray = [NSMutableArray array];
            
            
            for (PFObject *object in objects) {
                if (![existingNames containsObject:[object objectForKey:@"trend"]]) {
                    [existingNames addObject:[object objectForKey:@"trend"]];
                    [filteredArray addObject:object];
                }
            }
            
            
//            NSMutableArray *array = [NSMutableArray new];
//            NSInteger index = [array count] - 1;
////            
//            for (PFObject *object in objects) {
//                [array addObjectsFromArray:object.objectId];
//            }
//            
//
//                
////            [uniqueArray addObjectsFromArray:[[NSSet setWithArray:array1] allObjects]];
//
//
//            NSMutableArray *uniquearray = [NSMutableArray new];
//            [uniquearray addObjectsFromArray:[[NSSet setWithArray:objects] allObjects]];
//            
//            
//            for (PFObject *object in [array reverseObjectEnumerator]) {
////                NSLog(@"All ObjectID: %@", object.objectId);
//
//                if ([objects indexOfObject:[object objectForKey:@"trend"] inRange:NSMakeRange(0, index)] != NSNotFound) {
//                    NSLog(@"Not Found: ObjectID: %@", object.objectId);
//                    
//                    [array removeObjectAtIndex:index];
//                
//                
//                }
//                
//                
//                
//                index--;
//            }
//            
//            for (PFObject *object in uniquearray) {
//                NSLog(@"Final Object ID: %@", object);
//            }
            
//            NSLog(@"Object Ids: %@", array);
            
//            NSArray *copy = [mutableArray copy];
//            NSInteger index = [copy count] - 1;
//            for (id object in [copy reverseObjectEnumerator]) {
//                if ([mutableArray indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
//                    [mutableArray removeObjectAtIndex:index];
//                }
//                index--;
//            }
//            [copy release];
            
//            PFQuery *query2 = [PFQuery queryWithClassName:@"Activity"];
//            [query2 whereKey:@"trend" containsAllObjectsInArray:<#(NSArray *)#>]
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //self.array = objects;
                NSLog(@"Filtered Count: %d", filteredArray.count);
                
                NSLog(@"Property Count: %d", self.array.count);
                NSSortDescriptor *dateSorter = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
                //                NSLog(@"By age: %@", [objects sortedArrayUsingDescriptors:@[dateSorter]]);
                
                self.array = [filteredArray sortedArrayUsingDescriptors:@[dateSorter]];
                NSLog(@"%@", self.array);
                
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
    
    NSLog(@"Table View Count: %d", self.array.count);
    
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.array[indexPath.row] objectForKey:@"trendName"];
    
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
    

}
@end

//
//  EvaluationViewController.m
//  Mavens
//
//  Created by Spencer Fornaciari on 3/19/14.
//  Copyright (c) 2014 Spencer Fornaciari. All rights reserved.
//

#import "EvaluationViewController.h"

@interface EvaluationViewController ()

@property (nonatomic) BOOL canLike;

@property (strong, nonatomic) IBOutlet UIButton *goodCallButton;
@property (strong, nonatomic) IBOutlet UIButton *poorChoiceButton;

- (IBAction)goodCallAction:(id)sender;
- (IBAction)poorChoiceAction:(id)sender;


@end

@implementation EvaluationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.goodCallButton.backgroundColor = [UIColor greenColor];
    self.goodCallButton.tintColor  = [UIColor whiteColor];
    self.poorChoiceButton.backgroundColor = [UIColor redColor];
    self.poorChoiceButton.tintColor  = [UIColor whiteColor];
    
    NSString *currentUser = (NSString *)[[PFUser currentUser] objectId];
    
    
    _canLike = TRUE;
    
//    PFQuery *query = [PFQuery queryWithClassName:@"TrendResponse"];
//    [query whereKey:@"parent" equalTo:self.currentObject.objectId];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *responses, NSError *error) {
//        NSLog(@"%@", responses);
//        //        NSLog(@"%@", responses[0]);
//     }];
    
    NSString *trend = [self.currentObject objectForKey:@"trend"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"TrendResponse"];
    [query whereKey:@"trend" equalTo:trend];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
        
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSString *objectUser = [[object objectForKey:@"trendResponder"] objectId];
                if ([objectUser isEqualToString:currentUser]) {
                    _canLike = FALSE;
                    break;
                }
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
//    [query whereKey:@"trendResponder" equalTo:[PFUser currentUser]];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            // The find succeeded.
//            NSLog(@"Successfully retrieved %d scores.", objects.count);
//            // Do something with the found objects
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//            }
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
//    
    
    
//    PFQuery *query = [PFQuery queryWithClassName:@"TrendResponse"];
//    [query whereKey:@"trend" equalTo:self.currentObject];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *responses, NSError *error) {
//        // comments now contains the comments for myPost
//        NSLog(@"%@", responses[0]);
//    }];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goodCallAction:(id)sender {
    if (_canLike) {
        PFObject *trendResponse = [PFObject objectWithClassName:@"TrendResponse"];
        trendResponse[@"trendResponse"] = @"Agree";
        trendResponse[@"trendResponder"] = [PFUser currentUser];
        trendResponse[@"trend"] = [self.currentObject objectForKey:@"trend"];
        //
        //    // Add a relation between the Post and Comment
        trendResponse[@"parent"] = self.currentObject;
        
        [trendResponse saveInBackground];
        
        //    [self.currentObject incrementKey:@"numberOfLikes"];
        //    [self.currentObject saveInBackground];
        
        //    PFObject *trendResponse = [PFObject objectWithClassName:@"TrendResponse"];
        //    trendResponse[@"newTrend"] = @"Agree";
        //
        //    PFRelation *relation = [[PFUser currentUser] relationforKey:@"Likes"];
        //    [relation addObject:self.currentObject];
        //    [[PFUser currentUser] saveInBackground];
        
        [self.currentObject incrementKey:@"numberOfLikes"];
        [self.currentObject saveInBackground];
    } else {
        NSLog(@"You've Already Responded");
    }
    
    
}

- (IBAction)poorChoiceAction:(id)sender {
    if (_canLike) {
        PFObject *trendResponse = [PFObject objectWithClassName:@"TrendResponse"];
        trendResponse[@"trendResponse"] = @"Disagree";
        trendResponse[@"trendResponder"] = [PFUser currentUser];
        trendResponse[@"trend"] = [self.currentObject objectForKey:@"trend"];
        //
        //    // Add a relation between the Post and Comment
        trendResponse[@"parent"] = self.currentObject;
        
        [trendResponse saveInBackground];
        
        //    [self.currentObject incrementKey:@"numberOfLikes"];
        //    [self.currentObject saveInBackground];
        
        //    PFObject *trendResponse = [PFObject objectWithClassName:@"TrendResponse"];
        //    trendResponse[@"newTrend"] = @"Agree";
        //
        //    PFRelation *relation = [[PFUser currentUser] relationforKey:@"Likes"];
        //    [relation addObject:self.currentObject];
        //    [[PFUser currentUser] saveInBackground];
        
        [self.currentObject incrementKey:@"numberOfDislikes"];
        [self.currentObject saveInBackground];
    } else {
        NSLog(@"You've Already Responded");
    }
    
}
@end

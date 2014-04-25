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

@property (nonatomic) BOOL canVote;

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
    self.goodCallButton.backgroundColor = [UIColor mavenGreenColor];
    self.goodCallButton.tintColor  = [UIColor whiteColor];
    self.poorChoiceButton.backgroundColor = [UIColor mavenRedColor];
    self.poorChoiceButton.tintColor  = [UIColor whiteColor];
    
    _canLike = TRUE;
    
//    PFQuery *query = [PFQuery queryWithClassName:@"TrendResponse"];
//    [query whereKey:@"parent" equalTo:self.currentObject.objectId];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *responses, NSError *error) {
//        NSLog(@"%@", responses);
//        //        NSLog(@"%@", responses[0]);
//     }];
    /*
    PFQuery *query = [PFQuery queryWithClassName:@"Activity"];
    [query whereKey:@"trend" equalTo:self.currentObject.objectId];
    [query whereKey:@"fromUser" equalTo:[PFUser currentUser]];
    NSLog(@"%@", [self.currentObject objectForKey:@"trend"]);
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        // comments now contains the comments for myPost
        if (comments.count > 0) {
            _canVote = FALSE;
            NSLog(@"You've Voted Already");
        } else {
            _canVote = TRUE;
            NSLog(@"You Can Vote");
        }
        
        NSLog(@"%d", comments.count);
    }];
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"Activity"];
    [query2 whereKey:@"fromUser" notEqualTo:[PFUser currentUser]];
    
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        // comments now contains the comments for myPost
        NSLog(@"Number of trends to review: %d", comments.count);
    }];*/

    
//    PFQuery *query = [PFQuery queryWithClassName:@"TrendResponse"];
//    [query whereKey:@"trend" equalTo:trend];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//        
//            // Do something with the found objects
//            for (PFObject *object in objects) {
//                NSString *objectUser = [[object objectForKey:@"trendResponder"] objectId];
//                if ([objectUser isEqualToString:currentUser]) {
//                    _canLike = FALSE;
//                    break;
//                }
//            }
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
    
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName
           value:[NSString stringWithFormat:@"Evaluation Screen: %@", self.title]];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
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

//fromUser : User
//toUser : User
//type : String
//content : String
//photo : Pointer

- (IBAction)goodCallAction:(id)sender {
    
    if (_canVote) {
        PFObject *response = [PFObject objectWithClassName:@"Activity"];
        response[@"response"] = @"Confirm";
        response[@"fromUser"] = [PFUser currentUser];
        response[@"toUser"] = [self.currentObject objectForKey:@"creator"];
        response[@"trend"] = self.currentObject.objectId;
        
        PFRelation *relation = [response relationforKey:@"trend2"];
        [relation addObject:self.currentObject];
        [response saveInBackground];
        
        PFRelation *relation2 = [response relationforKey:@"responders"];
        [relation2 addObject:[PFUser currentUser]];
        [self.currentObject saveInBackground];
        
        [self.currentObject incrementKey:@"numberOfLikes"];
        [self.currentObject saveInBackground];
        _canVote = FALSE;
    }
    
    
    
//    PFRelation *relation = [self.currentObject relationforKey:@"agrees"];
//    [relation addObject:[PFUser currentUser]];
//    [self.currentObject saveInBackground];
    
//    if (_canLike) {
//        PFObject *trendResponse = [PFObject objectWithClassName:@"TrendResponse"];
//        trendResponse[@"trendResponse"] = @"Agree";
//        trendResponse[@"trendResponder"] = [PFUser currentUser];
//        trendResponse[@"trend"] = [self.currentObject objectForKey:@"trend"];
//        //
//        //    // Add a relation between the Post and Comment
//        trendResponse[@"parent"] = self.currentObject;
//        
//        [trendResponse saveInBackground];
//        
//        //    [self.currentObject incrementKey:@"numberOfLikes"];
//        //    [self.currentObject saveInBackground];
//        
//        //    PFObject *trendResponse = [PFObject objectWithClassName:@"TrendResponse"];
//        //    trendResponse[@"newTrend"] = @"Agree";
//        //
//        //    PFRelation *relation = [[PFUser currentUser] relationforKey:@"Likes"];
//        //    [relation addObject:self.currentObject];
//        //    [[PFUser currentUser] saveInBackground];
//        
//        [self.currentObject incrementKey:@"numberOfLikes"];
//    } else {
//        NSLog(@"You've Already Responded");
//    }
    
    
}

- (IBAction)poorChoiceAction:(id)sender {
    
    
    if (_canVote) {
        PFObject *response = [PFObject objectWithClassName:@"Activity"];
        response[@"response"] = @"Deny";
        response[@"fromUser"] = [PFUser currentUser];
        response[@"toUser"] = [self.currentObject objectForKey:@"creator"];
        response[@"trendID"] = self.currentObject.objectId;
        response[@"trend"] = self.currentObject.objectId;
        
//        response[@"toUser"] = [self.currentObject objectForKey:@"creator"];
//        response[@"trendName"] = [self.currentObject objectForKey:@"trend"];
//        response[@"trend"] = self.currentObject.objectId;
        [response saveInBackground];
        
//        [self.currentObject incrementKey:@"numberOfDislikes"];
//        [self.currentObject saveInBackground];
        _canVote = FALSE;
    }
    
    PFRelation *relation = [self.currentObject relationforKey:@"deny"];
    [relation addObject:[PFUser currentUser]];
    [self.currentObject saveInBackground];
    
//    if (_canLike) {
//        PFObject *trendResponse = [PFObject objectWithClassName:@"TrendResponse"];
//        trendResponse[@"trendResponse"] = @"Disagree";
//        trendResponse[@"trendResponder"] = [PFUser currentUser];
//        trendResponse[@"trend"] = [self.currentObject objectForKey:@"trend"];
//        //
//        //    // Add a relation between the Post and Comment
//        trendResponse[@"parent"] = self.currentObject;
//        
//        [trendResponse saveInBackground];
//        
//        //    [self.currentObject incrementKey:@"numberOfLikes"];
//        //    [self.currentObject saveInBackground];
//        
//        //    PFObject *trendResponse = [PFObject objectWithClassName:@"TrendResponse"];
//        //    trendResponse[@"newTrend"] = @"Agree";
//        //
//        //    PFRelation *relation = [[PFUser currentUser] relationforKey:@"Likes"];
//        //    [relation addObject:self.currentObject];
//        //    [[PFUser currentUser] saveInBackground];
//        
//        [self.currentObject incrementKey:@"numberOfDislikes"];
//        [self.currentObject saveInBackground];
//    } else {
//        NSLog(@"You've Already Responded");
//    }
    
}
@end

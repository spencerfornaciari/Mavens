//
//  EvaluationViewController.m
//  Mavens
//
//  Created by Spencer Fornaciari on 3/19/14.
//  Copyright (c) 2014 Spencer Fornaciari. All rights reserved.
//

#import "EvaluationViewController.h"

@interface EvaluationViewController ()
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

    NSLog(@"%@", self.currentObject);
    
    PFQuery *query = [PFQuery queryWithClassName:@"NewTrend"];
    [query whereKey:@"trend"
            equalTo:[PFObject objectWithoutDataWithClassName:@"trend" objectId:self.currentObject]];

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
//    PFObject *trendResponse = [PFObject objectWithClassName:@"TrendResponse"];
//    trendResponse[@"newTrend"] = @"Good Call";
//    
//    // Add a relation between the Post and Comment
//    trendResponse[@"parent"] = self.currentObject;
//    
//    [trendResponse saveInBackground];
    
    PFObject *trendResponse = [PFObject objectWithClassName:@"TrendResponse"];
    trendResponse[@"newTrend"] = @"Good Call";
    
    PFRelation *relation = [[PFUser currentUser] relationforKey:@"Likes"];
    [relation addObject:self.currentObject];
    [[PFUser currentUser] saveInBackground];
    
}

- (IBAction)poorChoiceAction:(id)sender {
    PFObject *trendResponse = [PFObject objectWithClassName:@"TrendResponse"];
    trendResponse[@"newTrend"] = @"Poor Choice";
    
    PFRelation *relation = [[PFUser currentUser] relationforKey:@"Dislikes"];
    [relation addObject:self.currentObject];
    [[PFUser currentUser] saveInBackground];
}
@end

//
//  SFNewTrendViewController.m
//  Mavens
//
//  Created by Spencer Fornaciari on 3/18/14.
//  Copyright (c) 2014 Spencer Fornaciari. All rights reserved.
//

#import "NewTrendViewController.h"
#import <Parse/Parse.h>
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@interface NewTrendViewController ()
@property (strong, nonatomic) IBOutlet UITextField *trendTextField;

@end

@implementation NewTrendViewController

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
    self.trendTextField.delegate = self;
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName
           value:@"New Trends Screen"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    PFObject *newTrend = [PFObject objectWithClassName:@"Trends"];
    newTrend[@"trend"] = textField.text;
    newTrend[@"numberOfLikes"] = @1;
    newTrend[@"numberOfDislikes"] = @0;
    newTrend[@"creator"] = [PFUser currentUser];
    [newTrend saveInBackground];
    
    NSLog(@"%@", newTrend.objectId);
    
    PFObject *response = [PFObject objectWithClassName:@"Activity"];
    response[@"response"] = @"Confirm";
    response[@"trendName"] = textField.text;
    response[@"fromUser"] = [PFUser currentUser];
    response[@"toUser"] = [PFUser currentUser];
//    response[@"trend"] = newTrend.objectId;
//
//    PFRelation *relation = [response relationforKey:@"trend2"];
//    [relation addObject:newTrend];
    [response saveInBackground];

    NSLog(@"%@", textField.text);
    
    textField.text = @"";
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

@end

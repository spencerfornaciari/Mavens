//
//  SFNewTrendViewController.m
//  Mavens
//
//  Created by Spencer Fornaciari on 3/18/14.
//  Copyright (c) 2014 Spencer Fornaciari. All rights reserved.
//

#import "NewTrendViewController.h"
#import <Parse/Parse.h>

@interface NewTrendViewController ()
@property (strong, nonatomic) IBOutlet UITextField *trendTextField;
@property (nonatomic) NSArray *categories;

@property (nonatomic) NSString *trendName, *trendCategory;

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
    self.numberOfCharactersRemaining.text = [NSString stringWithFormat:@"0/100"];
    self.categoryPicker.dataSource = self;
    self.categoryPicker.delegate = self;
    
    self.submissionButton.backgroundColor = [UIColor mavenRedColor];
    self.submissionButton.tintColor = [UIColor whiteColor];

    [self.trendTextField becomeFirstResponder];
    
    self.categories = [NSArray arrayWithObjects:@"One", @"Two", @"Three", nil];
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
    NSLog(@"%@", textField.text);
    
    self.trendName = textField.text;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    //Sets the trend length to 100 characters    
    self.numberOfCharactersRemaining.text = [NSString stringWithFormat:@"%d/100", newLength];
    return (newLength > 99) ? NO : YES;
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
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.categories.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.categories[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"Picked: %@", self.categories[row]);
    self.trendCategory = self.categories[row];
}

- (IBAction)trendSubmission:(id)sender {
    
    PFObject *newTrend = [PFObject objectWithClassName:@"Trends"];
    newTrend[@"trend"] = self.trendName;
    newTrend[@"category"] = self.trendCategory;
    newTrend[@"numberOfLikes"] = @1;
    newTrend[@"numberOfDislikes"] = @0;
    newTrend[@"creator"] = [PFUser currentUser];
    [newTrend saveInBackground];
    
    NSLog(@"%@", newTrend.objectId);
    
    PFObject *response = [PFObject objectWithClassName:@"Activity"];
    response[@"response"] = @"Confirm";
    response[@"trendName"] = self.trendName;
    response[@"trendCategory"] = self.trendCategory;
    response[@"fromUser"] = [PFUser currentUser];
    response[@"toUser"] = [PFUser currentUser];
    //    response[@"trend"] = newTrend.objectId;
    //
    //    PFRelation *relation = [response relationforKey:@"trend2"];
    //    [relation addObject:newTrend];
    [response saveInBackground];
    
    self.trendTextField.text = @"";
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"new_trend"     // Event label
                                                           value:nil] build]];    // Event value
}
@end

//
//  LoginViewController.m
//  Mavens
//
//  Created by Spencer Fornaciari on 3/18/14.
//  Copyright (c) 2014 Spencer Fornaciari. All rights reserved.
//

#import "LoginViewController.h"
#import "TrendResponseTableViewController.h"
#import <Parse/Parse.h>
#import "TrendResponseTableViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
    if (![PFUser currentUser]) {
        [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
            if (!user) {
                NSLog(@"Uh oh. The user cancelled the Twitter login.");
                return;
            } else if (user.isNew) {
                NSLog(@"User signed up and logged in with Twitter!");
            } else {
                NSLog(@"User logged in with Twitter!");
                
                UITabBarController *tabController = [self.storyboard instantiateViewControllerWithIdentifier:@"mavenTabController"];
                [self presentViewController:tabController animated:YES completion:nil];
                
            }
        }];
    } else {
        NSLog(@"%@", [PFUser currentUser]);
        UITabBarController *tabController = [self.storyboard instantiateViewControllerWithIdentifier:@"mavenTabController"];
        [self presentViewController:tabController animated:YES completion:nil];
    }
    
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

@end

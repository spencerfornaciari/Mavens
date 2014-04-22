//
//  TopTableViewCell.h
//  Mavens
//
//  Created by Spencer Fornaciari on 4/21/14.
//  Copyright (c) 2014 Spencer Fornaciari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trend.h"

@interface TopTableViewCell : UITableViewCell

@property (nonatomic) Trend *trend;
@property (strong, nonatomic) IBOutlet UILabel *trendLabel;
@property (strong, nonatomic) IBOutlet UILabel *agreeLabel;
@property (strong, nonatomic) IBOutlet UILabel *disagreeLabel;

-(void)setTrend:(Trend *)trend;

@end

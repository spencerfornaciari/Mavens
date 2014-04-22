//
//  TopTableViewCell.m
//  Mavens
//
//  Created by Spencer Fornaciari on 4/21/14.
//  Copyright (c) 2014 Spencer Fornaciari. All rights reserved.
//

#import "TopTableViewCell.h"

@implementation TopTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

-(void)setTrend:(Trend *)trend
{
    _trend = trend;

    self.trendLabel.text = trend.trendName;
    
    self.agreeLabel.text = [NSString stringWithFormat:@"%d", self.trend.likes];
    self.agreeLabel.tintColor = [UIColor whiteColor];
    self.agreeLabel.backgroundColor = [UIColor mavenGreenColor];
    
    self.disagreeLabel.text = [NSString stringWithFormat:@"%d", self.trend.dislikes];
    self.disagreeLabel.tintColor = [UIColor whiteColor];
    self.disagreeLabel.backgroundColor = [UIColor mavenRedColor];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];




    // Configure the view for the selected state
}

@end

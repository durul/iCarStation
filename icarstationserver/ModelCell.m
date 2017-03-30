//
//  ModelCell.m
//  icarstationserver
//
//  Created by durul dalkanat on 8/24/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import "ModelCell.h"

@implementation ModelCell
@synthesize nameLbl, checkoutLbl,ratingImgView,zoneLbl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)viewDidLoad
{
    self.nameLbl.font = [UIFont fontWithName:@"Eurostile-Oblique" size:15.f];
    self.checkoutLbl.font = [UIFont fontWithName:@"Eurostile-Oblique" size:15.f];
    self.zoneLbl.font = [UIFont fontWithName:@"Eurostile-Oblique" size:15.f];
    
}

@end

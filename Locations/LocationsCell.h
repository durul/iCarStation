//
//  LocationsCell.h
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationsCell : UITableViewCell {
    IBOutlet UILabel *title;
    IBOutlet UIButton *btn;
    NSMutableArray *items;
}

@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UIButton *btn;
@property (nonatomic, retain) NSMutableArray *items;

@property float currentLat;
@property float currentLong;

@end

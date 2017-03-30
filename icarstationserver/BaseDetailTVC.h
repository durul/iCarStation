//
//  BaseDetailTVC.h
//  icarstationserver
//
//  Created by durul dalkanat on 8/18/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Base.h"

@class BaseDetailTVC;
@protocol BaseDetailTVCDelegate <NSObject>
- (void)theSaveButtonOnTheRoleDetailTVCWasTapped:(BaseDetailTVC *)controller;
@end

@interface BaseDetailTVC : UITableViewController
@property (nonatomic, weak) id <BaseDetailTVCDelegate> delegate;

@property (strong, nonatomic) Base *role;
- (IBAction)save2:(id)sender;

@end
//
//  RoleDetailTVC.h
//  Staff Manager
//
//  Created by Durul Dalkanat on 14/02/12.
//  Copyright (c) 2012 Durul Dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Role.h"
#import "TimerViewController.h"

@class RoleDetailTVC;
@protocol RoleDetailTVCDelegate <NSObject>
- (void)theSaveButtonOnTheRoleDetailTVCWasTapped:(RoleDetailTVC *)controller;
@end

@interface RoleDetailTVC : UITableViewController <UITextFieldDelegate>  {
    NSInteger selectedTextFieldTag;
}

@property (nonatomic, weak) id <RoleDetailTVCDelegate> delegate;
@property (strong, nonatomic) Role *role;

// Date Configuration
@property (nonatomic) Boolean CheckOutChooserVisible;
@property (nonatomic) Boolean DateChooserVisible;
- (void)calculateDateDifferenceCheckOut:(NSDate *)aCheckOuttime;

//Save Button
- (IBAction)save:(id)sender;

//Picker Button Configuration
- (IBAction)checkOut:(id)sender;

- (IBAction)resignKeyboard:(id)sender;

@end
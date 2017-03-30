//
//  AddPersonTVC.h
//  Staff Manager
//
//  Created by Tim Roadley on 9/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "RolePickerTVCell.h"

@class AddPersonTVC;
@protocol AddPersonTVCDelegate <NSObject>
- (void)theSaveButtonOnTheAddPersonTVCWasTapped:(AddPersonTVC *)controller;
@end

@interface AddPersonTVC : UITableViewController <RolePickerTVCellDelegate>
@property (nonatomic, strong) id <AddPersonTVCDelegate> delegate;
//@property (strong, nonatomic) IBOutlet UITextField *personNameTextField;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField *personFirstnameTextField;
@property (strong, nonatomic) IBOutlet UITextField *personSurnameTextField;
@property (strong, nonatomic) IBOutlet RolePickerTVCell *personRoleTVCell;
@property (nonatomic, strong) Role *selectedRole;

- (IBAction)save:(id)sender;

@end






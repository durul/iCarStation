//
//  PersonDetailTVC.h
//  Staff Manager
//
//  Created by Durul Dalkanat on 14/02/12.
//  Copyright (c) 2012 Durul Dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "Role.h"
#import "PersonRoleTVC.h"
#import "FXImageView.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@class PersonDetailTVC;
@protocol PersonDetailTVCDelegate <NSObject>
- (void)theSaveButtonOnThePersonDetailTVCWasTapped:(PersonDetailTVC *)controller;
@end

@interface PersonDetailTVC : UITableViewController <PersonRoleTVCDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate> {
    NSInteger selectedTextFieldTag;
}

@property (nonatomic, weak) id <PersonDetailTVCDelegate> delegate;
@property (strong, nonatomic) Person *person;
@property (strong, nonatomic) Role *selectedRole;

@property (strong, nonatomic) IBOutlet UITableViewCell *personRoleTableViewCell;

// CoreData Image Configuration
@property (strong, nonatomic) IBOutlet FXImageView *imageField;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) Person *currentPicture;

//Save CoreData
- (IBAction)save:(id)sender;

//  Pick an image from album and camera
- (IBAction)imgFromCamera:(id)sender;
- (IBAction)imageFromCamera:(id)sender;

//CoreData Check
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//Passbook Control
- (IBAction)passbookBtn:(id)sender;

- (IBAction)addContact:(id)sender;

@end

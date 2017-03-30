//
//  AddPersonTVC.m
//  Staff Manager
//
//  Created by Tim Roadley on 9/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddPersonTVC.h"

@implementation AddPersonTVC
@synthesize delegate;
//@synthesize personNameTextField;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize personFirstnameTextField;
@synthesize personSurnameTextField;
@synthesize personRoleTVCell;
@synthesize selectedRole;

- (void)viewWillAppear:(BOOL)animated {
    
    personRoleTVCell.textLabel.text = @"";
    personRoleTVCell.delegate = self;
    personRoleTVCell.managedObjectContext = self.managedObjectContext;    
}
- (void)roleWasSelectedOnPicker:(Role *)role {
    
    self.selectedRole = role;
    personRoleTVCell.textLabel.text = self.selectedRole.name;
    NSLog(@"AddPersonTVC has set '%@' as the Selected Role", self.selectedRole.name);
}

- (void)viewDidUnload
{
    //[self setPersonNameTextField:nil];
    [self setPersonFirstnameTextField:nil];
    [self setPersonSurnameTextField:nil];
    [self setPersonRoleTVCell:nil];
    [super viewDidUnload];
}

- (IBAction)save:(id)sender
{
    NSLog(@"Telling the AddPersonTVC Delegate that Save was tapped on the AddPersonTVC");
    
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                               inManagedObjectContext:self.managedObjectContext];
    
    //person.name = personNameTextField.text;
    person.firstname = personFirstnameTextField.text;
    person.surname = personSurnameTextField.text;
    person.inRole = selectedRole;
    
    [self.managedObjectContext save:nil];  // write to database
    
    [self.delegate theSaveButtonOnTheAddPersonTVCWasTapped:self];
}
@end



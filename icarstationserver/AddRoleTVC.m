//
//  AddRoleTVC.m
//  Staff Manager
//
//  Created by Tim Roadley on 9/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddRoleTVC.h"

@implementation AddRoleTVC
@synthesize delegate;
@synthesize roleNameTextField;
@synthesize managedObjectContext = __managedObjectContext;


- (void)viewDidLoad
{
   [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
}

- (void)viewDidUnload
{
    [self setRoleNameTextField:nil];
    [super viewDidUnload];
    
    
}

- (IBAction)save:(id)sender
{
    NSLog(@"Telling the AddRoleTVC Delegate that Save was tapped on the AddRoleTVC");
    
    Role *role = [NSEntityDescription insertNewObjectForEntityForName:@"Role"
                                               inManagedObjectContext:self.managedObjectContext];
    
    role.name = roleNameTextField.text;
    
    [self.managedObjectContext save:nil];  // write to database
    
    [self.delegate theSaveButtonOnTheAddRoleTVCWasTapped:self];
}
@end



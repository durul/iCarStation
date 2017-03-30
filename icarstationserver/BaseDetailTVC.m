//
//  BaseDetailTVC.m
//  icarstationserver
//
//  Created by durul dalkanat on 8/18/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import "BaseDetailTVC.h"
#import "ADVTheme.h"
#import "AppDelegate.h"
#import "SBTextField.h"


@interface BaseDetailTVC ()

@property (strong, nonatomic) IBOutlet SBTextField *roleNameTextField;

@end


@implementation BaseDetailTVC
@synthesize delegate;
@synthesize roleNameTextField;
@synthesize role = _role;


- (void)viewDidLoad
{
    //Textfield karakter kontrol
	roleNameTextField.maxLength = 10;
    
    
    //    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    [ADVThemeManager customizeTableView:self.tableView];
    
    UIImageView *imgTableFooter = [[UIImageView alloc] initWithImage:[[ADVThemeManager sharedTheme] tableFooterBackground]];
    [self.tableView setTableFooterView:imgTableFooter];
    [self.tableView reloadData];
    
    self.roleNameTextField.text = self.role.name;
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tgr setCancelsTouchesInView:NO];
    [self.tableView addGestureRecognizer:tgr];
    
    [super viewDidLoad];
    
    
    
}

- (void)viewDidUnload
{
    [self setRoleNameTextField:nil];
    [super viewDidUnload];
}

- (void)dismissKeyboard {
    [self.view endEditing:TRUE];
}

- (IBAction)save2:(id)sender
{
    // NSLog(@"Telling the AddRoleTVC Delegate that Save was tapped on the AddRoleTVC");
    [self.role setName:roleNameTextField.text];
    [self.role.managedObjectContext save:nil];  // write to database
    [self.delegate theSaveButtonOnTheRoleDetailTVCWasTapped:self];
}
@end

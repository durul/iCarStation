//
//  RoleDetailTVC.m
//  Staff Manager
//
//  Created by Durul Dalkanat on 14/02/12.
//  Copyright (c) 2012 Durul Dalkanat. All rights reserved.
//

#import "RoleDetailTVC.h"
#import "ADVTheme.h"
#import "SBTextField.h"
#import <QuartzCore/QuartzCore.h>
#import "M2DHudView.h"
#import "IQDropDownTextField.h"
#import "UIColor+BFPaperColors.h"

@interface RoleDetailTVC ()
{
    NSInteger _lastSelectedIndex;
    NSMutableArray *objects;

}

@property (strong, nonatomic) IBOutlet IQDropDownTextField *roleNameTextField;
@property (strong, nonatomic) IBOutlet SBTextField *checkoutTextField;
@property (weak, nonatomic) IBOutlet SBTextField *ratingsTextField;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *zoneTextField;

@end

@implementation RoleDetailTVC
@synthesize delegate;
@synthesize roleNameTextField,checkoutTextField,ratingsTextField,zoneTextField;
@synthesize role = _role;
@synthesize CheckOutChooserVisible;


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    objects = [[NSMutableArray alloc]init];
    
    if(self){
        for (int i=1; i<100; i++) {
            NSString *str = [NSString stringWithFormat:@"This is the fabulous Row %d",i];
            [objects addObject:str];
        }
    }
    return self;
}

//This function is where all the magic happens
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //!!!FIX for issue #1 Cell position wrong------------
    if(cell.layer.position.x != 0){
        cell.layer.position = CGPointMake(0, cell.layer.position.y);
    }
    
    //4. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}


//Helper function to get a random float
- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

- (void)viewDidLoad
{
    //Textfield karakter kontrol
	checkoutTextField.maxLength = 10;
	ratingsTextField.maxLength = 10;
    
    //    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [ADVThemeManager customizeTableView:self.tableView];
    
    UIImageView *imgTableFooter = [[UIImageView alloc] initWithImage:[[ADVThemeManager sharedTheme] tableFooterBackground]];
    [self.tableView setTableFooterView:imgTableFooter];
    [self.tableView reloadData];

    self.roleNameTextField.text = self.role.name;
    self.checkoutTextField.text = self.role.checkout;
    self.zoneTextField.text = self.role.zones;
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tgr setCancelsTouchesInView:NO];
    [self.tableView addGestureRecognizer:tgr];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    roleNameTextField.inputAccessoryView = toolbar;
    zoneTextField.inputAccessoryView = toolbar;
    
    [roleNameTextField setItemList:[NSArray arrayWithObjects:@"VW", @"Citroen", @"Mercedes", @"Acura", @"Opel", @"Aston Martin", @"Bentley", @"Buick", @"Nissan", @"RAM", @"Tesla", @"Audi", @"Cadillac", @"Chevrolet", @"Dodge", @"Mazda", @"Pontiac", @"Scion",@"Smart", @"BMW", @"Fiat", @"Ferrari", @"Gmc", @"Maserati", @"Mercury", @"Saab", @"Volvo", @"SRT", @"Honda", @"Ford", @"Hummer", @"Jaguar",@"Mini", @"Mitsubishi", @"Suzuki", @"Saturn", @"Toyota", @"Jeep",@"Kia", @"Lexus", @"Lotus", @"Maybach",@"Subaru", @"Rolls-Royce", @"Range-Rover", @"Lamborghini", @"Bugatti", nil]];
    
    [zoneTextField setItemList:[NSArray arrayWithObjects:@"A",@"A1",@"A2",@"A3",@"A4",@"A5",@"A6",@"A7",
                                @"B",@"B1",@"B2",@"B3",@"B4",@"B5",@"B6",@"B7",
                                @"C",@"C1",@"C2",@"C3",@"C4",@"C5",@"C6",@"C7",
                                @"D",@"D1",@"D2",@"D3",@"D4",@"D5",@"D6",@"D7",
                                @"E",@"E1",@"E2",@"E3",@"E4",@"E5",@"E6",@"E7",
                                @"F",@"F1",@"F2",@"F3",@"F4",@"F5",@"F6",@"F7",
                                @"G",@"G1",@"G2",@"G3",@"G4",@"G5",@"G6",@"G7",
                                @"H",@"H1",@"H2",@"H3",@"H4",@"AH5",@"H6",@"H7",
                                @"I",@"I1",@"I2",@"I3",@"I4",@"I5",@"I6",@"I7",
                                @"J", nil]];
    
    [super viewDidLoad];
}

- (void)dismissKeyboard {
    [self.view endEditing:TRUE];
}

-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
}

//Coredata save button configuration
- (IBAction)save:(id)sender
{
    self.role.name = self.roleNameTextField.text; // Set Surname
    self.role.checkout = self.checkoutTextField.text; // Set Surname
    self.role.rating = [self.ratingsTextField.text intValue];
    self.role.zones = self.zoneTextField.text;
    
    [self.role.managedObjectContext save:nil];  // write to database
    [self.delegate theSaveButtonOnTheRoleDetailTVCWasTapped:self];
    
    //Hudview
    M2DHudView *hud = [[M2DHudView alloc] initWithStyle:M2DHudViewStyleSuccess title:nil];
	[hud showWithDuration:3];
    
}

//Modelname checkout configuration
- (IBAction)checkOut:(id)sender {
    
    if (self.CheckOutChooserVisible != YES) {
        self.CheckOutChooserVisible = YES;
        [self performSegueWithIdentifier:@"CheckOutChooserModal" sender:self];
    }

}

- (void)calculateDateDifferenceCheckOut:(NSDate *)aCheckOuttime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d.MM.yyyy HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate *date = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    self.checkoutTextField.text = dateString;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ((TimerViewController*)segue.destinationViewController).delegate = self;
}

//  Resign the keyboard after Done is pressed when editing text fields
- (IBAction)resignKeyboard:(id)sender
{
    [roleNameTextField resignFirstResponder];
    [zoneTextField resignFirstResponder];
    [checkoutTextField resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:NSLocalizedString(@"Memory Problem", @"Hafıza Problemi")
                                          message:NSLocalizedString(@"Please Close Some Applications!", @"Bazi uygulamalarinizi kapatin")
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end



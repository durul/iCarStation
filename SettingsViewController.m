//
//  SettingsViewController.m
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import "SettingsViewController.h"
#import "ShareFriend.h"
#import <Accounts/Accounts.h>
#import "AppDelegate.h"
#import "MDAboutController.h"
#import "ADVTheme.h"
#import <QuartzCore/QuartzCore.h>

@interface SettingsViewController () {
    NSMutableArray *objects;

}

@end

@implementation SettingsViewController


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

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ADVThemeManager customizeTableView:self.tableView];
    
    UIImageView *imgTableFooter = [[UIImageView alloc] initWithImage:[[ADVThemeManager sharedTheme] tableFooterBackground]];
    [self.tableView setTableFooterView:imgTableFooter];
    [self.tableView reloadData];
    
    //Arkaplan Konfigurasyonu
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"background.png"]];
}

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = NSLocalizedString(@"Tell a Friend", "Arkadaşlarla Paylaş");
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont fontWithName:@"Eurostile-Oblique" size:15.f];
        
    } else if (indexPath.row == 1) {
        cell.textLabel.text = NSLocalizedString(@"Send Gifts", "Hediye Gönder");
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont fontWithName:@"Eurostile-Oblique" size:15.f];
        
    } else if (indexPath.row == 2) {
        cell.textLabel.text = NSLocalizedString(@"Give a Rate", "Oy verin.");
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont fontWithName:@"Eurostile-Oblique" size:15.f];

    } else if (indexPath.row == 3) {
        cell.textLabel.text = NSLocalizedString(@"Twitter", "Twitter");
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont fontWithName:@"Eurostile-Oblique" size:15.f];

    } else if (indexPath.row == 4) {
        cell.textLabel.text = NSLocalizedString(@"Facebook", "Facebook");
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont fontWithName:@"Eurostile-Oblique" size:15.f];

    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if ([[ShareFriend sharedInstance] canTellAFriend]) {
            UINavigationController* tellAFriendController = [[ShareFriend sharedInstance] tellAFriendController];
            [self presentViewController:tellAFriendController animated:YES completion:nil];
        }
    } else if (indexPath.row == 1) {
        [[ShareFriend sharedInstance] giftThisAppWithAlertView:YES];
    } else if (indexPath.row == 2) {
        [[ShareFriend sharedInstance] rateThisAppWithAlertView:YES];
    } else if (indexPath.row == 3) {
        [[ShareFriend sharedInstance] twitWithAlertView:YES];
    } else if (indexPath.row == 4) {
        [[ShareFriend sharedInstance] facebookWithAlertView:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.f;
}


#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self.view becomeFirstResponder];
    [super viewDidAppear:animated];
}

//Hafıza Problemi Yaşanırsa Uyarı Vericek
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

- (IBAction)about:(id)sender {
    
    // If the view controller doesn't already exist, create it
    if (!aboutController) {
        aboutController = [[MDAboutController alloc] initWithStyle:[MDACMochiDevStyle style]];
    }
    
    // Present to user!
    [self presentViewController:aboutController animated:YES completion:NULL];
    
}

@end

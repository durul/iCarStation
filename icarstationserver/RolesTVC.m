//
//  RolesTVC.m
//  Staff Manager
//
//  Created by Durul Dalkanat on 9/02/12.
//  Copyright (c) 2012 Durul Dalkanat. All rights reserved.
//

#import "RolesTVC.h"
#import "Role.h"
#import "ADVTheme.h"
#import "ModelCell.h"
#import <QuartzCore/QuartzCore.h>

@interface RolesTVC ()
{
    NSMutableArray *objects;
    
}

@end

@implementation RolesTVC
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize selectedRole;
@synthesize searchResults;


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

#pragma mark -
#pragma mark Fetched Results Controller section
- (void)setupFetchedResultsController
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"Role"; // Put your entity name here
    //NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    [request setFetchLimit:100];
    // 3 - Filter it if you want
    //request.predicate = [NSPredicate predicateWithFormat:@"Role.name = Blah"];
    
    // 4 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    [self performFetch];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];
}

/**
 *	iCloud
 *
 *	@param	note	Check PersonTVC
 */
- (void)reloadFetchedResults:(NSNotification*)note {
    //NSLog(@"Underlying data changed ... refreshing!");
    [self performFetch];
}
- (void)viewDidLoad
{
    
    [ADVThemeManager customizeTableView:self.tableView];
    
    UIImageView *imgTableFooter = [[UIImageView alloc] initWithImage:[[ADVThemeManager sharedTheme] tableFooterBackground]];
    [self.tableView setTableFooterView:imgTableFooter];
    [self.tableView reloadData];
       
    /*
     * Refresh this view whenever data changes iCloud
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadFetchedResults:)
                                                 name:@"RolesTVCSomethingChanged"
                                               object:[[UIApplication sharedApplication] delegate]];

    
}

- (void)viewDidUnload
{
    
    /**
     *	iCloud
     *
     */
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    /**
     *	Search Function
    */
	self.searchResults = nil;
}

#pragma mark -
#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RolesCell";
    
    ModelCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ModelCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    */
    
    /*
    // Display recipe in the table cell
    //---------- CELL BACKGROUND IMAGE -----------------------------
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.frame];
    UIImage *image = [UIImage imageNamed:@"LightGrey.png"];
    imageView.image = image;
    cell.backgroundView = imageView;
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    [[cell detailTextLabel] setBackgroundColor:[UIColor clearColor]];
    */

    
    // Configure the cell...
    Role *role = [self.fetchedResultsController objectAtIndexPath:indexPath];
     
    cell.nameLbl.text = role.name;
    cell.zoneLbl.text = role.zones;
    cell.checkoutLbl.text = role.checkout;
    cell.ratingImgView.image = [self
                                  imageForRating:role.rating];

    //Set the accessory type.
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    //Configure the cell font
    cell.zoneLbl.font = [UIFont fontWithName:@"eurostile-oblique" size:18.0];
    cell.nameLbl.font = [UIFont fontWithName:@"eurostile-oblique" size:18.0];
    cell.checkoutLbl.font = [UIFont fontWithName:@"eurostile-oblique" size:18.0];
    
    return cell;
}


- (UIImage *)imageForRating:(int)rating
{
	switch (rating)
	{
		case 1: return [UIImage imageNamed:@"1StarSmall.png"];
		case 2: return [UIImage imageNamed:@"2StarsSmall.png"];
		case 3: return [UIImage imageNamed:@"3StarsSmall.png"];
		case 4: return [UIImage imageNamed:@"4StarsSmall.png"];
		case 5: return [UIImage imageNamed:@"5StarsSmall.png"];
	}
	return nil;
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.searchResults count];
    }
	else
	{
        return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.f;
}


#pragma mark -
#pragma mark Table view Methods
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableView beginUpdates]; // Avoid  NSInternalInconsistencyException
        
        // Delete the role object that was swiped
        Role *roleToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        //NSLog(@"Deleting (%@)", roleToDelete.name);
        [self.managedObjectContext deleteObject:roleToDelete];
        [self.managedObjectContext save:nil];
        
        // Delete the (now empty) row on the table
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self performFetch];
        
        [self.tableView endUpdates];
        
        
        NSError *error = nil;
        if (![[self fetchedResultsController] performFetch:&error]) {
            NSLog(@"Error! %@",error);
            abort();
        }
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"Add Role Segue"])
	{
        // NSLog(@"Setting RolesTVC as a delegate of RoleDetailTVC");
        RoleDetailTVC *roleDetailTVC = segue.destinationViewController;
        roleDetailTVC.delegate = self;
        
        // NSLog(@"Creating a new role and passing it to RoleDetailTVC");
        Role *newRole = [NSEntityDescription insertNewObjectForEntityForName:@"Role"
                                                      inManagedObjectContext:self.managedObjectContext];
        
        roleDetailTVC.role = newRole;
        // Hide bottom tab bar in the detail view
        roleDetailTVC.hidesBottomBarWhenPushed = YES;
	}
    else if ([segue.identifier isEqualToString:@"Role Detail Segue"])
    {
        // NSLog(@"Setting RolesTVC as a delegate of RoleDetailTVC");
        RoleDetailTVC *roleDetailTVC = segue.destinationViewController;
        roleDetailTVC.delegate = self;
        
        // Store selected Role in selectedRole property
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.selectedRole = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        // NSLog(@"Passing selected role (%@) to RoleDetailTVC", self.selectedRole.name);
        roleDetailTVC.role = self.selectedRole;
        // Hide bottom tab bar in the detail view
        roleDetailTVC.hidesBottomBarWhenPushed = YES;
    }
    else {
       // NSLog(@"Unidentified Segue Attempted!");
    }
}

- (void)theSaveButtonOnTheRoleDetailTVCWasTapped:(RoleDetailTVC *)controller
{
    // do something here like refreshing the table or whatever
    
    // close the delegated view
    [controller.navigationController popViewControllerAnimated:YES];    
}

// Override to support conditional rearranging of the table view.
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath: (NSIndexPath *) indexPath {
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath: (NSIndexPath *) indexPath {
    return YES;
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

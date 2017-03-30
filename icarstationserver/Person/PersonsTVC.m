//
//  PersonsTVC.m
//  Staff Manager
//
//  Created by Durul Dalkanat on 9/02/12.
//  Copyright (c) 2012 Durul Dalkanat. All rights reserved.
//

#import "PersonsTVC.h"
#import "Person.h"
#import "ADVTheme.h"
#import "PersonDetailTVC.h"
#import <QuartzCore/QuartzCore.h>

@interface PersonsTVC ()
{
    NSMutableArray *objects;

}

@end

@implementation PersonsTVC
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize selectedPerson;
@synthesize searchResults;
@synthesize pictureListData;
@synthesize delegate;

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
    
    [ADVThemeManager customizeTableView:self.tableView];
    
    UIImageView *imgTableFooter = [[UIImageView alloc] initWithImage:[[ADVThemeManager sharedTheme] tableFooterBackground]];
    [self.tableView setTableFooterView:imgTableFooter];
    [self.tableView reloadData];

    /**
     *	Search Function
     */
    
    self.searchResults = [NSMutableArray arrayWithCapacity:[[self.fetchedResultsController fetchedObjects] count]];
    [self.tableView reloadData];
    
    /*
     * Refresh this view whenever data changes iCloud
     */
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadFetchedResults:)
                                                 name:@"PersonTVCSomethingChanged"
                                               object:[[UIApplication sharedApplication] delegate]];
}

- (void)setupFetchedResultsController
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"Person"; // Put your entity name here
    //NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    [request setFetchLimit:100];
    
    // 3 - Filter it if you want
    //request.predicate = [NSPredicate predicateWithFormat:@"Person.name = Blah"];
    
    // 4 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"firstname"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    [self performFetch];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

#pragma mark -
#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Persons Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Get the core data object we need to use to populate this table cell
    
    // Configure the cell...
    Person *person = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *fullname = [NSString stringWithFormat:@"%@", person.surname];
    NSString *licenseplate = [NSString stringWithFormat:@"%@", person.firstname];

    cell.textLabel.text = fullname;
    cell.detailTextLabel.text = licenseplate;
    cell.imageView.image = person.smallPicture;
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //Configure the cell font
    cell.textLabel.font = [UIFont fontWithName:@"eurostile-oblique" size:18.0];
   
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableView beginUpdates]; // Avoid  NSInternalInconsistencyException
        
        // Delete the person object that was swiped
        Person *personToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:personToDelete];
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

 // Override to support conditional rearranging of the table view.
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath: (NSIndexPath *) indexPath {
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath: (NSIndexPath *) indexPath {
    return YES;
}

#pragma mark - Segue methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"Add Person Segue"])
	{
        //NSLog(@"Setting PersonsTVC as a delegate of PersonDetailTVC");
        PersonDetailTVC *personDetailTVC = segue.destinationViewController;
        personDetailTVC.delegate = self;
        
        //NSLog(@"Creating a new person and passing it to PersonDetailTVC");
        Person *newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person"
                                                          inManagedObjectContext:self.managedObjectContext];
        
        personDetailTVC.person = newPerson;
        
        // Hide bottom tab bar in the detail view
        personDetailTVC.hidesBottomBarWhenPushed = YES;
    }
    else if ([segue.identifier isEqualToString:@"Person Detail Segue"])
    {
        //NSLog(@"Setting PersonsTVC as a delegate of PersonDetailTVC");
        PersonDetailTVC *personDetailTVC = segue.destinationViewController;
        personDetailTVC.delegate = self;
        personDetailTVC.currentPicture = selectedPerson;
        
        // Store selected Person in selectedPerson property
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        self.selectedPerson = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        //NSLog(@"Passing selected person (%@) to PersonDetailTVC", self.selectedPerson.firstname);
        personDetailTVC.person = self.selectedPerson;
        
        //  Pass the picture object from the table that we want to view
        // Hide bottom tab bar in the detail view
        personDetailTVC.hidesBottomBarWhenPushed = YES;

    }
    else {
        //NSLog(@"Unidentified Segue Attempted!");
    }
}

- (void)theSaveButtonOnThePersonDetailTVCWasTapped:(PersonDetailTVC *)controller
{
    // do something here like refreshing the table or whatever
    
    // close the delegated view
    [controller.navigationController popViewControllerAnimated:YES];    
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	//NSLog(@"Previous Search Results were removed.");
	[self.searchResults removeAllObjects];
    
	for (Person *person in [self.fetchedResultsController fetchedObjects])
	{
		if ([scope isEqualToString:@"All"] || [person.firstname isEqualToString:scope])
		{
			NSComparisonResult result = [person.firstname compare:searchText
                                                   options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)
                                                     range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
			{
              //  NSLog(@"Adding role.name '%@' to searchResults as it begins with search text '%@'", person.firstname, searchText);
				[self.searchResults addObject:person];
            }
		}
	}
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:@"All"];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:@"All"];
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark Memory Managemenet
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

@end

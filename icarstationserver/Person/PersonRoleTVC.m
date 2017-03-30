//
//  PersonRoleTVC.m
//  Staff Manager
//
//  Created by Durul Dalkanat on 19/02/12.
//  Copyright (c) 2012 Durul Dalkanat. All rights reserved.
//

#import "PersonRoleTVC.h"
#import "ADVTheme.h"

@implementation PersonRoleTVC
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize delegate;
@synthesize selectedPerson;
@synthesize selectedRole;


- (void)viewDidLoad
{
    //    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    //View Controller theme
    [ADVThemeManager customizeTableView:self.tableView];
    UIImageView *imgTableFooter = [[UIImageView alloc] initWithImage:[[ADVThemeManager sharedTheme] tableFooterBackground]];
    [self.tableView setTableFooterView:imgTableFooter];
    [self.tableView reloadData];
    
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
	//request.predicate = [NSPredicate predicateWithFormat:@"Person.name = Blah"];
    
	// 4 - Sort it if you want
	request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name"
																					 ascending:YES
																					  selector:@selector(localizedCaseInsensitiveCompare:)]];
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request 
                                                                        managedObjectContext:self.selectedPerson.managedObjectContext sectionNameKeyPath:nil 
                                                                                   cacheName:nil];

	[self performFetch];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self setupFetchedResultsController];
}

#pragma mark -
#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	self.selectedRole = [self.fetchedResultsController objectAtIndexPath:indexPath];
	// NSLog(@"The PersonRoleTVC reports that the %@ role was selected", self.selectedRole.name);
	[self.delegate roleWasSelectedOnPersonRoleTVC:self];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Person Role Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
    
	// Configure the cell...
	Role *role = [self.fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = role.name;
    cell.detailTextLabel.text = role.checkout;
    //Configure the cell font
    cell.textLabel.font = [UIFont fontWithName:@"eurostile-oblique" size:18.0];
    
	return cell;
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

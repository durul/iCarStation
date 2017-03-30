//
//  BasePickerTVCell.m
//  icarstationserver
//
//  Created by durul dalkanat on 8/18/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import "BasePickerTVCell.h"
#import "AppDelegate.h"


@implementation BasePickerTVCell
@synthesize selectedBase= _selectedBase;
@synthesize delegate;


- (void)setupFetchedResultsController
{
    // 0 - Ensure you have a MOC
    if (!self.selectedBase.managedObjectContext) {
       // NSLog(@"RolePickerTVCell wasn't given a Managed Object Context ... This should NOT happen!");
    }
    
	// 1 - Decide what Entity you want
	NSString *entityName = @"Base"; // Put your entity name here
	//NSLog(@"RolePickerTVCell is Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
	// 2 - Request that Entity
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
	// 3 - Filter it if you want
	//request.predicate = [NSPredicate predicateWithFormat:@"Person.name = Blah"];
    
	// 4 - Sort it if you want
	request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name"
																					 ascending:YES
																					  selector:@selector(localizedCaseInsensitiveCompare:)]];
	// 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.selectedBase.managedObjectContext
                                                                          sectionNameKeyPath:nil cacheName:nil];
    
	[self.fetchedResultsController performFetch:nil];
    
    //NSLog(@"The following roles were fetched for the Picker by RolePickerTVCell:");
    for (Base *fetchedRole in [self.fetchedResultsController fetchedObjects]) {
      //  NSLog(@"Base: %@", fetchedRole.name);
    }
}

- (void)initalizeInputView {
    
    // Prepare the Data for the Picker
    [self setupFetchedResultsController];
    
	self.picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
	self.picker.showsSelectionIndicator = YES;
	self.picker.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		UIViewController *popoverContent = [[UIViewController alloc] init];
		popoverContent.view = self.picker;
		popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
		popoverController.delegate = self;
	}
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
		[self initalizeInputView];
        
        self.picker.delegate = self;
		self.picker.dataSource = self;
    }
    return self;
}

- (void)done:(id)sender {
    
    //NSLog(@"Passing back the selected '%@' Role to the delegate", self.selectedRole.name);
    [self.delegate roleWasSelectedOnPicker:self.selectedBase];
    [self resignFirstResponder];
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [[self.fetchedResultsController fetchedObjects] count];
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
    // Display the Roles we've fetched on the picker
    Base *base = [[self.fetchedResultsController fetchedObjects] objectAtIndex:row];
    return base.name;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    // Configure the row height
	return 44.0f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    // Configure the width of the picker wheel thing
	return 300.0f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
    Base *base = [[self.fetchedResultsController fetchedObjects] objectAtIndex:row];
    self.selectedBase = base;
    //NSLog(@"The '%@' Role was selected using the picker", self.selectedRole.name);
}

@end

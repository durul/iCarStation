//
//  CoreDataTableViewCell.h
//  icarstationserver
//
//  Created by duruldalkanat on 19/05/14.
//  Copyright (c) 2014 durul dalkanat. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreDataTableViewCell : UITableViewCell <NSFetchedResultsControllerDelegate, UIKeyInput, UIPopoverControllerDelegate> {

	UIPopoverController *popoverController;
	UIToolbar *inputAccessoryView;
}

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) BOOL suspendAutomaticTrackingOfChangesInManagedObjectContext;
@property (nonatomic, strong) UIPickerView *picker;

@end
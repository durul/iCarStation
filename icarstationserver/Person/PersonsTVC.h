//
//  PersonsTVC.h
//  Staff Manager
//
//  Created by Durul Dalkanat on 9/02/12.
//  Copyright (c) 2012 Durul Dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonDetailTVC.h" // so this class can be an PersonDetailTVCDelegate
#import "CoreDataTableViewController.h" // so we can fetch
#import "Person.h"
#import "PersonsTVCDelegate.h"

@interface PersonsTVC : CoreDataTableViewController <PersonDetailTVCDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

@property (nonatomic, weak) id <PersonsTVCDelegate> delegate;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Person *selectedPerson;
@property (nonatomic, retain) NSMutableArray *searchResults;

//Remember Image
@property (strong, nonatomic) NSMutableArray *pictureListData;

@end





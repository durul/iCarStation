//
//  RolesTVC.h
//  Staff Manager
//
//  Created by Durul Dalkanat on 9/02/12.
//  Copyright (c) 2012 Durul Dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoleDetailTVC.h" // so this class can be an RoleDetailTVCDelegate
#import "CoreDataTableViewController.h" // so we can fetch
#import "Role.h"

@interface RolesTVC : CoreDataTableViewController <RoleDetailTVCDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Role *selectedRole;
@property (nonatomic, retain) NSMutableArray *searchResults;

@end





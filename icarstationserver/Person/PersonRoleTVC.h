//
//  PersonRoleTVC.h
//  Staff Manager
//
//  Created by Durul Dalkanat on 19/02/12.
//  Copyright (c) 2012 Durul Dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "Role.h"
#import "CoreDataTableViewController.h" // so we can fetch

@class PersonRoleTVC;
@protocol PersonRoleTVCDelegate
- (void)roleWasSelectedOnPersonRoleTVC:(PersonRoleTVC *)controller;
@end

@interface PersonRoleTVC : CoreDataTableViewController
@property (nonatomic, weak) id  delegate;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) Person *selectedPerson;
@property (strong, nonatomic) Role *selectedRole;

@end

//
//  Person.h
//  icarstationserver
//
//  Created by duruldalkanat on 19/05/14.
//  Copyright (c) 2014 durul dalkanat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Role;

@interface Person : NSManagedObject

//photo
@property (nonatomic, strong) UIImage * smallPicture;

//car details
@property (nonatomic, strong) NSString * firstname;
@property (nonatomic, strong) NSString * surname;
@property (nonatomic, strong) Role *inRole;
@property (nonatomic, strong) NSString * blocks;

@end

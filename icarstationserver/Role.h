//
//  Role.h
//  icarstationserver
//
//  Created by duruldalkanat on 19/05/14.
//  Copyright (c) 2014 durul dalkanat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Role : NSManagedObject
@property (nonatomic, strong) NSString * zones;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * checkout;
@property (nonatomic, assign) NSUInteger rating;

@property (nonatomic, retain) NSSet *heldBy;
@end

@interface Role (CoreDataGeneratedAccessors)

- (void)addHeldByObject:(Person *)value;
- (void)removeHeldByObject:(Person *)value;
- (void)addHeldBy:(NSSet *)values;
- (void)removeHeldBy:(NSSet *)values;

@end

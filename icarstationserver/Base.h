//
//  Base.h
//  icarstationserver
//
//  Created by durul dalkanat on 8/18/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


@class Person;

@interface Base : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *heldBy2;
@end

@interface Base (CoreDataGeneratedAccessors)

- (void)addHeldByObject:(Person *)value;
- (void)removeHeldByObject:(Person *)value;
- (void)addHeldBy:(NSSet *)values;
- (void)removeHeldBy:(NSSet *)values;

@end

//
//  Person.m
//  icarstationserver
//
//  Created by duruldalkanat on 19/05/14.
//  Copyright (c) 2014 durul dalkanat. All rights reserved.
//

#import "Person.h"
#import "Role.h"
#import "APLImageToDataTransformer.h"

@implementation Person

@dynamic firstname;
@dynamic surname;
@dynamic inRole;
@dynamic smallPicture;
@dynamic blocks;


+ (void)initialize {
	if (self == [Person class]) {
		APLImageToDataTransformer *transformer = [[APLImageToDataTransformer alloc] init];
		[NSValueTransformer setValueTransformer:transformer forName:@"APLImageToDataTransformer"];
	}
}

@end

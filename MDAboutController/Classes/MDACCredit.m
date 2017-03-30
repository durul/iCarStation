//
//  MDACCredit.m
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import "MDACCredit.h"

@implementation MDACCredit

- (id)initWithType:(NSString *)aType
{
    if ((self = [super init])) {
        self.type = aType;
    }
    return self;
}

- (id)init
{
    return [self initWithType:nil];
}

+ (id)creditWithType:(NSString *)aType
{
    return [[self alloc] initWithType:aType];
}

+ (id)credit
{
    return [self creditWithType:nil];
}


@end
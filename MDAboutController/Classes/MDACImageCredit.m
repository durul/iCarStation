//
//  MDACImageCredit.m
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import "MDACImageCredit.h"

@implementation MDACImageCredit

@synthesize image;

- (id)initWithImage:(UIImage *)anImage
{
    if ((self = [super initWithType:@"Image"])) {
        self.image = anImage;
    }
    return self;
}

- (id)initWithType:(NSString *)aType
{
    return [self initWithImage:nil];
}

+ (id)creditWithType:(NSString *)aType
{
    return [self imageCreditWithImage:nil];
}

+ (id)imageCreditWithImage:(UIImage *)anImage
{
    return [[self alloc] initWithImage:anImage];
}

- (id)initWithDictionary:(NSDictionary *)aDict
{
    if (self = [self initWithImage:[UIImage imageNamed:[aDict objectForKey:@"Image"]]]) {
        self.identifier = [aDict objectForKey:@"Identifier"];
        NSMutableDictionary *newDict = [aDict mutableCopy];
        [newDict removeObjectsForKeys:[NSArray arrayWithObjects:@"Image", @"Identifier", nil]];
        self.userAssociations = newDict;
    }
    
    return self;
}

+ (id)imageCreditWithDictionary:(NSDictionary *)aDict
{
    return [[self alloc] initWithDictionary:aDict];
}


@end
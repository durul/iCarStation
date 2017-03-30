//
//  MDACCreditItem.m
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import "MDACCreditItem.h"

@implementation MDACCreditItem

- (id)initWithName:(NSString *)aName role:(NSString *)aRole linkURL:(NSURL *)anURL
{
    if ((self = [super init])) {
        self.name = aName;
        self.role = aRole;
        self.link = anURL;
    }
    return self;
}

- (id)initWithName:(NSString *)aName role:(NSString *)aRole linkString:(NSString *)aLink
{
    return [self initWithName:aName role:aRole linkURL:[NSURL URLWithString:aLink]];
}

- (id)initWithName:(NSString *)aName role:(NSString *)aRole viewController:(NSString *)aViewController
{
    if ((self = [self initWithName:aName role:aRole linkURL:nil])) {
        self.viewController = aViewController;
    }
    return self;
}

- (id)init
{
    return [self initWithName:nil role:nil linkURL:nil];
}

+ (id)itemWithName:(NSString *)aName role:(NSString *)aRole linkURL:(NSURL *)anURL
{
    return [[self alloc] initWithName:aName role:aRole linkURL:anURL];
}

+ (id)itemWithName:(NSString *)aName role:(NSString *)aRole linkString:(NSString *)aLink
{
    return [[self alloc] initWithName:aName role:aRole linkURL:[NSURL URLWithString:aLink]];
}

+ (id)itemWithName:(NSString *)aName role:(NSString *)aRole viewController:(NSString *)aViewController
{
    return [[self alloc] initWithName:aName role:aRole viewController:aViewController];
}

+ (id)item
{
    return [self itemWithName:nil role:nil linkURL:nil];
}

- (id)initWithDictionary:(NSDictionary *)aDict
{
    if ([aDict objectForKey:@"Controller"]) {
        self = [self initWithName:[aDict objectForKey:@"Name"]
                             role:[aDict objectForKey:@"Role"]
                   viewController:[aDict objectForKey:@"Controller"]];
    } else {
        NSString *linkString = [aDict objectForKey:@"Link"];
        if (!linkString && [aDict objectForKey:@"Email"]) {
            linkString = [NSString stringWithFormat:@"mailto:%@", [aDict objectForKey:@"Email"]];
        }
        
        self = [self initWithName:[aDict objectForKey:@"Name"]
                             role:[aDict objectForKey:@"Role"]
                       linkString:linkString];
    }
    
    if (self) {
        self.identifier = [aDict objectForKey:@"Identifier"];
        NSMutableDictionary *newDict = [aDict mutableCopy];
        [newDict removeObjectsForKeys:[NSArray arrayWithObjects:@"Link", @"Email", @"Name", @"Role", @"Controller", @"Identifier", nil]];
        self.userAssociations = newDict;
    }
    
    return self;
}

+ (id)itemWithDictionary:(NSDictionary *)aDict
{
    return [[self alloc] initWithDictionary:aDict];
}


@end
//
//  MDACListCredit.m
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import "MDACListCredit.h"
#import "MDACCreditItem.h"

@implementation MDACListCredit

@synthesize items;

- (id)initWithTitle:(NSString *)aTitle
{
    if ((self = [super initWithType:@"List"])) {
        self.title = aTitle;
        items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithType:(NSString *)aType
{
    return [self initWithTitle:nil];
}

+ (id)creditWithType:(NSString *)aType
{
    return [self listCreditWithTitle:nil];
}

+ (id)listCreditWithTitle:(NSString *)aTitle
{
    return [[self alloc] initWithTitle:aTitle];
}

- (id)initWithDictionary:(NSDictionary *)aDict
{
    if ((self = [self initWithTitle:[aDict objectForKey:@"Title"]])) {
        self.identifier = [aDict objectForKey:@"Identifier"];
        NSMutableDictionary *newDict = [aDict mutableCopy];
        [newDict removeObjectsForKeys:[NSArray arrayWithObjects:@"Title", @"Identifier", @"Items", nil]];
        self.userAssociations = newDict;
        
        NSArray *itemsList = [aDict objectForKey:@"Items"];
        for (NSDictionary *item in itemsList) {
            [self addItem:[MDACCreditItem itemWithDictionary:item]];
        }
    }
    return self;
}

+ (id)listCreditWithDictionary:(NSDictionary *)aDict
{
    return [[self alloc] initWithDictionary:aDict];
}

- (NSUInteger)count
{
    return [items count];
}

- (void)addItem:(MDACCreditItem *)anItem
{
    [items addObject:anItem];
}

- (void)removeItem:(MDACCreditItem *)anItem
{
    [items removeObject:anItem];
}

- (MDACCreditItem *)itemAtIndex:(NSUInteger)index
{
    return [items objectAtIndex:index];
}


@end
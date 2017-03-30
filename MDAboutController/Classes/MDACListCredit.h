//
//  MDACListCredit.h
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MDACCredit.h"
@class MDACCreditItem;

@interface MDACListCredit : MDACCredit {
    NSMutableArray *items;
}

@property(nonatomic, copy) NSString *title;
@property(nonatomic, readonly) NSUInteger count;
@property(nonatomic, readonly) NSArray *items;

- (id)initWithTitle:(NSString *)aTitle;
+ (id)listCreditWithTitle:(NSString *)aTitle;
- (id)initWithDictionary:(NSDictionary *)aDict;
+ (id)listCreditWithDictionary:(NSDictionary *)aDict;

- (void)addItem:(MDACCreditItem *)anItem;
- (void)removeItem:(MDACCreditItem *)anItem;
- (MDACCreditItem *)itemAtIndex:(NSUInteger)index;

@end
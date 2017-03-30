//
//  MDACCreditItem.h
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MDACCreditItem : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *role;
@property(nonatomic, copy) NSDictionary *userAssociations;
@property(nonatomic, strong) NSURL *link;
@property(nonatomic, copy) NSString *viewController;
@property(nonatomic, copy) NSString *identifier;

- (id)initWithName:(NSString *)aName role:(NSString *)aRole linkURL:(NSURL *)anURL; // designated initializer
- (id)initWithName:(NSString *)aName role:(NSString *)aRole linkString:(NSString *)aLink;
- (id)initWithName:(NSString *)aName role:(NSString *)aRole viewController:(NSString *)aViewController;
+ (id)itemWithName:(NSString *)aName role:(NSString *)aRole linkURL:(NSURL *)anURL;
+ (id)itemWithName:(NSString *)aName role:(NSString *)aRole linkString:(NSString *)aLink;
+ (id)itemWithName:(NSString *)aName role:(NSString *)aRole viewController:(NSString *)aViewController;
+ (id)item;
- (id)initWithDictionary:(NSDictionary *)aDict; // internal
+ (id)itemWithDictionary:(NSDictionary *)aDict; // internal

@end

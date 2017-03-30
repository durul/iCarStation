//
//  MDACTextCredit.h
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MDACCredit.h"

@interface MDACTextCredit : MDACCredit

@property(nonatomic, copy) NSString *text;
@property(nonatomic, strong) UIFont *font;
@property(nonatomic) NSTextAlignment textAlignment;
@property(nonatomic, strong) NSURL *link;

- (id)initWithText:(NSString *)aTitle font:(UIFont *)aFont alignment:(NSTextAlignment)textAlign linkURL:(NSURL *)anURL;
- (id)initWithText:(NSString *)aTitle font:(UIFont *)aFont alignment:(NSTextAlignment)textAlign viewController:(NSString *)aViewController;
+ (id)textCreditWithText:(NSString *)aTitle font:(UIFont *)aFont alignment:(NSTextAlignment)textAlign linkURL:(NSURL *)anURL;
+ (id)textCreditWithText:(NSString *)aTitle font:(UIFont *)aFont alignment:(NSTextAlignment)textAlign viewController:(NSString *)aViewController;
- (id)initWithDictionary:(NSDictionary *)aDict; // internal
+ (id)textCreditWithDictionary:(NSDictionary *)aDict; // internal

@end
//
//  MDACTextCredit.m
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import "MDACTextCredit.h"

@implementation MDACTextCredit

@synthesize text, font, link, textAlignment;

- (id)initWithText:(NSString *)aTitle font:(UIFont *)aFont alignment:(NSTextAlignment)textAlign linkURL:(NSURL *)anURL
{
    if ((self = [super initWithType:@"Text"])) {
        self.text = aTitle;
        if (!aFont) {
            aFont = [UIFont boldSystemFontOfSize:12];
        }
        self.font = aFont;
        self.textAlignment = textAlign;
        self.link = anURL;
    }
    return self;
}

- (id)initWithText:(NSString *)aTitle font:(UIFont *)aFont alignment:(NSTextAlignment)textAlign viewController:(NSString *)aViewController
{
    if ((self = [self initWithText:aTitle font:aFont alignment:textAlign linkURL:nil])) {
        self.viewController = aViewController;
    }
    return self;
}

- (id)initWithType:(NSString *)aType
{
    return [self initWithText:nil font:nil alignment:NSTextAlignmentCenter linkURL:nil];
}

+ (id)creditWithType:(NSString *)aType
{
    return [self textCreditWithText:nil font:nil alignment:NSTextAlignmentCenter linkURL:nil];
}

+ (id)textCreditWithText:(NSString *)aTitle font:(UIFont *)aFont alignment:(NSTextAlignment)textAlign linkURL:(NSURL *)anURL
{
    return [[self alloc] initWithText:aTitle font:aFont alignment:textAlign linkURL:anURL];
}

+ (id)textCreditWithText:(NSString *)aTitle font:(UIFont *)aFont alignment:(NSTextAlignment)textAlign viewController:(NSString *)aViewController
{
    return [[self alloc] initWithText:aTitle font:aFont alignment:textAlign viewController:aViewController];
}

- (id)initWithDictionary:(NSDictionary *)aDict
{
    CGFloat fontSize = 12;
    if ([aDict objectForKey:@"Size"])
        fontSize = [[aDict objectForKey:@"Size"] floatValue];
    
    NSTextAlignment alignment = NSTextAlignmentCenter;
    
    if ([[aDict objectForKey:@"Alignment"] isEqualToString:@"Left"]) {
        alignment = NSTextAlignmentLeft;
    } else if ([[aDict objectForKey:@"Alignment"] isEqualToString:@"Right"]) {
        alignment = NSTextAlignmentRight;
    }
    
    if ([aDict objectForKey:@"Controller"]) {
        self = [self initWithText:[aDict objectForKey:@"Text"]
                             font:[UIFont boldSystemFontOfSize:fontSize]
                        alignment:alignment
                   viewController:[aDict objectForKey:@"Controller"]];
    } else {
        NSString *linkString = [aDict objectForKey:@"Link"];
        if (!linkString && [aDict objectForKey:@"Email"]) {
            linkString = [NSString stringWithFormat:@"mailto:%@", [aDict objectForKey:@"Email"]];
        }
        
        self = [self initWithText:[aDict objectForKey:@"Text"]
                             font:[UIFont boldSystemFontOfSize:fontSize]
                        alignment:alignment
                          linkURL:[NSURL URLWithString:linkString]];
    }
    
    if (self) {
        self.identifier = [aDict objectForKey:@"Identifier"];
        NSMutableDictionary *newDict = [aDict mutableCopy];
        [newDict removeObjectsForKeys:[NSArray arrayWithObjects:@"Link", @"Email", @"Text", @"Size", @"Alignment", @"Controller", @"Identifier", nil]];
        self.userAssociations = newDict;
    }
    
    return self;
}

+ (id)textCreditWithDictionary:(NSDictionary *)aDict
{
    return [[self alloc] initWithDictionary:aDict];
}


@end
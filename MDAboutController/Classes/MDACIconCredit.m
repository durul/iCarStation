//
//  MDACIconCredit.m
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import "MDACIconCredit.h"

@implementation MDACIconCredit

@synthesize appName, versionString, icon;

- (id)initWithAppName:(NSString *)aName versionString:(NSString *)aVersionString icon:(UIImage *)anImage
{
    if ((self = [super initWithType:@"Icon"])) {
        self.appName = aName;
        self.versionString = aVersionString;
        self.icon = anImage;
    }
    return self;
}

- (id)initWithType:(NSString *)aType
{
    return [self initWithAppName:nil versionString:nil icon:nil];
}

+ (id)creditWithType:(NSString *)aType
{
    return [self iconCreditWithAppName:nil versionString:nil icon:nil];
}

+ (id)iconCreditWithAppName:(NSString *)aName versionString:(NSString *)aVersionString icon:(UIImage *)anImage;
{
    return [[self alloc] initWithAppName:aName versionString:aVersionString icon:anImage];
}


@end
//
//  MDACIconCredit.h
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MDACCredit.h"

@interface MDACIconCredit : MDACCredit {
    NSString *appName;
    NSString *versionString;
    UIImage *icon;
}

@property(nonatomic, copy) NSString *appName;
@property(nonatomic, copy) NSString *versionString;
@property(nonatomic, strong) UIImage *icon;
- (id)initWithAppName:(NSString *)aName versionString:(NSString *)aVersionString icon:(UIImage *)anImage;
+ (id)iconCreditWithAppName:(NSString *)aName versionString:(NSString *)aVersionString icon:(UIImage *)anImage;

@end
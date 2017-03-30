//
//  MDACImageCredit.h
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MDACCredit.h"

@interface MDACImageCredit : MDACCredit {
    UIImage *image;
}

@property(nonatomic, strong) UIImage *image;
- (id)initWithImage:(UIImage *)anImage;
+ (id)imageCreditWithImage:(UIImage *)anImage;
- (id)initWithDictionary:(NSDictionary *)aDict;
+ (id)imageCreditWithDictionary:(NSDictionary *)aDict;

@end
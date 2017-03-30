//
//  MDACCredit.h
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MDACCredit : NSObject

@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *viewController;
@property(nonatomic, copy) NSString *identifier;
@property(nonatomic, copy) NSDictionary *userAssociations;

- (id)initWithType:(NSString *)aType;
+ (id)credit;
+ (id)creditWithType:(NSString *)aType;

@end
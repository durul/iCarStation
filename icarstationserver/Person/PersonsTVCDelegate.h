//
//  PersonsTVCDelegate.h
//  Staff Manager
//
//  Created by Durul Dalkanat on 20/03/12.
//  Copyright (c) 2012 Durul Dalkanat. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PersonsTVC;
@protocol PersonsTVCDelegate <NSObject>
- (void)personChangedOnMaster:(PersonsTVC *)controller;
@end

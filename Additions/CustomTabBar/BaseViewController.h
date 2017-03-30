//
//  BaseViewController.h
//  RaisedCenterTabBar
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//
#import "MYBlurIntroductionView.h"
#import <PassSlot/PassSlot.h>
#import <CoreData/CoreData.h>

@interface BaseViewController : UITabBarController <MYIntroductionDelegate>

// Create a view controller and setup it's tab bar item with a title and image
-(UIViewController*) viewControllerWithTabTitle:(NSString*)title image:(UIImage*)image;

// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithOptions:(NSDictionary *)options;

@end

//
//  DBPrivateHelperController.h
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#define IS_IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? 1 : 0)

@import UIKit;

/**
 *  Dismiss completion block
 */
typedef void (^DBPrivateHelperCompletionBlock)();

/**
 *  Privacy Types
 */
typedef NS_ENUM(NSUInteger, DBPrivacyType){
    /**
     *  Photos within camera roll
     */
    DBPrivacyTypePhoto,
    /**
     *  Use the Camera
     */
    DBPrivacyTypeCamera,
    /**
     *  Location Services
     */
    DBPrivacyTypeLocation,
    /**
     *  HealthKit
     */
    DBPrivacyTypeHealth,
    /**
     *  HomeKit
     */
    DBPrivacyTypeHomeKit,
    /**
     *  Motion Activity
     */
    DBPrivacyTypeMotionActivity
};

@interface DBPrivateHelperController : UIViewController

/**
 *  Set the status bar style
 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

/**
 *  Set if the controller can rotate
 */
@property (nonatomic, assign) BOOL canRotate;

/**
 *  The close button
 */
@property (nonatomic, readonly) UIButton *closeButton;

/**
 *  The snapshot of the window
 */
@property (nonatomic, strong) UIImage *snapshot;

/**
 *  The dismiss completion block
 */
@property (nonatomic, copy) DBPrivateHelperCompletionBlock didDismissViewController;

/**
 *  Create an instance of DBPrivateHelperController
 *
 *  @param type The privacy type
 *
 *  @return An instance of DBPrivateHelperController
 */
+ (instancetype) helperForType:(DBPrivacyType)type;
@end
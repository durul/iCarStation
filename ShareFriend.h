//
//  ShareFriend.h
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <StoreKit/StoreKit.h>

#ifdef DEBUG
// First, check if we can use Cocoalumberjack for logging
#ifdef LOG_VERBOSE
extern int ddLogLevel;
#define ITELLLog(...)  DDLogVerbose(__VA_ARGS__)
#else
#define ITELLLog(...) NSLog(@"%s(%p) %@", __PRETTY_FUNCTION__, self, [NSString stringWithFormat:__VA_ARGS__])
#endif
#else
#define ITELLLog(...) ((void)0)
#endif

@interface ShareFriend : NSObject <MFMailComposeViewControllerDelegate, SKStoreProductViewControllerDelegate, UIAlertViewDelegate> {
    NSString *appStoreCountry;
    NSString *applicationName;
    NSString *applicationVersion;
    NSString *applicationGenreName;
    NSString *applicationSellerName;
    NSString *appStoreIconImage;
    
    NSString *applicationKey;
    NSString *messageTitle;
    NSString *message;
    NSUInteger appStoreID;
    NSURL *appStoreURL;
}

//application details - these are set automatically
@property (nonatomic, copy) NSString *appStoreCountry;
@property (nonatomic, copy) NSString *applicationName;
@property (nonatomic, copy) NSString *applicationVersion;
@property (nonatomic, copy) NSString *applicationGenreName;
@property (nonatomic, copy) NSString *applicationSellerName;
@property (nonatomic, copy) NSString *applicationBundleID;
@property (nonatomic, copy) NSString *appStoreIconImage;

@property (nonatomic, copy) NSString *applicationKey;
@property (nonatomic, copy) NSString *messageTitle;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) NSUInteger appStoreID;
@property (nonatomic, copy) NSURL *appStoreURL;
- (NSString *)messageBody;
- (void)promptIfNetworkAvailable;

/**
 * Returns the shared iTellAFriend singleton
 * @return The shared iTellAFriend singleton
 */
+ (ShareFriend *)sharedInstance;

/**
 * Returns if the app can display the tell a friend email composer
 * @return YES if the app can display the tell a friend email composer
 */
- (BOOL)canTellAFriend;

/**
 * Returns a mail composer navigation view controller with a tell a friend email template
 * @return mail composer view controller with a tell a friend email template
 */
- (UINavigationController *)tellAFriendController;

/**
 * Lanuches the gift app itunes screen
 */
- (void)giftThisApp;

/**
 * Lanuches the gift app itunes screen, with optional informational alert view
 * @param alertView optional informational alert view
 */
- (void)giftThisAppWithAlertView:(BOOL)alertView;

/**
 * Lanuches the app store rate this app screen
 */
- (void)rateThisApp;

/**
 * Lanuches the app store rate this app screen, with optional informational alert view
 * @param alertView optional informational alert view
 */
- (void)rateThisAppWithAlertView:(BOOL)alertView;

/**
 * Lanuches the share twitter app screen
 */
- (void)twitWithAlertView:(BOOL)alertView;

/**
 * Lanuches the share facebook app screen
 */
- (void)facebookWithAlertView:(BOOL)alertView;

/**
 * Lanuches the share reddit app screen
 */

@end

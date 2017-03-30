//
//  UIViewController+DBPrivacyHelper.m
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import "UIViewController+DBPrivacyHelper.h"

@implementation UIViewController (DBPrivacyHelper)

- (void) showPrivacyHelperForType:(DBPrivacyType)type {
    [self showPrivacyHelperForType:type controller:nil didPresent:nil didDismiss:nil useDefaultSettingPane:YES];
}

- (void) showPrivacyHelperForType:(DBPrivacyType)type controller:(void(^)(DBPrivateHelperController *vc))controllerBlock
                       didPresent:(DBPrivateHelperCompletionBlock)didPresent
                       didDismiss:(DBPrivateHelperCompletionBlock)didDismiss
            useDefaultSettingPane:(BOOL)defaultSettingPane {
    
    if ( IS_IOS_8 && defaultSettingPane) {
        if ( &UIApplicationOpenSettingsURLString != nil ) {
            NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:appSettings];
            return;
        }
    }
    
    DBPrivateHelperController *vc = [DBPrivateHelperController helperForType:type];
    vc.didDismissViewController = didDismiss;
    vc.snapshot = [self snapshot];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if ( controllerBlock ) {
        controllerBlock(vc);
    }
    
    [self presentViewController:vc animated:YES completion:didPresent];
}

- (UIImage *) snapshot {
    id <UIApplicationDelegate> appDelegate = [[UIApplication sharedApplication] delegate];

    UIGraphicsBeginImageContextWithOptions(appDelegate.window.bounds.size, NO, appDelegate.window.screen.scale);
    
    [appDelegate.window drawViewHierarchyInRect:appDelegate.window.bounds afterScreenUpdates:NO];
    
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

@end
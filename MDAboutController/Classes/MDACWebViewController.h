//
//  MDACWebViewController.h
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MDACWebViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate> {
    NSURL *webURL;
    UIActivityIndicatorView *activity;
    UIWebView *webView;
    UIAlertController *alert;
}

- (id)initWithURL:(NSURL*)url;

@property (nonatomic, strong) NSURL *webURL;
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIAlertController *alert;

@end

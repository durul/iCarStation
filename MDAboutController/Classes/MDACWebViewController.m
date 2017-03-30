//
//  MDACWebViewController.m
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import "MDACWebViewController.h"


@implementation MDACWebViewController

@synthesize webURL, activity, webView, alert;

- (id)initWithURL:(NSURL*)url
{
    if ((self = [super init])) {
        self.webURL = url;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    
    [webView loadRequest:[NSURLRequest requestWithURL:webURL]];
    [self.view addSubview:webView];
    
    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    UIBarButtonItem *loadButton = [[UIBarButtonItem alloc] initWithCustomView:activity];
    self.navigationItem.rightBarButtonItem = loadButton;
    self.navigationItem.title = @"Loading…";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat toolbarHeight = 0;
    if (!self.navigationController.navigationBarHidden && self.navigationController.navigationBar.translucent) {
        toolbarHeight = self.navigationController.navigationBar.frame.size.height;
    }
    
    webView.frame = CGRectMake(0, toolbarHeight, self.view.bounds.size.width, self.view.bounds.size.height-toolbarHeight);
}

#pragma mark UIWebViewDelegate

//TODO: Implement refresh/reload activity button in toolbar via delegates
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    activity.hidden = NO;
    [activity startAnimating];
    self.navigationItem.title = @"Loading…";
}

- (void)webViewDidFinishLoad:(UIWebView *)view
{
    [activity stopAnimating];
    activity.hidden = YES;
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activity stopAnimating];
    activity.hidden = YES;
    
    alert = [UIAlertController
             alertControllerWithTitle:@"An error accessing the internet"
             message:[error localizedDescription]
             preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // Open App Store URLs via UIApplication
    if ([[request.URL absoluteString] rangeOfString:@"itunes.apple.com"].location != NSNotFound)
    {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma mark UI Alert delegate to pop back
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self.presentedViewController dismissViewControllerAnimated:YES completion:NULL];
        }      
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end

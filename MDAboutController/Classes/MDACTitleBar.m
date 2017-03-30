//
//  MDACTitleBar.m
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import "MDACTitleBar.h"
#import "MDAboutController.h"

@implementation MDACTitleBar

- (id)initWithController:(MDAboutController *)controller
{
    if ((self = [super initWithFrame:CGRectMake(0, 0, 320, 59)])) {
        background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 59)];
        background.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        background.image = [UIImage imageNamed:@"navigationBackground-7.png"];
        background.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:background];
        
        title = [[UILabel alloc] initWithFrame:self.bounds];
        title.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        title.backgroundColor = nil;
        title.opaque = NO;
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor whiteColor];
        title.text = @"About";
        title.font = [UIFont boldSystemFontOfSize:20];
        title.shadowColor = [UIColor colorWithWhite:0 alpha:0.6];
        title.shadowOffset = CGSizeMake(0, -1);
        [self addSubview:title];
        
        doneButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-55, 7, 50, 30)];
        doneButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
       // [doneButton setBackgroundImage:[UIImage imageNamed:@"navbar-item"] forState:UIControlStateNormal];
        //[doneButton setBackgroundImage:[UIImage imageNamed:@"navbarbutton2.png"] forState:UIControlStateHighlighted];
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];

        [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneButton setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.6] forState:UIControlStateNormal];
        doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        doneButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
        [doneButton addTarget:controller action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:doneButton];
    }
    return self;
}

- (void)setTitle:(NSString *)aTitle
{
    title.text = aTitle;
}

- (NSString *)title
{
    return title.text;
}

- (void)setButtonTitle:(NSString *)aTitle
{
    doneButton.titleLabel.text = aTitle;
}

- (NSString *)buttonTitle
{
    return doneButton.titleLabel.text;
}

- (void)setButtonHidden:(BOOL)yn
{
    buttonHidden = yn;
    
    if (buttonHidden) {
        doneButton.frame = CGRectMake(self.bounds.size.width+5, 25, 50, 30);
    } else {
        doneButton.frame = CGRectMake(self.bounds.size.width-55, 25, 50, 30);
    }
}

- (BOOL)isButtonHidden
{
    return buttonHidden;
}

@end
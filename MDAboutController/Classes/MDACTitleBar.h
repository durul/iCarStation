//
//  MDACTitleBar.h
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import <UIKit/UIKit.h>
@class MDAboutController;

@interface MDACTitleBar : UIView {
    UILabel *title;
    UIButton *doneButton;
    
    UIImageView *background;
    BOOL buttonHidden;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *buttonTitle;
@property (nonatomic, getter = isButtonHidden) BOOL buttonHidden;

- (id)initWithController:(MDAboutController *)controller;

@end
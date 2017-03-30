//
//  SlideMessageViewController.h
//  icarstationserver
//
//  Created by durul on 03/03/14.
//  Copyright (c) 2014 durul dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>

enum slideDirection
{
	kSlideUp = 0,
	kSlideDown,
	kSlideRight,
	kSlideLeft,
};


@interface SlideMessageViewController :UIView
{
	int			newDelay;
	int			newY;
	int			newX;
	int			myDir;
}
@property (nonatomic, strong) UILabel		*titleLabel;
@property (nonatomic, strong) UILabel		*msgLabel;

- (void)showMsgWithDelay:(int)delay;
- (void)hideMsg;
- (id)initWithDirection:(int)dir header:(NSString *)title message:(NSString *)msg;


@end

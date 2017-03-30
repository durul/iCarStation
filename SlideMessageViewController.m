//
//  SlideMessageViewController.m
//  icarstationserver
//
//  Created by durul on 03/03/14.
//  Copyright (c) 2014 durul dalkanat. All rights reserved.
//

#import "SlideMessageViewController.h"

@interface SlideMessageViewController ()

@end

@implementation SlideMessageViewController
@synthesize msgLabel,titleLabel;


/**************************************************************************
 *
 * Private implementation section
 *
 **************************************************************************/

#pragma mark -
#pragma mark Private Methods

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (void)hideMsg;
{
	// Slide the view off screen
	CGRect frame = self.frame;
	int retractY = 0;
	int retractX = 0;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.75];
	
	switch (myDir)
    {
		case 0:	//slideup
			retractY = 480;
			retractX = 0;
			break;
		case 1:	//slidedown
			retractY = -90;
			retractX = 0;
			break;
		case 2:	//slideright
			retractY = 196;
			retractX = -320;
			break;
		case 3:	//slideleft
			retractY = 196;
			retractX = 320;
			break;
		default:
			break;
	}
	
	frame.origin.y = retractY;
	frame.origin.x = retractX;
	self.frame = frame;
	
	//to autorelease the Msg, define stop selector
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	
	[UIView commitAnimations];
}

- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context
{
	[self removeFromSuperview];
}
/**************************************************************************
 *
 * Class implementation section
 *
 **************************************************************************/

#pragma mark -
#pragma mark Initialization

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (id)initWithDirection:(int)dir header:(NSString *)title message:(NSString *)msg;
//- (id)initWithTitle:(NSString *)title message:(NSString *)msg
{
    if (self = [super init])
    {
        //Switch direction based on slideDirection konstant
        switch (dir) {
            case kSlideUp:	//slideup
                // Notice the view y coordinate is offscreen (480)
                // This hides the view
                self.frame = CGRectMake(0, 480, 320, 90);
                [self setBackgroundColor:[UIColor blackColor]];
                [self setAlpha:.87];
                newY = 380;
                newX = 0;
                myDir = 0;
                break;
            case kSlideDown:	//slidedown
                // Notice the view y coordinate is offscreen (-90)
                // This hides the view
                self.frame = CGRectMake(0, -90, 320, 90);
                [self setBackgroundColor:[UIColor blackColor]];
                [self setAlpha:.87];
                newY = 0;
                newX = 0;
                myDir = 1;
                break;
            case kSlideRight:	//slideright
                // Notice the view x coordinate is offscreen (-320)
                // This hides the view
                self.frame = CGRectMake(-320, 196, 320, 90);
                [self setBackgroundColor:[UIColor blackColor]];
                [self setAlpha:.87];
                newY = 196;
                newX = 0;
                myDir = 2;
                break;
            case kSlideLeft:	//slideleft
                // Notice the view x coordinate is offscreen (320)
                // This hides the view
                self.frame = CGRectMake(320, 196, 320, 90);
                [self setBackgroundColor:[UIColor blackColor]];
                [self setAlpha:.87];
                newY = 196;
                newX = 0;
                myDir = 3;
                break;
            default:
                break;
        }
        
        // Title
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 3, 280, 20)];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        
        // Message
        msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, 80)];
        msgLabel.font = [UIFont systemFontOfSize:15];
        msgLabel.text = msg;
        msgLabel.textAlignment = NSTextAlignmentCenter;
        
        msgLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        msgLabel.numberOfLines = 0;	//no limit
        msgLabel.textColor = [UIColor whiteColor];
        msgLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:msgLabel];
    }
    
    return self;
}

#pragma mark -
#pragma mark Message Handling

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (void)showMsgWithDelay:(int)delay
{
    //  UIView *view = self.view;
	CGRect frame = self.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.75];
    
	// Slide up based on y axis
	// A better solution over a hard-coded value would be to
	// determine the size of the title and msg labels and
	// set this value accordingly
	
	frame.origin.y = newY;
	frame.origin.x = newX;
	self.frame = frame;
    
	[UIView commitAnimations];
    
	// Hide the view after the requested delay
	[self performSelector:@selector(hideMsg) withObject:nil afterDelay:delay];
    
}

#pragma mark -
#pragma mark Cleanup

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (void)dealloc
{
    if ([self superview])
        [self removeFromSuperview];
}


@end

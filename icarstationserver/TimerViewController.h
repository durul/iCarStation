//
//  TimerViewController.h
//  icarstationclient
//
//  Created by durul on 30.06.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoleDetailTVC.h"

@interface TimerViewController : UIViewController

@property (weak, nonatomic) id delegate;

- (IBAction)setTime:(id)sender;
- (IBAction)dismissTime:(id)sender;
- (IBAction)dismissPage:(id)sender ;

@end

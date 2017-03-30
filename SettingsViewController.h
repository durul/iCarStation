//
//  SettingsViewController.h
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDACClasses.h"

@interface SettingsViewController : UITableViewController
{
    MDAboutController *aboutController;

}
- (IBAction)about:(id)sender;


@end

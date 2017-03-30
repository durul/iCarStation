//
//  LocationsViewController.h
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationsData.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface LocationsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate> {
    IBOutlet UITableView *locationsTableView;
    LocationsData *locationsData;
    NSMutableArray *items;
    UILabel *message;
}

@property (nonatomic, retain) UITableView *locationsTableView;
@property (nonatomic, retain) LocationsData *locationsData;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) IBOutlet UILabel *message;
- (void)saveLocationWithName:(NSString *)locationName longitude:(float)longitude latitude:(float)latitude;

- (IBAction)sendLocation:(id)sender;

@end

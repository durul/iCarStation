//
//  LocationsCell.m
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import "LocationsCell.h"
#import "LocationsData.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@implementation LocationsCell
@synthesize title, btn, items, currentLat, currentLong;

- (void)viewDidLoad
{
    self.title.font = [UIFont fontWithName:@"Eurostile-Oblique" size:15.f];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showItinerary:(id)sender {
    
    LocationsData *currentData = [items objectAtIndex:btn.tag];
    
    // this will open iOS 6 Plans app
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 5.1) {
    
        Class itemClass = [NSClassFromString(@"MKMapItem") class];
        
        if (itemClass && [itemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {

            CLLocationCoordinate2D theCoordinate;
            theCoordinate.latitude = [currentData.latitude floatValue];
            theCoordinate.longitude = [currentData.longitude floatValue];
            
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:theCoordinate addressDictionary:nil];
            id mapItem = [[NSClassFromString(@"MKMapItem") alloc] initWithPlacemark:placemark];
            
            NSDictionary *mapOptions = [NSDictionary dictionaryWithObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
            
            [mapItem openInMapsWithLaunchOptions:mapOptions];
            
            
            return;
        }
    }
    
    // this is for older iOS's
	NSString *address = [NSString stringWithFormat:@"http://maps.google.com/maps?daddr=%@,%@&saddr=%f,%f", currentData.latitude, currentData.longitude, currentLat, currentLong];

	NSURL *url = [[NSURL alloc] initWithString:address];
	[[UIApplication sharedApplication] openURL:url];
    
}

@end

//
//  ViewController.h
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, UITextFieldDelegate,MKMapViewDelegate> {
    CLLocationManager *locationManager;
    IBOutlet MKMapView *mapView;
    CLLocation *userLocation;
    BOOL canLocate;
    
    BOOL zoomToLocationOnce;
    
    IBOutlet UITextField *nameField;
    IBOutlet UIToolbar *nameFieldContainer;
    IBOutlet UIView *addLocationOverlay;
    
    IBOutlet UILabel* addressLabel;

}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) MKMapView *mapView;
@property BOOL canLocate;
@property (nonatomic, retain) UITextField *nameField;

#pragma mark Text field delegate
- (IBAction)textfieldReturn:(id)sender;
//- (IBAction)cancelAdding:(id)sender;

- (void)stopLocationServices;

@end

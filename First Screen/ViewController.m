//
//  ViewController.m
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import "ViewController.h"
#import "LocationsViewController.h"
#import "VBAnnotation.h"
#import "UIViewController+DBPrivacyHelper.h"

#define ZOOM_LEVEL 0.05

@interface ViewController()
-(void)revGeocode:(CLLocation*)c;
-(void)geocode:(NSString*)address;
@end

@implementation ViewController
@synthesize locationManager, mapView, canLocate, nameField;

- (void)viewDidLoad {
    [super viewDidLoad];

    // start services
    [self.mapView setDelegate:self];

    // create the Location Manager
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];

    // settings
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    zoomToLocationOnce = YES;

    // Enabling 3D mode
    mapView.pitchEnabled = YES;
    // Set a timer to stop the Location services
    [NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(stopLocationServices) userInfo:nil repeats:NO];
    
    // start services
    mapView.showsUserLocation = YES;
    
    if (!canLocate) {
        [locationManager startUpdatingLocation];
    }else{
        [self delayedZoomToLocation];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePowerMode:)
                                                 name:NSProcessInfoPowerStateDidChangeNotification
                                               object:nil];

}

- (void)didReceiveMemoryWarning
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:NSLocalizedString(@"Memory Problem", @"Hafıza Problemi")
                                          message:NSLocalizedString(@"Please Close Some Applications!", @"Bazi uygulamalarinizi kapatin")
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];

    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


- (void)stopLocationServices
{
    // stop services
    [self.locationManager stopUpdatingLocation];
    [self.locationManager setDelegate:nil];
}

-(void)revGeocode:(CLLocation*)c
{

    CLGeocoder* gcrev = [[CLGeocoder alloc] init];
    [gcrev reverseGeocodeLocation:c completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark* revMark = [placemarks objectAtIndex:0];
        //turn placemark to address text
        NSArray* addressLines = [revMark.addressDictionary objectForKey:@"FormattedAddressLines"];
        NSString* revAddress = [addressLines componentsJoinedByString: @"\n"];
        addressLabel.text = [NSString stringWithFormat:@" \n%@", revAddress];

        // Plain text alert
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Address" message:addressLabel.text preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        

        //now turn the address to coordinates
        [self geocode: revAddress];

    }];
}


-(void)geocode:(NSString*)address
{

    CLGeocoder* gc = [[CLGeocoder alloc] init];
    //2
    [gc geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {

        //3
        if ([placemarks count]>0) {
            //4
            CLPlacemark* mark = (CLPlacemark*)[placemarks objectAtIndex:0];
            double lat = mark.location.coordinate.latitude;
            double lng = mark.location.coordinate.longitude;

            //show on the map
            //1
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = lat;
            coordinate.longitude = lng;
            //2

            //3
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000);
            MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
            [mapView setRegion:adjustedRegion animated:YES];

        }
    }];
}

#pragma mark Location DataSource
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

    canLocate = YES;

    NSTimeInterval ageInSeconds = -[newLocation.timestamp timeIntervalSinceNow];
    if (ageInSeconds > 60.0) return;   // data is too long ago, don't use it


    if (zoomToLocationOnce) {
        [self performSelector:@selector(delayedZoomToLocation) withObject:nil afterDelay:1];
        zoomToLocationOnce = NO;
        [self revGeocode: newLocation];
    }

    userLocation = newLocation;

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {

    canLocate = NO;
    [self showLocationServicesError];
}

- (void)showLocationServicesError {
    [self openHelperToCustomizeTypeLocation];
}

- (void) openHelperToCustomizeTypeLocation {
    [self showPrivacyHelperForType:DBPrivacyTypeLocation controller:^(DBPrivateHelperController *vc) {
        //customize the view controller to present
    } didPresent:^{
        //customize the completion block of presentViewController:animated:completion:
    } didDismiss:^{
        //customize the completion block of dismissViewControllerAnimated:completion:
    } useDefaultSettingPane:NO]; //If NO force to use DBPrivateHelperController instead of the default settings pane on iOS 8. Only for iOS 8. Default value is YES.
}

- (void)showNoLocationToSaveError {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"There is no location to save, first you must find your current location." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark Custum Pin
//Custom Pin Konfigürasyonu
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    view.pinTintColor = [UIColor orangeColor];
    view.enabled = YES;
    view.animatesDrop = YES;
    view.canShowCallout = YES;

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car.png"]];
    view.leftCalloutAccessoryView = imageView;
    view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return view;
}

#pragma mark Map AlertView
//Current Location için uyarı mesajı veriyor.
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    // get reference to the annotation to access its data
    VBAnnotation *myAnnotation = (VBAnnotation *)view.annotation;
    // deselect the button
    [self.mapView deselectAnnotation:myAnnotation animated:YES];
    // construct string with coordinate information
    NSString *msg = [@"Location:\n" stringByAppendingFormat:@"latitude: %f longitude: %f", myAnnotation.coordinate.latitude, myAnnotation.coordinate.longitude];
    // display alert view to the information

    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:NSLocalizedString(@"My Car is Here", @"Arabam Burada")
                                          message:msg
                                          preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"\u2705 Ok", @"\u2705 EVET") style:
                                UIAlertActionStyleDefault handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"\u26A0 Cancel", @"\u26A0 HAYIR") style:
                                UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark Zoom Location
- (void)delayedZoomToLocation {

    if (canLocate) {

        MKCoordinateRegion region;
        region.center = self.mapView.userLocation.coordinate;

        MKCoordinateSpan span;
        span.latitudeDelta  = ZOOM_LEVEL;
        span.longitudeDelta = ZOOM_LEVEL;
        region.span = span;

        [self.mapView setRegion:region animated:YES];

    }else{

        mapView.showsUserLocation = NO;
    }
}


#pragma mark Text field delegate

- (IBAction)textfieldReturn:(id)sender {
   // NSLog(@"ended");

    if (canLocate) {

        LocationsViewController *locationsController = [[LocationsViewController alloc] initWithNibName:@"LocationsViewController" bundle:nil];

        [locationsController saveLocationWithName:nameField.text longitude:userLocation.coordinate.longitude latitude:userLocation.coordinate.latitude];
    }
}

- (void)animateNameField:(int)direction {
    if (direction == 0) {
        [UIView animateWithDuration:0.3f animations:^{
            nameFieldContainer.center = CGPointMake(nameFieldContainer.center.x, 22);
            addLocationOverlay.alpha = 0.8f;
        }];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            nameFieldContainer.center = CGPointMake(nameFieldContainer.center.x, 395);
            addLocationOverlay.alpha = 0;
        }];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // NSLog(@"started");

    if (!canLocate) {
        [self showNoLocationToSaveError];
        [nameField resignFirstResponder];
        return;
    }

    [self animateNameField:0];
}

#pragma mark start location
-(void)applicationWillEnterForeground:(UIApplication *)application{
    if (![self checkLocationAuthorization]) return;

    if (locationManager == nil) {
        locationManager = [CLLocationManager new];
    }
    [locationManager startUpdatingLocation];
    [locationManager setDelegate:self];

}

#pragma mark stop location
-(void)applicationWillEnterBackground:(UIApplication *)application{
    
    if (locationManager) return;
    [locationManager stopUpdatingLocation];
    zoomToLocationOnce = NO;

}

#pragma mark location support

- (BOOL) checkLocationAuthorization {
	if (![CLLocationManager locationServicesEnabled]) {
		return NO;
	}

    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];

    if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {

        [self.locationManager startUpdatingLocation];
        mapView.showsUserLocation = YES;

    }

	return YES;
}

#pragma mark Energy Efficiency

- (void)didChangePowerMode:(NSNotification *)notification {
    if ([[NSProcessInfo processInfo] isLowPowerModeEnabled]) {
        [self.locationManager stopUpdatingLocation];
    } else {
        [locationManager startUpdatingLocation];
    }
}

@end

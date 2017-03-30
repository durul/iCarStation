//
//  VBAnnotation.h
//  Annotation
//
//  Created by Véronique Brossier on 6/19/12.
//  Copyright (c) 2012 chez Véronique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface VBAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- initWithPosition:(CLLocationCoordinate2D)coords;

@end
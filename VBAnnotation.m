//
//  VBAnnotation.m
//  Annotation
//
//  Created by Véronique Brossier on 6/19/12.
//  Copyright (c) 2012 chez Véronique. All rights reserved.
//

#import "VBAnnotation.h"

@implementation VBAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- initWithPosition:(CLLocationCoordinate2D)coords {
    if (self = [super init]) {
        self.coordinate = coords;
    }
    return self;
}

@end

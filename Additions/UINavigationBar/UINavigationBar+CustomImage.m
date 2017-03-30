//
//  UINavigationBar+CustomImage.m
//  foody
//
//  Created by Valentin Filip on 9/27/12.
//
//
#import <QuartzCore/QuartzCore.h>
#import "UINavigationBar+CustomImage.h"

@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage tallImageNamed: @"titleBar.png"];
    [image drawInRect:CGRectMake(0, 0, 320, 44)];
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    [self applyDefaultStyle];
}

- (void)applyDefaultStyle {
    // add the drop shadow
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0.0, 3);
    self.layer.shadowOpacity = 0.25;
    self.layer.masksToBounds = NO;
    self.layer.shouldRasterize = YES;
}

@end

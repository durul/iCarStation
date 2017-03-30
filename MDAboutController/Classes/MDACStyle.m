//
//  MDACStyle.m
//  MDAboutControllerDemo
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import "MDACStyle.h"

@implementation MDACStyle

+ (id)style
{
    return [[self alloc] init];
}

- (UIColor *)backgroundColor
{
    __strong static UIColor *tableViewBackgroundColor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat scale = [[UIScreen mainScreen] scale];
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(8.f, 1.f), NO, scale);
        CGContextRef c = UIGraphicsGetCurrentContext();
        if (scale > 1) {
            [[UIColor colorWithRed:206/255. green:211/255. blue:220/255. alpha:1] setFill];
            CGContextFillRect(c, CGRectMake(0, 0, 5.5, 1));
            [[UIColor colorWithRed:203/255. green:208/255. blue:218/255. alpha:1] setFill];
            CGContextFillRect(c, CGRectMake(5.5, 0, 2.5, 1));
        } else {
            [[UIColor colorWithRed:206/255. green:211/255. blue:220/255. alpha:1] setFill];
            CGContextFillRect(c, CGRectMake(0, 0, 6, 1));
            [[UIColor colorWithRed:203/255. green:208/255. blue:218/255. alpha:1] setFill];
            CGContextFillRect(c, CGRectMake(6, 0, 2, 1));
        }
        tableViewBackgroundColor = [UIColor colorWithPatternImage:UIGraphicsGetImageFromCurrentImageContext()];
        UIGraphicsEndImageContext();
    });
    return tableViewBackgroundColor;
}

- (BOOL)hasSimpleBackground
{
    return YES;
}

- (CGFloat)spacerHeight
{
    return 25;
}

- (CGFloat)listHeight
{
    return 44;
}

- (CGFloat)iconAdditionalHeight
{
    return 20;
}

- (CGFloat)listTitleHeight
{
    return 23;
}

- (UIImage *)listCellBackgroundTop
{
    return [[UIImage imageNamed:@"MDACCellBackgroundTop.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundMiddle
{
    return [[UIImage imageNamed:@"MDACCellBackgroundMiddle.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundBottom
{
    return [[UIImage imageNamed:@"MDACCellBackgroundBottom.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundSingle
{
    return [[UIImage imageNamed:@"MDACCellBackgroundSingle.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundTopSelected
{
    return [[UIImage imageNamed:@"MDACCellBackgroundSelectedTop.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundMiddleSelected
{
    return [[UIImage imageNamed:@"MDACCellBackgroundSelectedMiddle.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundBottomSelected
{
    return [[UIImage imageNamed:@"MDACCellBackgroundSelectedBottom.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundSingleSelected
{
    return [[UIImage imageNamed:@"MDACCellBackgroundSelectedSingle.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIFont *)listCellFont
{
    return [UIFont boldSystemFontOfSize:17];
}

- (UIFont *)listCellDetailFont
{
    return [UIFont boldSystemFontOfSize:15];
}

- (UIColor *)listCellBackgroundColor
{
    return [UIColor colorWithWhite:247./255. alpha:1];
}

- (UIColor *)listCellTextColor
{
    return [UIColor blackColor];
}

- (UIColor *)listCellDetailTextColor
{
    return [UIColor colorWithWhite:0 alpha:0.6];
}

- (UIColor *)listCellShadowColor
{
    return [UIColor colorWithWhite:253./255. alpha:0.6];
}

- (CGSize)listCellShadowOffset
{
    return CGSizeMake(0, 1);
}

- (UIImage *)listCellLinkArrow
{
    return [UIImage imageNamed:@"MDACLinkArrow.png"];
}

- (UIFont *)listCellTitleFont
{
    return [UIFont boldSystemFontOfSize:17];
}

- (UIColor *)listCellTitleTextColor
{
    return [self iconCellTextColor];
}

- (UIColor *)listCellTitleShadowColor
{
    return [self iconCellShadowColor];
}

- (CGSize)listCellTitleShadowOffset
{
    return [self iconCellShadowOffset];
}

- (UIFont *)iconCellFont
{
    return [UIFont boldSystemFontOfSize:18];
}

- (UIFont *)iconCellDetailFont
{
    return [UIFont boldSystemFontOfSize:14];
}

- (UIColor *)iconCellTextColor
{
    return [UIColor colorWithRed:75./255. green:85./255. blue:109./255. alpha:1];
}

- (UIColor *)iconCellShadowColor
{
    return [UIColor whiteColor];
}

- (CGSize)iconCellShadowOffset
{
    return CGSizeMake(0, 1);
}

- (UIColor *)textCellTextColor
{
    return [UIColor colorWithRed:75./255. green:85./255. blue:109./255. alpha:1];
}

- (UIColor *)textCellHighlightedTextColor
{
    return [UIColor darkGrayColor];
}

- (UIColor *)textCellShadowColor
{
    return [UIColor whiteColor];
}

- (CGSize)textCellShadowOffset
{
    return CGSizeMake(0, 1);
}


@end

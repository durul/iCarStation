//
//  MDACMochiDevStyle.m
//  MDAboutControllerDemo
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import "MDACMochiDevStyle.h"

@implementation MDACMochiDevStyle

- (UIColor *)backgroundColor
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
}

- (BOOL)hasSimpleBackground
{
    return NO;
}

- (UIImage *)listCellBackgroundTop
{
    return [[UIImage imageNamed:@"MDACDarkCellBackgroundTop.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundMiddle
{
    return [[UIImage imageNamed:@"MDACDarkCellBackgroundMiddle.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundBottom
{
    return [[UIImage imageNamed:@"MDACDarkCellBackgroundBottom.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundSingle
{
    return [[UIImage imageNamed:@"MDACDarkCellBackgroundSingle.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundTopSelected
{
    return [[UIImage imageNamed:@"MDACDarkCellBackgroundSelectedTop.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundMiddleSelected
{
    return [[UIImage imageNamed:@"MDACDarkCellBackgroundSelectedMiddle.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundBottomSelected
{
    return [[UIImage imageNamed:@"MDACDarkCellBackgroundSelectedBottom.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIImage *)listCellBackgroundSingleSelected
{
    return [[UIImage imageNamed:@"MDACDarkCellBackgroundSelectedSingle.png"] stretchableImageWithLeftCapWidth:7 topCapHeight:10];
}

- (UIColor *)listCellBackgroundColor
{
    return [UIColor colorWithWhite:94./255. alpha:1];
}

- (UIColor *)listCellTextColor
{
    return [UIColor whiteColor];
}

- (UIColor *)listCellDetailTextColor
{
    return [UIColor colorWithWhite:1 alpha:0.7];
}

- (UIColor *)listCellShadowColor
{
    return [UIColor colorWithWhite:0 alpha:0.6];
}

- (CGSize)listCellShadowOffset
{
    return CGSizeMake(0, -1);
}

- (UIImage *)listCellLinkArrow
{
    return [UIImage imageNamed:@"MDACDarkLinkArrow.png"];
}

- (UIColor *)iconCellTextColor
{
    return [UIColor whiteColor];
}

- (UIColor *)iconCellShadowColor
{
    return [UIColor colorWithWhite:0 alpha:0.8];
}

- (CGSize)iconCellShadowOffset
{
    return CGSizeMake(0, -1);
}

- (UIColor *)textCellTextColor
{
    return [UIColor colorWithWhite:0.75 alpha:1];
}

- (UIColor *)textCellHighlightedTextColor
{
    return [UIColor colorWithWhite:0.5 alpha:1];
}

- (UIColor *)textCellShadowColor
{
    return [UIColor colorWithWhite:0 alpha:0.8];
}

- (CGSize)textCellShadowOffset
{
    return CGSizeMake(0, -1);
}


@end

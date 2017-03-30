//
//  MDACStyle.h
//  MDAboutControllerDemo
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface MDACStyle : NSObject

+ (id)style;

- (UIColor *)backgroundColor;
- (BOOL)hasSimpleBackground;

- (CGFloat)spacerHeight;
- (CGFloat)listHeight;
- (CGFloat)iconAdditionalHeight;
- (CGFloat)listTitleHeight;

- (UIImage *)listCellBackgroundTop;
- (UIImage *)listCellBackgroundMiddle;
- (UIImage *)listCellBackgroundBottom;
- (UIImage *)listCellBackgroundSingle;

- (UIImage *)listCellBackgroundTopSelected;
- (UIImage *)listCellBackgroundMiddleSelected;
- (UIImage *)listCellBackgroundBottomSelected;
- (UIImage *)listCellBackgroundSingleSelected;

- (UIFont *)listCellFont;
- (UIFont *)listCellDetailFont;
- (UIColor *)listCellBackgroundColor;
- (UIColor *)listCellTextColor;
- (UIColor *)listCellDetailTextColor;
- (UIColor *)listCellShadowColor;
- (CGSize)listCellShadowOffset;
- (UIImage *)listCellLinkArrow;

- (UIFont *)listCellTitleFont;
- (UIColor *)listCellTitleTextColor;
- (UIColor *)listCellTitleShadowColor;
- (CGSize)listCellTitleShadowOffset;

- (UIFont *)iconCellFont;
- (UIFont *)iconCellDetailFont;
- (UIColor *)iconCellTextColor;
- (UIColor *)iconCellShadowColor;
- (CGSize)iconCellShadowOffset;

- (UIColor *)textCellTextColor;
- (UIColor *)textCellHighlightedTextColor;
- (UIColor *)textCellShadowColor;
- (CGSize)textCellShadowOffset;

@end

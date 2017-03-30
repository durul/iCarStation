//
//  DBPrivateHelperCell.h
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface DBPrivateHelperCell : UITableViewCell
/**
 *  Reuse Identifier for cell
 *
 *  @return An instance type of DBPrivateHelperCell
 */
+ (NSString *) identifier;

/**
 *  Set the cell values
 *
 *  @param icon The icon
 *  @param text The description text
 *  @param row  The row number
 */
- (void) setIcon:(NSString *)icon text:(NSString *)text row:(NSInteger)row;
@end
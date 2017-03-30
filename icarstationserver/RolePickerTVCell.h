//
//  RolePickerTVCell.h
//  Staff Manager
//
//  Created by Durul Dalkanat on 26/02/12.
//  Copyright (c) 2012 Durul Dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewCell.h"
#import "Role.h"

@class RolePickerTVCell;

@protocol RolePickerTVCellDelegate <NSObject>
- (void)roleWasSelectedOnPicker:(Role*)role;
@end

@interface RolePickerTVCell : CoreDataTableViewCell <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id <RolePickerTVCellDelegate> delegate;
@property (nonatomic, strong) Role *selectedRole;

@end
//
//  BasePickerTVCell.h
//  icarstationserver
//
//  Created by durul dalkanat on 8/18/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewCell.h"
#import "Base.h"

@class BasePickerTVCell;

@protocol BasePickerTVCellDelegate <NSObject>
- (void)roleWasSelectedOnPicker:(Base*)base;
@end

@interface BasePickerTVCell : CoreDataTableViewCell <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id <BasePickerTVCellDelegate> delegate;
@property (nonatomic, strong) Base *selectedBase;

@end
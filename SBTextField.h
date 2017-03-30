//
//  SBTextField.h
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPFloatingPlaceholderConstants.h"

@class SBTextField;

/*! This protocol is for the most part the same as the UITextFieldDelegate protocol. Any documentation provided in the UITextFieldDelegate protocol applies to this protocol as well. */
@protocol SBTextFieldDelegate <UITextFieldDelegate, NSObject>
@optional
- (BOOL)textFieldShouldBeginEditing:(SBTextField *)textField;
- (void)textFieldDidBeginEditing:(SBTextField *)textField;
- (BOOL)textFieldShouldEndEditing:(SBTextField *)textField;
- (void)textFieldDidEndEditing:(SBTextField *)textField;

// This method will not get called if the user tries to exceed the maximum number of characters allowed (as defined by maxLength)
- (BOOL)textField:(SBTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

- (BOOL)textFieldShouldClear:(SBTextField *)textField;
- (BOOL)textFieldShouldReturn:(SBTextField *)textField;
@end

/*! SBTextField is a drop-in replacement for UITextField that allows the user to limit the maximum number of characters that can be entered in the text field.
 */
@interface SBTextField : UITextField
@property (nonatomic, weak) id <SBTextFieldDelegate> delegate;

/*! Defines the maximum number of characters that can be entered in the text field. The default is 0, which translates to a virtually unlimited number of characters. */
@property (nonatomic) NSUInteger maxLength; // Default is 0, meaning unlimited


/**
 Enum to switch between upward and downward animation of the floating label.
 */
@property (nonatomic) RPFloatingPlaceholderAnimationOptions animationDirection;

/**
 The floating label that is displayed above the text field when there is other
 text in the text field.
 */
@property (nonatomic, strong, readonly) UILabel *floatingLabel;

/**
 The color of the floating label displayed above the text field when it is in
 an active state (i.e. the associated text view is first responder).
 
 @discussion Note: Tint color is used by default if this is nil.
 */
@property (nonatomic, strong) UIColor *floatingLabelActiveTextColor;

/**
 The color of the floating label displayed above the text field when it is in
 an inactive state (i.e. the associated text view is not first responder).
 
 @discussion Note: 70% gray is used by default if this is nil.
 */
@property (nonatomic, strong) UIColor *floatingLabelInactiveTextColor;

@end

//
//  MDAboutController.h
//  MDAboutController
//  iCarStation
//
//  Created by durul on 19.02.2013.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//


#import <MessageUI/MessageUI.h>
#import <UIKit/UIKit.h>
@class MDACCredit, MDACStyle, MDAboutController, MDACCreditItem;

@protocol MDAboutControllerDelegate <NSObject>

@optional

- (BOOL)aboutControllerShouldDisplayDoneButton:(MDAboutController *)aController;

- (UIViewController *)viewControllerToPresentMailController:(MDAboutController *)aController;
- (void)aboutControllerWillPresentMailController:(MDAboutController *)aController;
- (void)aboutControllerDidDismissMailController:(MDAboutController *)aController;

- (void)aboutControllerDidReloadCredits:(MDAboutController *)aController;
// default is if item has a link or controller

- (void)aboutController:(MDAboutController *)anAboutController didSelectItem:(MDACCreditItem *)item fromCredit:(MDACCredit *)credit withIdentifier:(NSString *)identifier;
- (BOOL)aboutController:(MDAboutController *)anAboutController shouldOpenURL:(NSURL *)anURL forItem:(MDACCreditItem *)item fromCredit:(MDACCredit *)credit withIdentifier:(NSString *)identifier;
- (BOOL)aboutController:(MDAboutController *)anAboutController shouldPresentController:(UIViewController *)aController forItem:(MDACCreditItem *)item fromCredit:(MDACCredit *)credit withIdentifier:(NSString *)identifier;
// return NO if you want to display it yourself - default is YES

- (BOOL)aboutController:(MDAboutController *)anAboutController isItemSelectable:(MDACCreditItem *)item fromCredit:(MDACCredit *)credit withIdentifier:(NSString *)identifier;

- (UIViewController *)aboutController:(MDAboutController *)anAboutController viewControllerToPresentAuxiliaryController:(UIViewController *)aController forItem:(MDACCreditItem *)item fromCredit:(MDACCredit *)credit withIdentifier:(NSString *)identifier;
- (void)aboutController:(MDAboutController *)anAboutController willPresentAuxiliaryController:(UIViewController *)aController forItem:(MDACCreditItem *)item fromCredit:(MDACCredit *)credit withIdentifier:(NSString *)identifier;
- (void)aboutController:(MDAboutController *)anAboutController didPresentAuxiliaryController:(UIViewController *)aController forItem:(MDACCreditItem *)item fromCredit:(MDACCredit *)credit withIdentifier:(NSString *)identifier;
@end

@interface MDAboutController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
  @private
    UIView *titleBar;
    UITableView *tableView;
    
    NSMutableArray *credits;
    
    NSMutableArray *cachedCellCredits;
    NSMutableArray *cachedCellIDs;
    NSMutableArray *cachedCellIndices;
    NSMutableArray *cachedCellHeights;
    
    BOOL showsTitleBar;
    
    UIColor *backgroundColor;
    BOOL hasSimpleBackground;
    
    MDACStyle *style;
    
    id<MDAboutControllerDelegate> __weak delegate;
    
    BOOL reloadingCredits;
    
    UIImage *iconImage;
}

- (id)initWithStyle:(MDACStyle *)style;
- (id)initWithCreditsName:(NSString *)creditsName;
- (id)initWithCreditsName:(NSString *)creditsName style:(MDACStyle *)style; // designated initializer

- (IBAction)dismiss:(id)sender; // hide if modal

@property (nonatomic, readonly, strong) NSString *creditsName;
@property (nonatomic, readonly, strong) MDACStyle *style;
@property (nonatomic, strong) UIView *titleBar;

@property (nonatomic) BOOL showsTitleBar; // set to NO automatically when in navcontroller. 
- (void)setShowsTitleBar:(BOOL)yn animated:(BOOL)animated;

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic) BOOL hasSimpleBackground; // set automatically to YES for non patterend background. Set to YES for better performance, at the cost of a patterned backgrounds looking weird.

@property (nonatomic, weak) IBOutlet id<MDAboutControllerDelegate> delegate;

- (void)reloadCredits;

@property (nonatomic, readonly) NSArray *credits; // for fast enumeration
@property (nonatomic, readonly) NSUInteger creditCount;

@property (nonatomic) BOOL showsAttributions; // To remove (:sadface:) the attributions, set to NO;

- (void)addCredit:(MDACCredit *)aCredit;
- (void)insertCredit:(MDACCredit *)aCredit atIndex:(NSUInteger)index;
- (void)replaceCreditAtIndex:(NSUInteger)index withCredit:(MDACCredit *)aCredit;
- (void)removeLastCredit __attribute__((deprecated));
- (void)removeCredit:(MDACCredit *)aCredit;
- (void)removeCreditAtIndex:(NSUInteger)index;

@end

//
//  ADVTheme.m
//  
//
//  Created by Valentin Filip on 7/9/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "ADVTheme.h"
#import "ADVRemindersTheme.h"

@implementation ADVThemeManager

+ (id <ADVTheme>)sharedTheme
{
    static id <ADVTheme> sharedTheme = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Create and return the theme:
        sharedTheme = [[ADVRemindersTheme alloc] init];
    });
    
    return sharedTheme;
}
    
    
+ (void)customizeAppAppearance
{
    id <ADVTheme> theme = [self sharedTheme];

    UIStatusBarStyle statusBarStyle = [theme statusBarStyle];
    if (statusBarStyle) {
        [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    }
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[theme navigationBackgroundForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setBackgroundImage:[theme navigationBackgroundForBarMetrics:UIBarMetricsCompactPrompt] forBarMetrics:UIBarMetricsCompactPrompt];
   
    UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearance];
            
    [barButtonItemAppearance setBackgroundImage:[theme barButtonBackgroundForState:UIControlStateNormal style:UIBarButtonItemStylePlain barMetrics:UIBarMetricsDefault] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    [barButtonItemAppearance setBackButtonBackgroundImage:[theme backBackgroundForState:UIControlStateNormal barMetrics:UIBarMetricsDefault] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackButtonBackgroundImage:[theme backBackgroundForState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackButtonBackgroundImage:[theme backBackgroundForState:UIControlStateNormal barMetrics:UIBarMetricsCompactPrompt] forState:UIControlStateNormal barMetrics:UIBarMetricsCompactPrompt];
    [barButtonItemAppearance setBackButtonBackgroundImage:[theme backBackgroundForState:UIControlStateHighlighted barMetrics:UIBarMetricsCompactPrompt] forState:UIControlStateHighlighted barMetrics:UIBarMetricsCompactPrompt];
    
    
    UIToolbar *toolbarAppearance = [UIToolbar appearance];
    [toolbarAppearance setBackgroundImage:[theme toolbarBackgroundForBarMetrics:UIBarMetricsDefault] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    [toolbarAppearance setBackgroundImage:[theme toolbarBackgroundForBarMetrics:UIBarMetricsCompactPrompt] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsCompactPrompt];
    
    UISearchBar *searchBarAppearance = [UISearchBar appearance];
    [searchBarAppearance setBackgroundImage:[theme searchBackground]];
    [searchBarAppearance setSearchFieldBackgroundImage:[theme searchFieldImage] forState:UIControlStateNormal];
    [searchBarAppearance setImage:[theme searchImageForIcon:UISearchBarIconSearch state:UIControlStateNormal] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [searchBarAppearance setImage:[theme searchImageForIcon:UISearchBarIconClear state:UIControlStateNormal] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [searchBarAppearance setImage:[theme searchImageForIcon:UISearchBarIconClear state:UIControlStateHighlighted] forSearchBarIcon:UISearchBarIconClear state:UIControlStateHighlighted];
    [searchBarAppearance setScopeBarBackgroundImage:[theme searchScopeBackground]];
    [searchBarAppearance setScopeBarButtonBackgroundImage:[theme searchScopeButtonBackgroundForState:UIControlStateNormal] forState:UIControlStateNormal];
    [searchBarAppearance setScopeBarButtonBackgroundImage:[theme searchScopeButtonBackgroundForState:UIControlStateSelected] forState:UIControlStateSelected];
    [searchBarAppearance setScopeBarButtonDividerImage:[theme searchScopeButtonDivider] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal];
    
    UISlider *sliderAppearance = [UISlider appearance];
    [sliderAppearance setThumbImage:[theme sliderThumbForState:UIControlStateNormal] forState:UIControlStateNormal];
    [sliderAppearance setThumbImage:[theme sliderThumbForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
    [sliderAppearance setMinimumTrackImage:[theme sliderMinTrack] forState:UIControlStateNormal];
    [sliderAppearance setMaximumTrackImage:[theme sliderMaxTrack] forState:UIControlStateNormal];
    
    UIProgressView *progressAppearance = [UIProgressView appearance];
    [progressAppearance setTrackImage:[theme progressTrackImage]];

    
    UISwitch *switchAppearance = [UISwitch appearance];
    [switchAppearance setOnTintColor:[theme switchOnColor]];

    
    NSMutableDictionary *titleTextAttributesNav = [[NSMutableDictionary alloc] init];
    UIColor *navTextColor = [theme navigationTextColor];
    if (navTextColor) {
        titleTextAttributesNav[NSForegroundColorAttributeName] = navTextColor;
    }
    
    UIFont *navTextFont = [theme navigationFont];
    if (navTextFont) {
        titleTextAttributesNav[NSFontAttributeName] = navTextFont;
    }
    
    [navigationBarAppearance setTitleTextAttributes:titleTextAttributesNav];
    
    [barButtonItemAppearance setTitleTextAttributes:titleTextAttributesNav forState:UIControlStateNormal];
    [searchBarAppearance setScopeBarButtonTitleTextAttributes:titleTextAttributesNav forState:UIControlStateNormal];
    
    NSMutableDictionary *titleTextAttributes = [[NSMutableDictionary alloc] init];
    UIColor *mainColor = [theme mainColor];
    if (mainColor) {
        titleTextAttributes[NSForegroundColorAttributeName] = mainColor;
    }
    
    NSMutableDictionary *titleTextAttributesH = [[NSMutableDictionary alloc] init];
    [barButtonItemAppearance setTitleTextAttributes:titleTextAttributesH forState:UIControlStateHighlighted];
    [searchBarAppearance setScopeBarButtonTitleTextAttributes:titleTextAttributesH forState:UIControlStateHighlighted];

    
    UIColor *baseTintColor = [theme baseTintColor];
    if (baseTintColor) {
        [navigationBarAppearance setTintColor:baseTintColor];
        [barButtonItemAppearance setTintColor:baseTintColor];
        [toolbarAppearance setTintColor:baseTintColor];
        [searchBarAppearance setTintColor:baseTintColor];
        [sliderAppearance setThumbTintColor:baseTintColor];
        [sliderAppearance setMinimumTrackTintColor:baseTintColor];
        [progressAppearance setProgressTintColor:baseTintColor];

    } else if (mainColor) {

    }
}

+ (void)customizeView:(UIView *)view
{
    id <ADVTheme> theme = [self sharedTheme];
    UIImage *backgroundImage = [theme viewBackground];
    UIColor *backgroundColor = [theme backgroundColor];
    if (backgroundImage) {
        [view setBackgroundColor:[UIColor colorWithPatternImage:backgroundImage]];
    } else if (backgroundColor) {
        [view setBackgroundColor:backgroundColor];
    }
}

+ (void)customizeTableView:(UITableView *)tableView
{
    id <ADVTheme> theme = [self sharedTheme];
    UIImage *backgroundImage = [theme tableBackground];
    UIColor *backgroundColor = [theme backgroundColor];
    if (backgroundImage) {
        UIImageView *background = [[UIImageView alloc] initWithImage:backgroundImage];
        [tableView setBackgroundView:background];
    } else if (backgroundColor) {
        [tableView setBackgroundView:nil];
        [tableView setBackgroundColor:backgroundColor];
    }
}

+ (void)customizeTabBarItem:(UITabBarItem *)item forTab:(SSThemeTab)tab
{
    id <ADVTheme> theme = [self sharedTheme];
    UIImage *image = [theme imageForTab:tab];
    if (image) {
        // If we have a regular image, set that
        [item setImage:image];
    }
}

+ (void)customizeMainLabel:(UILabel *)label {
    label.textColor = [[ADVThemeManager sharedTheme] mainColor];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1);
}

+ (void)customizeSecondaryLabel:(UILabel *)label {
    label.textColor = [[ADVThemeManager sharedTheme] secondColor];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1);
}

@end

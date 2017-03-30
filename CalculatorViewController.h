//
//  CalculatorViewController.h
//  icarstationserver
//
//  Created by durul on 03/03/14.
//  Copyright (c) 2014 durul dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "SlideMessageViewController.h"

@interface CalculatorViewController :UIViewController <UIPopoverControllerDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate>
{
    NSInteger selectedTextFieldTag;
    
    int	myDelay;
    UILabel *message;
    SlideMessageViewController *msgView;
}

//Başlıklar
@property (weak, nonatomic) IBOutlet UILabel *HourlyRate;
@property (weak, nonatomic) IBOutlet UILabel *Minutes;
@property (weak, nonatomic) IBOutlet UILabel *Discount;
@property (weak, nonatomic) IBOutlet UILabel *Discount_Rate;

//Sliding Mesajları
@property (nonatomic, retain)  SlideMessageViewController *msgView;


//Giriş Temizle
- (IBAction)Clear:(id)sender;

//Klavye Otomatik Kaldıran IBAction
- (IBAction)textfieldReturn:(id)sender;

//Share PopoverController
@property (nonatomic, strong) UIPopoverController *popover;

//Discount Oranı
@property (strong, nonatomic) IBOutlet UISlider *discount_slider;
- (IBAction)DiscountSliderGuncelle:(id)sender;
- (IBAction)PriceHesap:(id)sender;


@end

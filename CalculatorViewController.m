//
//  CalculatorViewController.m
//  icarstationserver
//
//  Created by durul on 03/03/14.
//  Copyright (c) 2014 durul dalkanat. All rights reserved.
//

#import "CalculatorViewController.h"
#import "SlideMessageViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "AppDelegate.h"
#import "SBTextField.h"


@interface CalculatorViewController ()
//Tip Puan Konfigurasyonu
@property (nonatomic, retain) IBOutlet SBTextField *HourlyRateTextField;
@property (nonatomic, retain) IBOutlet SBTextField *MinTextField;

@end

@implementation CalculatorViewController

@synthesize MinTextField, HourlyRateTextField;
@synthesize discount_slider,msgView;
@synthesize Minutes,Discount_Rate,Discount,HourlyRate;

#pragma mark -
#pragma mark Lifecycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Slider Configuration
    [discount_slider setMaximumValue:20];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"background.png"]];

    
    // Labels Font
    self.HourlyRate.font = [UIFont fontWithName:@"eurostile-oblique" size:15.f];
    self.Discount.font = [UIFont fontWithName:@"eurostile-oblique"  size:15.f];
    self.Discount_Rate.font = [UIFont fontWithName:@"eurostile-oblique"  size:15.f];
    self.Minutes.font = [UIFont fontWithName:@"eurostile-oblique"  size:15.f];
    
    //Textfield
    self.HourlyRateTextField.font = [UIFont fontWithName:@"eurostile-oblique"  size:15.f];
    self.MinTextField.font = [UIFont fontWithName:@"eurostile-oblique"  size:15.f];
    
    
    //Textfield karakter kontrol
	HourlyRateTextField.maxLength = 100;
	MinTextField.maxLength = 5;


    
}

#pragma mark Puan Hesaplama
// Puan Oranını Değiştiriyor.
- (IBAction)DiscountSliderGuncelle:(id)sender{
    NSString *currentPuanString = [[NSString alloc] initWithFormat:@"%1.2f%%", [discount_slider value]];
    
    [Discount_Rate setText:currentPuanString];
}


// Puan Oranını hesaplıyor
- (IBAction)PriceHesap:(id)sender {
	
    NSString *userinput =[HourlyRateTextField text];
    NSString *userinput2 =[MinTextField text];

    
    if ([userinput length] == 0) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You didn't Enter Hourly Rate" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else if  ([userinput2 length] == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You didn't Enter Minutes" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
    
        float HourlyRate_input = [userinput floatValue];
        float Minutes_input = [userinput2 floatValue];
        float park_price = (HourlyRate_input * Minutes_input);
        float disc_park_price = park_price * [discount_slider value] /100 - park_price;
        
        
        NSString *total_bill = [[NSString alloc] initWithFormat:@"%1.2f",disc_park_price];
    
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      
            NSString *message1 = [[NSString alloc] initWithFormat:@"Total Bill, %@", total_bill];
            
            SlideMessageViewController *msgVC = [[SlideMessageViewController alloc]
                                                 initWithDirection:kSlideLeft
                                                 header:@"Total Bill"
                                                 message:message1];
            
            [self.view addSubview:msgVC];
            
            // Show the message for x seconds
            [msgVC showMsgWithDelay:5];

        }else {
            NSString *message2 = [[NSString alloc] initWithFormat:@"Total Bill, %@", total_bill];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Total Bill" message:message2 preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];

        }
        
    }
    
}

#pragma mark Text field delegate

- (IBAction)textfieldReturn:(id)sender {
    [HourlyRateTextField resignFirstResponder];
    [MinTextField resignFirstResponder];
}

// Girişleri temizliyor.
- (IBAction)Clear:(id)sender {
    
    // TextField 'lar resetliyor.
    [HourlyRateTextField setText:@""];
    [MinTextField setText:@""];
    
    //Slider'ları resetliyor.
    
    [discount_slider setValue:0.0 animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [HourlyRateTextField resignFirstResponder];
    [MinTextField resignFirstResponder];
    return YES;
}

#pragma mark - View lifecycle
- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setMinTextField:nil];
    [self setHourlyRateTextField:nil];
    [self setDiscount_slider:nil];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


//Hafıza Problemi Yaşanırsa Uyarı Vericek
- (void)didReceiveMemoryWarning
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:NSLocalizedString(@"Memory Problem", @"Hafıza Problemi")
                                          message:NSLocalizedString(@"Please Close Some Applications!", @"Bazi uygulamalarinizi kapatin")
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}



#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void) viewDidAppear:(BOOL)animated
{
    [self.view becomeFirstResponder];
    [super viewDidAppear:animated];
}

@end

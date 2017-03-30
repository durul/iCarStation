//
//  BaseViewController.m
//  RaisedCenterTabBar
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "PersonDetailTVC.h"
#import "RoleDetailTVC.h"
#import "Person.h"
#import "Role.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MYIntroductionPanel.h"

@interface BaseViewController () <UIAccelerometerDelegate, UIActionSheetDelegate> {
    
        IBOutlet UILabel *lblTimer_Lbl, *lblTitle_Lbl;
        
        int timeSettings;
        bool autoStart;
        NSTimer *secTimer;
    
}
@property(nonatomic, strong) BaseViewController * baseViewController;

@end

@implementation BaseViewController

 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"hasSeenTutorial"])
    {
        [self buildIntro];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasSeenTutorial"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

// Create a view controller and setup it's tab bar item with a title and image
-(UIViewController*) viewControllerWithTabTitle:(NSString*) title image:(UIImage*)image
{
    UIViewController* viewController = [[UIViewController alloc] init];
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:0];
    return viewController;
}

// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithOptions:(NSDictionary *)options {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        UIImage *buttonImage = [UIImage imageNamed:options[@"buttonImage"]];
        UIImage *highlightImage = [UIImage imageNamed:options[@"highlightImage"]];
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        UITabBarItem *item = [self.tabBar.items objectAtIndex:0];
        item.enabled = YES;
        
        button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
        [button setImage:buttonImage forState:UIControlStateNormal];
        [button setImage:highlightImage forState:UIControlStateHighlighted];
        [button setContentMode:UIViewContentModeCenter];
        [button addTarget:self action:@selector(centerItemTapped) forControlEvents:UIControlEventTouchUpInside];
        
        CGSize tabbarSize = self.tabBar.bounds.size;
        CGPoint center = CGPointMake(tabbarSize.width/2, tabbarSize.height/2);
        center.y = center.y - 9.5;
        button.center = center;
        
        [self.tabBar addSubview:button];

    }else {
    
        UIImage *buttonImage = [UIImage imageNamed:options[@"buttonImage"]];
        UIImage *highlightImage = [UIImage imageNamed:options[@"highlightImage"]];
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        UITabBarItem *item = [self.tabBar.items objectAtIndex:2];
        item.enabled = NO;
        
        button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
        [button setImage:buttonImage forState:UIControlStateNormal];
        [button setImage:highlightImage forState:UIControlStateHighlighted];
        [button setContentMode:UIViewContentModeCenter];
        [button addTarget:self action:@selector(centerItemTapped) forControlEvents:UIControlEventTouchUpInside];
        
        CGSize tabbarSize = self.tabBar.bounds.size;
        CGPoint center = CGPointMake(tabbarSize.width/2, tabbarSize.height/2);
        center.y = center.y - 9.5;
        button.center = center;
        
        [self.tabBar addSubview:button];
    }
}

- (void)centerItemTapped {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:NSLocalizedString(@"Please Update Time by Settings Page","Lütfen ayarlar sayfasını güncelleyin.")
                                          message:[NSString stringWithFormat:NSLocalizedString(@"Park Time Schedule Start","Park Zaman Çizelgesi Başlangıç")]
                                          preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"\u2705 YES", @"\u2705 EVET") style:
                                UIAlertActionStyleDefault handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"\u26A0 NO", @"\u26A0 HAYIR") style:
                                UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	timeSettings = [[settings objectForKey:@"timeSettings"] intValue];
	autoStart = [[settings objectForKey:@"autoStart"] boolValue];
	
	//NSLog(@"timeSettings: %d autoStart: %d", timeSettings, autoStart);
	
	
	timeSettings *= 1;
	[lblTimer_Lbl setText:@"Timer"];
	if (autoStart)
    secTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(oneSecond:) userInfo:nil repeats:YES];
}

-(void)oneSecond:(NSTimer*)timer;
{
	timeSettings--;
	if (timeSettings > -1)
		[lblTimer_Lbl setText:[NSString stringWithFormat:@"%d:%02d", timeSettings/60, timeSettings%60]];
	else
	{
		[secTimer invalidate];
		secTimer = nil;
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Hello"
                                              message:[NSString stringWithFormat:NSLocalizedString(@"Park Time Scheduled End","Park Zaman Çizelgesi Bitti")]
                                              preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (0 == buttonIndex)
	{
		[lblTimer_Lbl setText:@"Timer"];
		NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
        
		timeSettings = [[settings objectForKey:@"timeSettings"] intValue];
		timeSettings *= 1;
        
		if (!secTimer)
			secTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self selector:@selector(oneSecond:) userInfo:nil repeats:YES];
	}

}

#pragma mark - Build MYBlurIntroductionView

-(void)buildIntro{
    
    //Create Stock Panel with header
    UIView *headerView1 = [[NSBundle mainBundle] loadNibNamed:@"TestHeader" owner:nil options:nil][0];
    MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:NSLocalizedString(@"Welcome to iCarStation","iCarStation'a Hoşgeldiniz") description:NSLocalizedString(@"iCarStation will always remember Where you left the car parked. When You left you car at the anywhere. iCarStation saves the position, zone, block.", "iCarStation aracınızı nereye park ettiğiniz daima hatırlayacaktır. Aracınız nereye parak ederseniz edin, yerini kayıt edebileceksiniz.") image:[UIImage imageNamed:@"HeaderImage.png"]header:headerView1];
    
    UIView *headerView2 = [[NSBundle mainBundle] loadNibNamed:@"TestHeader" owner:nil options:nil][0];
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:NSLocalizedString(@"Parking Time","Park Süresi") description:NSLocalizedString(@"If paid parking time. Define the amount of time to implement. The application will notify you when the time expires automatically.", "Park süresini uygulmaya girebilirisiniz. Park süreniz dolduğunda iCarStation sürenin dolduğunu hatırlatacaktır.") image:[UIImage imageNamed:@"ForkImage.png"]header:headerView2];
    
    UIView *headerView3 = [[NSBundle mainBundle] loadNibNamed:@"TestHeader" owner:nil options:nil][0];
    MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:NSLocalizedString(@"Features","Özellikler") description:NSLocalizedString(@"Save your parked car at the carpark or street. Locate your current position using your devices location services (GPS, etc.), Save your position with one click of a button, Save your rating of customer", "Otopark ya da sokakta park edilmiş araç kaydedin. Cihazlarınızın konum servisleri (GPS, vb) kullanarak mevcut konumunuzu bulun, bir düğmeye tek bir tıklama ile konumunu kaydedin, müşteri puanınızı kaydet") image:[UIImage imageNamed:@"CheckMarkWhite.png"]header:headerView3];
    
    
    UIView *headerView4= [[NSBundle mainBundle] loadNibNamed:@"TestHeader" owner:nil options:nil][0];
    MYIntroductionPanel *panel4 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:NSLocalizedString(@"Features","Özellikler") description: NSLocalizedString(@"Save a typed picture about the location of your car, Search functions, Recall your last locations where you parked your car and Map directions from your current location to any previously saved location.!" , "Aracınızı park ettiğiniz yerin fotoğrafını çekebilir, Parkyerindeki araçların listesinde plakaya göre arama yapabilir, en son park ettiğiniz yeri kayıt edebilir. Harita üzerinde aracı park ettiğiniz yerin rotasına erişebilirsiniz.") image:[UIImage imageNamed:@"PicImage.png"]header:headerView4];
    
    //Add panels to an array
    NSArray *panels = @[panel1, panel2, panel3, panel4];
    
    //Create the introduction view and set its delegate
    MYBlurIntroductionView *introductionView = [[MYBlurIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
 
    introductionView.delegate = self;
    //introductionView.BackgroundImageView.image = [UIImage imageNamed:@"Newyork.jpg"];
    [introductionView setBackgroundColor:[UIColor orangeColor]];
    
    introductionView.LanguageDirection = MYLanguageDirectionLeftToRight;

    
    //Build the introduction with desired panels
    [introductionView buildIntroductionWithPanels:panels];
    
    //Add the introduction to your view
    [self.view addSubview:introductionView];

}

#pragma mark - MYIntroduction Delegate

-(void)introduction:(MYBlurIntroductionView *)introductionView didChangeToPanel:(MYIntroductionPanel *)panel withIndex:(NSInteger)panelIndex{
    //NSLog(@"Introduction did change to panel %d", panelIndex);
    
    //You can edit introduction view properties right from the delegate method!
    //If it is the first panel, change the color to green!
    if (panelIndex == 0) {
        [introductionView setBackgroundColor:[UIColor orangeColor]];
    }
    //If it is the second panel, change the color to blue!
    else if (panelIndex == 1){
        [introductionView setBackgroundColor:[UIColor orangeColor]];
    }
    else if (panelIndex == 2){
        [introductionView setBackgroundColor:[UIColor orangeColor]];
    }
    
}

-(void)introduction:(MYBlurIntroductionView *)introductionView didFinishWithType:(MYFinishType)finishType {
    // NSLog(@"Introduction did finish");
}

@end

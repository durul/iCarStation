//
//  AppDelegate.m
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import "AppDelegate.h"
#import "PersonsTVC.h"
#import "RolesTVC.h"
#import "ADVTheme.h"
#import "iVersion.h"
#import "iRate.h"
#import "Flurry.h"
#import "Harpy.h"
#import "ShareFriend.h"
#import <Optimizely/Optimizely.h>
#import "Branch.h"

@interface AppDelegate ()

- (void)customizeIPhone;
- (void)customizeIPad;

@end

static AppDelegate *sharedDelegate;

@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize fetchedResultsController = __fetchedResultsController;

- (void)insertRoleWithRoleName:(NSString *)roleName
{
    Role *role = [NSEntityDescription insertNewObjectForEntityForName:@"Role"
                                               inManagedObjectContext:self.managedObjectContext];
    
    role.name = roleName;
    
    [self.managedObjectContext save:nil];
}


- (void)insertRoleWithRoleCheckout:(NSString *)roleCheckout
{
    Role *checkout = [NSEntityDescription insertNewObjectForEntityForName:@"Role"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    checkout.checkout = roleCheckout;
    
    [self.managedObjectContext save:nil];
}

- (void)insertRoleWithRoleRating:(NSInteger *)roleRating
{
    Role *rating = [NSEntityDescription insertNewObjectForEntityForName:@"Role"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    rating.rating = *(roleRating);
    
    
    [self.managedObjectContext save:nil];
}


- (void)setupFetchedResultsController
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"Role"; // Put your entity name here
    //NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    [request setFetchLimit:100];
    
    // 3 - Filter it if you want
    //request.predicate = [NSPredicate predicateWithFormat:@"Person.name = Blah"];
    
    // 4 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    [self.fetchedResultsController performFetch:nil];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // ShareFriend  Yükle
    // Used for debug. Normally, the bundle id will automatically be used
    [ShareFriend sharedInstance].appStoreID = @"ENTER YOUR ID";
    
    // Register for push notifications   
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }

    
    // timeSettings
    //***********************************************************************************************
	NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	NSObject *timeSettings = [settings objectForKey:@"timeSettings"];
	
	if (nil == timeSettings)
	{
		NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"60" forKey:@"timeSettings"];
		[settings registerDefaults:appDefaults];
		[settings synchronize];
	}


    // ADVThemeManager
    [ADVThemeManager customizeAppAppearance];

    
    [self setupFetchedResultsController];
    
    if (!([[self.fetchedResultsController fetchedObjects] count] > 0) ) {
        //NSLog(@"!!!!! ~~> There's nothing in the database so defaults will be inserted");
    }
    else {
        //NSLog(@"There's stuff in the database so skipping the import of default data");
    }
    
    // TAB BAR
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
       // NSLog(@"I'm an iPad");
        
        [self customizeIPhone];
        
        
        UIImage* tabBarBackground = [UIImage tallImageNamed:@"tabbar.png"];
        [[UITabBar appearance] setBackgroundImage:tabBarBackground];
        [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
        [[UITabBar appearance] setSelectionIndicatorImage:[UIImage tallImageNamed:@"tabBarSelectionIndicator_ipad.png"]];
        
        
        // The Two Navigation Controllers attached to the Tab Bar (At Tab Bar Indexes 0 and 1)
        UINavigationController *personsTVCnav = [[tabBarController viewControllers] objectAtIndex:0];
        UINavigationController *rolesTVCnav = [[tabBarController viewControllers] objectAtIndex:1];
        
        // The Persons Table View Controller (First Nav Controller Index 0)
        PersonsTVC *personsTVC = [[personsTVCnav viewControllers] objectAtIndex:0];
        personsTVC.managedObjectContext = self.managedObjectContext;
        
        // The Roles Table View Controller (Second Nav Controller Index 0)
        RolesTVC *rolesTVC = [[rolesTVCnav viewControllers] objectAtIndex:0];
        rolesTVC.managedObjectContext = self.managedObjectContext;
        
    }
    else
    {
       // NSLog(@"I'm an iPhone or iPod Touch");
        
        [self customizeIPhone];
                
        UIImage* tabBarBackground = [UIImage tallImageNamed:@"tabBarBackground.png"];
        [[UITabBar appearance] setBackgroundImage:tabBarBackground];
        [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
        [[UITabBar appearance] setSelectionIndicatorImage:[UIImage tallImageNamed:@"tabBarSelectionIndicator.png"]];
        
        // The Two Navigation Controllers attached to the Tab Bar (At Tab Bar Indexes 0 and 1)
        UINavigationController *personsTVCnav = [[tabBarController viewControllers] objectAtIndex:0];
        UINavigationController *rolesTVCnav = [[tabBarController viewControllers] objectAtIndex:1];
        
        // The Persons Table View Controller (First Nav Controller Index 0)
        PersonsTVC *personsTVC = [[personsTVCnav viewControllers] objectAtIndex:0];
        personsTVC.managedObjectContext = self.managedObjectContext;
        
        // The Roles Table View Controller (Second Nav Controller Index 0)
        RolesTVC *rolesTVC = [[rolesTVCnav viewControllers] objectAtIndex:0];
        rolesTVC.managedObjectContext = self.managedObjectContext;
    }
    
    
    //***********************************************************************************************
    // Harpy Konfigurasyon Uygulama Versiyon Kontrol
    // Set the App ID for your app
	[[Harpy sharedInstance] setAppID:@"<ENTER YOUR NUMBER>"];
	
	/* (Optional) Set the Alert Type for your app
	 By default, the Singleton is initialized to HarpyAlertTypeOption */
	//[[Harpy sharedInstance] setAlertType:<alert_type>];
	
	/* (Optional) If your application is not availabe in the U.S. Store, you must specify the two-letter
	 country code for the region in which your applicaiton is available in. */
	[[Harpy sharedInstance] setCountryCode:@"<TR>"];
	
	// Perform check for new version of your app
	[[Harpy sharedInstance] checkVersion];
    
    
    
    // Flurry raporlama kodu.
    [Flurry startSession:@"J7VWZ6GDN2FHVVBYSH6F"];
    
    
    //iCloud Konfigurasyonu
    NSURL *icloudUrl=[[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    
    if(icloudUrl){
           // NSLog(@"icloud access at %@",icloudUrl);
    }
    
    else {
            //NSLog(@"icloud access")
        ;
    }
    
    //Category on NSError that stores the stack trace of the creation of the NSError object for later retrieval.
    //NSError *sampleError = [NSError errorWithDomain:NSCocoaErrorDomain code:1337 userInfo:nil];
    //NSLog(@"Error creation stack trace: %@", sampleError.js_stackTrace);

     // Below are instructions for initial setup, lines marked as optional
    // are options, lines marked as required are required
    // Throughout the code, you can search for [OPTIMIZELY] to find reference code
    // related to Optimizely
    // All lines that say [OPTIMIZELY] (REQUIRED) are necessary for you to
    // get started!
    
    // [OPTIMIZELY] (OPTIONAL) Add this line of code to debug issues.  Please note that this line of code
    // should not be included when your app is in production
    [Optimizely sharedInstance].verboseLogging = YES;
    
    // [OPTIMIZELY] (OPTIONAL) Add this line of code if you would like to enable "Edit Mode" in your live app
    // Please note that adding this line will allow anyone to edit your app with
    // Optimizely in the app store
    [Optimizely enableGestureInAppStoreApp];
    
    // [OPTIMIZELY] (OPTIONAL) Customize network call timing (By default network calls are made every 2 minutes)
    // [Optimizely sharedInstance].dispatchInterval = 120;
    
    // [OPTIMIZELY] (REQUIRED) Replace this line with your API token, and don't forget to go to
    // your target (i.e. the blue icon at the top that says TutorialApp) > Info > URL Types
    // Paste your Project ID there (e.g. it should look like optly123456, replace 123456 with your project id)
    // Replace @"AAMseu0A6cJKXYL7RiH_TgxkvTRMOCvS~123456" with your API Token from your Optimizely Dashboard
    // optimizely.com/dashboard
    [Optimizely startOptimizelyWithAPIToken:@"ENTER YOUR NUMBER"launchOptions:launchOptions];
    

    Branch *branch = [Branch getInstance];
    [branch initSessionWithLaunchOptions:launchOptions andRegisterDeepLinkHandler:^(NSDictionary *params, NSError *error) {
        // params are the deep linked params associated with the link that the user clicked before showing up.
        NSLog(@"deep link data: %@", [params description]);
    }];
    
    if (launchOptions[@"UIApplicationLaunchOptionsShortcutItemKey"] == nil) {
        return YES;
    } else {
        return NO;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - Parse Push Notifications
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Handle an interruption during the authorization flow, such as the user clicking the home button.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];


        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        /*
         Perform daily check for new version of your app
         Useful if user returns to you app from background after extended period of time
         Place in applicationDidBecomeActive:
         
         Also, performs version check on first launch.
         */
        [[Harpy sharedInstance] checkVersionDaily];
        
        /*
         Perform weekly check for new version of your app
         Useful if you user returns to your app from background after extended period of time
         Place in applicationDidBecomeActive:
         
         Also, performs version check on first launch.
         */
        [[Harpy sharedInstance] checkVersionWeekly];
    
    }

#pragma mark -
#pragma mark Template code
+ (AppDelegate *)sharedDelegate {
    if (!sharedDelegate) {
        sharedDelegate = [[UIApplication sharedApplication] delegate];
    }
    
    return sharedDelegate;
}

- (void)customizeIPhone {
    UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
    
    NSArray *items = tabVC.tabBar.items;
    for (int idx = 0; idx < items.count; idx++) {
        UITabBarItem *item = items[idx];
        [ADVThemeManager customizeTabBarItem:item forTab:((SSThemeTab)idx)];
    }
}

- (void)customizeIPad {
    UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
    
    NSArray *items = tabVC.tabBar.items;
    for (int idx = 1; idx < items.count; idx++) {
        UITabBarItem *item = items[idx];
        [ADVThemeManager customizeTabBarItem:item forTab:((SSThemeTab)idx)];
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
         //   NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
/*- (NSManagedObjectContext *)managedObjectContext
 {
 if (__managedObjectContext != nil)
 {
 return __managedObjectContext;
 }
 
 NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
 if (coordinator != nil)
 {
 __managedObjectContext = [[NSManagedObjectContext alloc] init];
 [__managedObjectContext setPersistentStoreCoordinator:coordinator];
 }
 return __managedObjectContext;
 }*/

- (NSManagedObjectContext *)managedObjectContext {
	
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        NSManagedObjectContext* moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        [moc performBlockAndWait:^{
            [moc setPersistentStoreCoordinator: coordinator];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mergeChangesFrom_iCloud:) name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:coordinator];
        }];
        __managedObjectContext = moc;
    }
    
    return __managedObjectContext;
}

- (void)mergeChangesFrom_iCloud:(NSNotification *)notification {
    
	//NSLog(@"Merging in changes from iCloud...");
    
    NSManagedObjectContext* moc = [self managedObjectContext];
    
    [moc performBlock:^{
        
        [moc mergeChangesFromContextDidSaveNotification:notification];
        
        NSNotification* refreshNotification = [NSNotification notificationWithName:@"SomethingChanged"
                                                                            object:self
                                                                          userInfo:[notification userInfo]];
        
        [[NSNotificationCenter defaultCenter] postNotification:refreshNotification];
    }];
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if((__persistentStoreCoordinator != nil)) {
        return __persistentStoreCoordinator;
    }
    
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    NSPersistentStoreCoordinator *psc = __persistentStoreCoordinator;
    
    // Set up iCloud in another thread:
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // ** Note: if you adapt this code for your own use, you MUST change this variable:
        NSString *iCloudEnabledAppID = @"8C8G8G6335.com.durul.icarstationserver";
        
        // ** Note: if you adapt this code for your own use, you should change this variable:
        NSString *dataFileName = @"StaffManager.sqlite";
        
        // ** Note: For basic usage you shouldn't need to change anything else
        
        NSString *iCloudDataDirectoryName = @"Data.nosync";
        NSString *iCloudLogsDirectoryName = @"Logs";
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *localStore = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:dataFileName];
        NSURL *iCloud = [fileManager URLForUbiquityContainerIdentifier:nil];
        
        if (iCloud) {
            
            //NSLog(@"iCloud is working");
            
            NSURL *iCloudLogsPath = [NSURL fileURLWithPath:[[iCloud path] stringByAppendingPathComponent:iCloudLogsDirectoryName]];
            
            //NSLog(@"iCloudEnabledAppID = %@",iCloudEnabledAppID);
            //NSLog(@"dataFileName = %@", dataFileName);
            //NSLog(@"iCloudDataDirectoryName = %@", iCloudDataDirectoryName);
            //NSLog(@"iCloudLogsDirectoryName = %@", iCloudLogsDirectoryName);
            //NSLog(@"iCloud = %@", iCloud);
            //NSLog(@"iCloudLogsPath = %@", iCloudLogsPath);
            
            if([fileManager fileExistsAtPath:[[iCloud path] stringByAppendingPathComponent:iCloudDataDirectoryName]] == NO) {
                NSError *fileSystemError;
                [fileManager createDirectoryAtPath:[[iCloud path] stringByAppendingPathComponent:iCloudDataDirectoryName]
                       withIntermediateDirectories:YES
                                        attributes:nil
                                             error:&fileSystemError];
                if(fileSystemError != nil) {
                  //  NSLog(@"Error creating database directory %@", fileSystemError);
                }
            }
            
            NSString *iCloudData = [[[iCloud path]
                                     stringByAppendingPathComponent:iCloudDataDirectoryName]
                                    stringByAppendingPathComponent:dataFileName];
            
            //NSLog(@"iCloudData = %@", iCloudData);
            
            NSMutableDictionary *options = [NSMutableDictionary dictionary];
            [options setObject:[NSNumber numberWithBool:YES] forKey:NSMigratePersistentStoresAutomaticallyOption];
            [options setObject:[NSNumber numberWithBool:YES] forKey:NSInferMappingModelAutomaticallyOption];
            [options setObject:iCloudEnabledAppID            forKey:NSPersistentStoreUbiquitousContentNameKey];
            [options setObject:iCloudLogsPath                forKey:NSPersistentStoreUbiquitousContentURLKey];
            
            [psc lock];
            
            [psc addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:[NSURL fileURLWithPath:iCloudData]
                                    options:options
                                      error:nil];
            
            [psc unlock];
        }
        else {
            //NSLog(@"iCloud is NOT working - using a local store");
            NSMutableDictionary *options = [NSMutableDictionary dictionary];
            [options setObject:[NSNumber numberWithBool:YES] forKey:NSMigratePersistentStoresAutomaticallyOption];
            [options setObject:[NSNumber numberWithBool:YES] forKey:NSInferMappingModelAutomaticallyOption];
            
            [psc lock];
            
            [psc addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:localStore
                                    options:options
                                      error:nil];
            [psc unlock];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SomethingChanged" object:self userInfo:nil];
        });
    });
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - transform your current geo-location to desired geo-location during iOS application development


// Method that fetches latitude offset value from the setting and apply on the latitude.
- (double)applyLatitudeOffset:(double) latitude {
	double latitudeOffset = 0.0;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults objectForKey:@"LatOffset"] == nil) {
		return latitude;
	}
    
	if ([[defaults objectForKey:@"LatOffset"] length] == 0) {
		return latitude;
	}
    
	latitudeOffset = [[defaults objectForKey:@"LatOffset"] doubleValue];
	double newLatitude;
	newLatitude = latitude + latitudeOffset;
	return newLatitude;
}

// Method that fetches longitude offset value from the setting and apply on the longitude value.

- (double)applyLongitudeOffset:(double) longitude {
	double longitudeOffset = 0.0;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
	if ([defaults objectForKey:@"LongOffset"] == nil) {
		return longitude;
	}
    
	if ([[defaults objectForKey:@"LongOffset"] length] == 0) {
		return longitude;
	}
    
	longitudeOffset = [[defaults objectForKey:@"LongOffset"] doubleValue];
	double newLongitude;
	newLongitude = longitude + longitudeOffset;
	return newLongitude;
}


#pragma mark -
#pragma mark Application lifecycle

+ (void)initialize
{
    
    //set the app and bundle ID. normally you wouldn't need to do this
    //but we need to test with an app that's actually on the store
	[iRate sharedInstance].appStoreID = @"ENTER YOUR NUMBER";
    [iRate sharedInstance].applicationBundleID = @"ENTER YOUR ID";
    // provisioning portalda daha önce oluşturduğunuz Bundle Identifier (App ID Suffix)
    
    //enable debug mode
    //[iRate sharedInstance].debug = YES;
    
    //Kullanıcı uygulamızı yükledikten kaç gün sonra iRate bizim için oy isteyecek.
    [iRate sharedInstance].daysUntilPrompt = 5;
    [iRate sharedInstance].usesUntilPrompt = 15;
    
    
    //enable preview mode
    //[iRate sharedInstance].previewMode = YES;
    //Test uygulamasında çalıştığımız için 5 gün beklemeyeceğiz ve iRate hemen çalışacak. Uygulamanızı submit etmeden önce bu satırı SİLMEYİ unutma !!!!!
    
    //set the bundle ID. normally you wouldn't need to do this
    //as it is picked up automatically from your Info.plist file
    //but we want to test with an app that's actually on the store
    [iVersion sharedInstance].applicationBundleID = @"ENTER YOUR ID";
    
    //configure iVersion. These paths are optional - if you don't set
    //them, iVersion will just get the release notes from iTunes directly (if your app is on the store)
    [iVersion sharedInstance].remoteVersionsPlistURL = @"ENTER YOUR URL";
    [iVersion sharedInstance].localVersionsPlistPath = @"versions.plist";
}

#pragma mark -
#pragma mark OPTIMIZELY

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    if ([[Branch getInstance] handleDeepLink:url]) {
        return YES;
    }
    
    // [OPTIMIZELY] (REQUIRED) Be sure to add this entire method.
    // If you use other tools such as AdX, you will need to make sure that
    // Optimizely's handleOpenURL is called first.  This allows you to connect
    // the app with Optimizely's editor.
    if ([Optimizely handleOpenURL:url]) {
        return YES;
    }
    
    // Other implementations (e.g. AdX) would start here
    
    return NO;
}



@end

//
//  PersonDetailTVC.m
//  Staff Manager
//
//  Created by Durul Dalkanat on 14/02/12.
//  Copyright (c) 2012 Durul Dalkanat. All rights reserved.
//

#import "PersonDetailTVC.h"
#import "ADVTheme.h"
#import "SBTextField.h"
#import <QuartzCore/QuartzCore.h>
#import <PassSlot/PassSlot.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <AddressBook/AddressBook.h>
#import "M2DHudView.h"
#import "IQDropDownTextField.h"

@interface PersonDetailTVC () {
    NSInteger _lastSelectedIndex;
    NSMutableArray *objects;
}

@property (strong, nonatomic) IBOutlet SBTextField *personFirstnameTextField;
@property (strong, nonatomic) IBOutlet SBTextField *personSurnameTextField;
@property (strong, nonatomic) IBOutlet IQDropDownTextField *blocksTextField;
@property (nonatomic, assign) ABAddressBookRef addressBook;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@end


@implementation PersonDetailTVC
@synthesize delegate;
@synthesize person = _person;
@synthesize selectedRole;
@synthesize personFirstnameTextField = _personFirstnameTextField;
@synthesize personSurnameTextField = _personSurnameTextField;
@synthesize blocksTextField = _blocksTextField;
@synthesize personRoleTableViewCell = _personRoleTableViewCell;
@synthesize imagePicker, imageField,currentPicture;
@synthesize managedObjectContext;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    objects = [[NSMutableArray alloc]init];
    
    if(self){
        for (int i=1; i<100; i++) {
            NSString *str = [NSString stringWithFormat:@"This is the fabulous Row %d",i];
            [objects addObject:str];
        }
    }
    return self;
}

//This function is where all the magic happens
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //!!!FIX for issue #1 Cell position wrong------------
    if(cell.layer.position.x != 0){
        cell.layer.position = CGPointMake(0, cell.layer.position.y);
    }
    
    //4. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}


//Helper function to get a random float
- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageField.reflectionScale = 3.5f;
    imageField.reflectionScale = 0.5f;
    imageField.reflectionAlpha = 0.25f;
    imageField.reflectionGap = 10.0f;
    imageField.shadowOffset = CGSizeMake(0.0f, 2.0f);
    imageField.shadowBlur = 5.0f;
    imageField.cornerRadius = 10.0f;
    imageField.customEffectsBlock = ^(UIImage *image){
    
        
//create drawing context
            UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
        
            //draw image
            [image drawAtPoint:CGPointZero];
            
            //capture resultant image
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            //return image
            return image;
        };

    // If we are editing an existing picture, then put the details from Core Data into the text fields for displaying
    if (currentPicture)
    {
        if ([currentPicture smallPicture])
            [imageField setImage:self.person.smallPicture];
    }
   
    //View Controller theme
    [ADVThemeManager customizeTableView:self.tableView];
    UIImageView *imgTableFooter = [[UIImageView alloc] initWithImage:[[ADVThemeManager sharedTheme] tableFooterBackground]];
    [self.tableView setTableFooterView:imgTableFooter];
    [self.tableView reloadData];
    
	
    //Textfield karakter kontrol
	_personFirstnameTextField.maxLength = 10;
	_personSurnameTextField.maxLength = 20;
    
    //CoreData configuration;
    self.personFirstnameTextField.text = self.person.firstname;
    self.personSurnameTextField.text = self.person.surname;
    self.blocksTextField.text = self.person.blocks;

    self.personRoleTableViewCell.textLabel.text = self.person.inRole.name;
    self.personRoleTableViewCell.detailTextLabel.text = self.person.inRole.checkout;

    
    self.selectedRole = self.person.inRole; // ensure null role doesn't get saved.

    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tgr setCancelsTouchesInView:NO];
    [self.tableView addGestureRecognizer:tgr];
    
    
    [self requestAddressBookAccess];

    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    _blocksTextField.inputAccessoryView = toolbar;
    
    [_blocksTextField setItemList:[NSArray arrayWithObjects:@"Green", @"Red", @"Blue", @"Black", @"Orange", @"White", @"Yellow", nil]];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [self check3DTouch];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_personFirstnameTextField resignFirstResponder];
    [_blocksTextField resignFirstResponder];
    [_personSurnameTextField resignFirstResponder];

    return YES;
}

- (void)viewDidUnload
{
    [self setPersonFirstnameTextField:nil];
    [self setPersonSurnameTextField:nil];
    [self setBlocksTextField:nil];
    [self setPersonRoleTableViewCell:nil];
    
    [super viewDidUnload];
}

- (IBAction)save:(id)sender
{
    self.person.firstname = self.personFirstnameTextField.text; // Set Firstname
    self.person.surname = self.personSurnameTextField.text; // Set Surname
    self.person.blocks= self.blocksTextField.text; // Set Blocks
    
    [self.person setInRole:self.selectedRole]; // Set Relationship!!!
    [self.person.managedObjectContext save:nil];  // write to database
    [self.delegate theSaveButtonOnThePersonDetailTVCWasTapped:self];
    
    //  Commit item to core data
    NSError *error;
    if (![self.managedObjectContext save:&error])
        NSLog(@"error: %@", [error domain]);
    
    //  Automatically pop to previous view now we're done adding
    [self.navigationController popViewControllerAnimated:YES];

    [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber+1;
    
    //Hudview
    M2DHudView *hud = [[M2DHudView alloc] initWithStyle:M2DHudViewStyleSuccess title:nil];
	[hud showWithDuration:3];
    
}

//AddContact
-(void)sampleAddContact
{
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    ABRecordRef newPerson = ABPersonCreate();
    
    //add firstname
    ABRecordSetValue(newPerson, kABPersonFirstNameProperty, (__bridge CFTypeRef)(self.person.surname), &error);
    ABRecordSetValue(newPerson, kABPersonNoteProperty, (__bridge CFTypeRef)(self.person.firstname), &error);

    //Add the record to the address book
    ABAddressBookAddRecord(addressBook, newPerson, &error);
    //Save the changes
    ABAddressBookSave(addressBook, &error);
    if (error != NULL)
    {
        NSLog(@"error: %@", error);

    }
    CFRelease(addressBook);
}


// Prompt the user for access to their Address Book data
-(void)requestAddressBookAccess
{
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    __block BOOL accessGranted = NO;
    if (&ABAddressBookRequestAccessWithCompletion != NULL)
    {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     accessGranted = granted;
                                                     dispatch_async(dispatch_get_main_queue(),^{
                                                         accessGranted=YES;
                                                     });
                                                 });
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender  // !
{
    if ([segue.identifier isEqualToString:@"Person Role Segue"])
	{
        //NSLog(@"Setting PersonDetailTVC as a delegate of PersonRoleTVC");
        PersonRoleTVC *personRoleTVC = segue.destinationViewController;
        personRoleTVC.delegate = self;
        personRoleTVC.selectedPerson = self.person;
        
        // Hide bottom tab bar in the detail view
       // personRoleTVC.hidesBottomBarWhenPushed = YES;
	}
    else {
        NSLog(@"Unidentified Segue Attempted!");
    }
}

- (void)dismissKeyboard {
    [self.view endEditing:TRUE];
}

- (void)roleWasSelectedOnPersonRoleTVC:(PersonRoleTVC *)controller 
{
    self.personRoleTableViewCell.textLabel.text = controller.selectedRole.name;
    self.personRoleTableViewCell.detailTextLabel.text = controller.selectedRole.checkout;
    self.selectedRole = controller.selectedRole;
    
    [controller.navigationController popViewControllerAnimated:YES];
}

//  Take an image with camera
- (IBAction)imageFromCamera:(id)sender
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

//  Take an image with album
- (IBAction)imgFromCamera:(id)sender {
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:imagePicker animated:YES completion:nil];

    [self startCameraControllerFromViewController:self usingDelegate:self];
}

#pragma mark - UIImagePickerControllerDelegate methods

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller usingDelegate: (id <UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate {
	if (([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] == NO) || (controller == nil))
		return NO;
    
	UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
	imagePicker.delegate = self;
	[controller presentViewController:cameraUI animated:YES completion:nil];
	return YES;
}

//  Resign the keyboard after Done is pressed when editing text fields
- (IBAction)resignKeyboard:(id)sender
{
    [_personFirstnameTextField resignFirstResponder];
    [_personSurnameTextField resignFirstResponder];
    [_blocksTextField resignFirstResponder];
}

#pragma mark - Image Picker Delegate Methods
//  Dismiss the image picker on selection and use the resulting image in our ImageView
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    Person *event = self.person;

    [imageField setImage:image];
	// Create a thumbnail version of the image for the event object.
	CGSize size = image.size;
	CGFloat ratio = 0;
	if (size.width > size.height) {
		ratio = 84.0 / size.width;
	}
	else {
		ratio = 84.0 / size.height;
	}
	CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
	
	UIGraphicsBeginImageContext(rect.size);
	[image drawInRect:rect];
	event.smallPicture = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	// Commit the change.
	NSError *error = nil;
	if (![event.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
	}
    
	// Update the user interface appropriately.
	[self updatePhotoInfo];
    
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)updatePhotoInfo
{
	// Synchronize the photo image view and the text on the photo button with the event's photo.
	UIImage *image = self.imageField.image;
	self.imageField.image = image;
}

//  On cancel, only dismiss the picker controller
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[imagePicker presentingViewController] dismissViewControllerAnimated:YES completion:nil];    
}

-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
}

- (IBAction)addContact:(id)sender {
    [self sampleAddContact];
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    UILabel *message;
    
    if (error) {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:NSLocalizedString(@"Mail error", @"e-posta hatası")
                                              message:[error localizedDescription]
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
	}
    
	message.hidden = NO;
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			message.text = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			message.text = @"Result: failed";
			break;
		default:
			message.text = @"Result: not sent";
			break;
	}
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	NSString *body = @"&body=It !";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    NSString *result = [email stringByAddingPercentEncodingWithAllowedCharacters:set];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:result]];
}

#pragma mark -
#pragma mark Dismiss Mail view controller
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Memory Managemenet
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


#pragma mark -
#pragma mark - 3DTouch
- (void)check3DTouch {
    
    // register for 3D Touch (if available)
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
        NSLog(@"3D Touch is available! Hurra!");
        
        // no need for our alternative anymore
        self.longPress.enabled = NO;
        
    } else {
        
        NSLog(@"3D Touch is not available on this device. Sniff!");
        
        // handle a 3D Touch alternative (long gesture recognizer)
        self.longPress.enabled = YES;
        
    }
}

- (UILongPressGestureRecognizer *)longPress {
    
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(showPeek)];
        [self.view addGestureRecognizer:_longPress];
    }
    return _longPress;
}

@end



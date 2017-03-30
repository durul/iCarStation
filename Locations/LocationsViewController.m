//
//  LocationsViewController.m
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import "LocationsViewController.h"
#import "LocationsCell.h"
#import "ADVTheme.h"
#import <QuartzCore/QuartzCore.h>

@interface LocationsViewController (){
   
    NSMutableArray *objects2;
    CLLocationCoordinate2D lastCoords;
    BOOL haveCoords;

}

@end

@implementation LocationsViewController
@synthesize locationsTableView, locationsData, items;
@synthesize message;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    objects2 = [[NSMutableArray alloc]init];
    
    if(self){
        for (int i=1; i<100; i++) {
            NSString *str = [NSString stringWithFormat:@"This is the fabulous Row %d",i];
            [objects2 addObject:str];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    items = [[NSMutableArray alloc] init];
    
    [self readData];
    
    [ADVThemeManager customizeTableView:self.locationsTableView];
    
    UIImageView *imgTableFooter = [[UIImageView alloc] initWithImage:[[ADVThemeManager sharedTheme] tableFooterBackground]];
    [self.locationsTableView setTableFooterView:imgTableFooter];
    [self.locationsTableView reloadData];
 
}

- (void)readData {
    
    NSString *locData = [NSString stringWithContentsOfFile:[self filePath] encoding:NSUTF8StringEncoding error:nil];
    
    NSMutableArray *locArray = [[NSMutableArray alloc] initWithArray:[locData componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];
    
    [locArray removeLastObject];
    
    for (NSString *objects in locArray) {
        
        NSString *title = [[objects componentsSeparatedByString:@"|"] objectAtIndex:0];
        NSString *latitude = [[objects componentsSeparatedByString:@"|"] objectAtIndex:1];
        NSString *longitude = [[objects componentsSeparatedByString:@"|"] objectAtIndex:2];
        
        LocationsData *theLocData = [[LocationsData alloc] init];
        theLocData.title = title;
        theLocData.latitude = latitude;
        theLocData.longitude = longitude;
        
        [items addObject:theLocData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"LocCell";
    
    LocationsCell *cell = (LocationsCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LocationsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    LocationsData *currentData = [items objectAtIndex:indexPath.row];    
    cell.title.text = currentData.title;
    cell.btn.tag = indexPath.row;
    cell.items = items;

    return cell;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return(YES);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        LocationsData *currentData = [items objectAtIndex:indexPath.row];
        NSString *itemToRemove = [NSString stringWithFormat:@"%@|%@|%@\n", currentData.title, currentData.latitude, currentData.longitude];
        NSString *locData = [NSString stringWithContentsOfFile:[self filePath] encoding:NSUTF8StringEncoding error:nil];
        NSString *finalData = [locData stringByReplacingOccurrencesOfString:itemToRemove withString:@""];
        [finalData writeToFile:[self filePath] atomically:NO encoding:NSUTF8StringEncoding error:nil];
        [items removeObjectAtIndex:indexPath.row];
        [locationsTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

- (void)saveLocationWithName:(NSString *)locationName longitude:(float)longitude latitude:(float)latitude {
    
    NSString *locData = [NSString stringWithContentsOfFile:[self filePath] encoding:NSUTF8StringEncoding error:nil];
    
    if (!locData) {
        locData = @"";
    }
    
    NSString *location = [NSString stringWithFormat:@"%@|%f|%f\n", locationName, latitude, longitude];
    
    [[NSString stringWithFormat:@"%@%@", locData, location] writeToFile:[self filePath] atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

- (NSString *)filePath {
    return [NSString stringWithFormat:@"%@/locations.dat", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        LocationsViewController *detailView = [segue destinationViewController];
        
        detailView.locationsData = [self.items objectAtIndex:[self.locationsTableView indexPathForSelectedRow].row];
        
    }
}


 // Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {

     return YES;
 }

- (IBAction)sendLocation:(id)sender {

    NSString *locData = [NSString stringWithContentsOfFile:[self filePath] encoding:NSUTF8StringEncoding error:nil];
    
    if (! [MFMailComposeViewController canSendMail]) {
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:NSLocalizedString(@"Can't mail", @"Postalayamıyoruz")
                                              message:NSLocalizedString(@"This device is not able to send e-mail", "Bu Cihazdan, E-posta Göndermek Mümkün Değil")
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
  
        return;
	}
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	[picker setSubject:@"Location Information !"];

    NSString *emailBody2 = [[NSString alloc] initWithFormat:@"Location Information:  %@ ", locData];
    [picker setMessageBody:emailBody2 isHTML:NO];
    
    [self presentViewController:picker animated:YES completion:nil];
    
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    if (error) {

        UIAlertController *cantMailAlert = [UIAlertController
                                            alertControllerWithTitle:NSLocalizedString(@"Mail error", @"e-posta hatası")
                                            message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        [cantMailAlert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:cantMailAlert animated:YES completion:nil];

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

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Location support

- (void) displayLocation:(CLLocationCoordinate2D)here {
	lastCoords.latitude = here.latitude;
	lastCoords.longitude = here.longitude;
	haveCoords = YES;
	[self messageLine:[NSString stringWithFormat:@"%.5f by %.5f", here.latitude, here.longitude]];
}

#pragma mark -
#pragma mark messageString support

- (void) messageString: (NSString *) string {
	//_textView.text = [_textView.text stringByAppendingString:string];
}

- (void) clearMessageString {
	//_textView.text = @"";
}

- (void) scrollToEnd {
	//[_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 0)];
}

- (void) messageLine: (NSString *) string {
	[self messageString:string];
	[self messageString:@"\n"];
	[self scrollToEnd];
}

#pragma mark - View lifecycle

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

@end

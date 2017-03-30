//
//  MYCustomPanel.h
//  icarstationserver
//
//  Created by durul dalkanat on 7/28/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import "MYIntroductionPanel.h"

@interface MYCustomPanel : MYIntroductionPanel <UITextViewDelegate> {
    
    __weak IBOutlet UIView *CongratulationsView;
}


- (IBAction)didPressEnable:(id)sender;

@end

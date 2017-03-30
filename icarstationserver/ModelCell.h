//
//  ModelCell.h
//  icarstationserver
//
//  Created by durul dalkanat on 8/24/13.
//  Copyright (c) 2013 durul dalkanat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Role;

@interface ModelCell : UITableViewCell 
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *checkoutLbl;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImgView;
@property (weak, nonatomic) IBOutlet UILabel *zoneLbl;

@end

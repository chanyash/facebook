//
//  NodeCell.h
//  FacebookDemo
//
//  Created by Joanna Chan on 1/29/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NodeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusTypeLabel;

@end

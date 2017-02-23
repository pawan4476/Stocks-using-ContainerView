//
//  TableViewCell.h
//  StocksUsingContainerView
//
//  Created by Nagam Pawan on 11/3/16.
//  Copyright © 2016 Nagam Pawan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *stockNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastTradePriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *changeInPercentageLabel;

@end

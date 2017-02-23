//
//  DetailsViewController.h
//  StocksUsingContainerView
//
//  Created by Nagam Pawan on 11/3/16.
//  Copyright © 2016 Nagam Pawan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *openValueLabel;
@property (strong, nonatomic) NSString *stockSymbolString;
@property (strong, nonatomic) NSString *openValueString;
@property (strong, nonatomic) NSString *highValueString;
@property (strong, nonatomic) NSString *lowValueString;
@property (strong, nonatomic) NSString *volumeString;
@property (strong, nonatomic) NSString *PERatioString;
@property (strong, nonatomic) NSString *mktCapString;
@property (strong, nonatomic) NSString *yearHighString;
@property (strong, nonatomic) NSString *YearLowString;
@property (strong, nonatomic) NSString *avgVolumeString;
@property (strong, nonatomic) NSString *yieldString;
@property (strong, nonatomic) NSString *imageString;
@property (strong, nonatomic) NSString *titleString;
@property (strong,nonatomic) NSString *stockSymbolUrlString;

@end

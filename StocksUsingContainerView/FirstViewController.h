//
//  FirstViewController.h
//  StocksUsingContainerView
//
//  Created by Nagam Pawan on 11/3/16.
//  Copyright © 2016 Nagam Pawan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FirstViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSDictionary *quoteDictionary;
@property (strong, nonatomic) NSMutableArray *stockNameArray;
@property (strong, nonatomic) NSMutableArray *lastTradePriceArray;
@property (strong, nonatomic) NSMutableArray *changeInPercentageArray;
@property (strong, nonatomic) NSMutableArray *titleNameArray;

@property (strong, nonatomic) NSMutableArray *openValueArray;
@property (strong, nonatomic) NSMutableArray *highValueArray;
@property (strong, nonatomic) NSMutableArray *lowValueArray;
@property (strong, nonatomic) NSMutableArray *volumeArray;
@property (strong, nonatomic) NSMutableArray *peRatioArray;
@property (strong, nonatomic) NSMutableArray *mktCapArray;
@property (strong, nonatomic) NSMutableArray *yearHighArray;
@property (strong, nonatomic) NSMutableArray *yearLowArray;
@property (strong, nonatomic) NSMutableArray *avgVolumeArray;
@property (strong, nonatomic) NSMutableArray *yieldArray;
@property (strong, nonatomic) NSString *imsgeUrlString;
@property (strong, nonatomic) NSMutableArray *imageArray;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

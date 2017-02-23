//
//  ViewController.h
//  StocksUsingContainerView
//
//  Created by Nagam Pawan on 11/3/16.
//  Copyright © 2016 Nagam Pawan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *stocksArray;
@property (strong, nonatomic) NSMutableArray *stocksResults;
@property (strong, nonatomic) NSManagedObject *stockObject;
@property (strong, nonatomic) NSArray *jsonResults;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;


@end


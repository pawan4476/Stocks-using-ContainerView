//
//  FirstViewController.m
//  StocksUsingContainerView
//
//  Created by Nagam Pawan on 11/3/16.
//  Copyright © 2016 Nagam Pawan. All rights reserved.
//

#import "FirstViewController.h"
#import "TableViewCell.h"
#import "AppDelegate.h"
#import "DetailsViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.stockNameArray = [[NSMutableArray alloc]init];
    self.lastTradePriceArray = [[NSMutableArray alloc]init];
    self.changeInPercentageArray = [[NSMutableArray alloc]init];
    self.titleNameArray = [[NSMutableArray alloc]init];
    
    self.openValueArray = [[NSMutableArray alloc]init];
    self.highValueArray = [[NSMutableArray alloc]init];
    self.lowValueArray = [[NSMutableArray alloc]init];
    self.volumeArray = [[NSMutableArray alloc]init];
    self.peRatioArray = [[NSMutableArray alloc]init];
    self.mktCapArray = [[NSMutableArray alloc]init];
    self.yearHighArray = [[NSMutableArray alloc]init];
    self.yearLowArray = [[NSMutableArray alloc]init];
    self.avgVolumeArray = [[NSMutableArray alloc]init];
    self.yieldArray = [[NSMutableArray alloc]init];
    self.imageArray = [[NSMutableArray alloc]init];
    
    [self getsession:@"http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22YHOO%22%2C%22AAPL%22%2C%22GOOG%22%2C%22MSFT%22%2C%22CNX%22%2C%22IT%22%2C%22SBUX%22%2C%22NKE%22%2C%22DAX%22%2C%22%5EN225%22)%0A%09%09&env=http%3A%2F%2Fdatatables.org%2Falltables.env&format=json"];
    
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getsession: (NSString *)jsonUrl{
    
    [UIApplication sharedApplication]. networkActivityIndicatorVisible = YES;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:jsonUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil) {
            
            [UIApplication sharedApplication]. networkActivityIndicatorVisible = NO;
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (json) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:json];
                [defaults setObject:data forKey:@"stocks"];
                [defaults synchronize];
            }
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *data = [defaults objectForKey:@"stocks"];
            NSDictionary *json1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            self.quoteDictionary = [[[json1 valueForKey:@"query"] valueForKey:@"results"] valueForKey:@"quote"];
            NSLog(@"All the data is : %@", self.quoteDictionary);
            
            if ([[self.quoteDictionary valueForKey:@"Name"] isKindOfClass:[NSArray class]]) {
                
                self.titleNameArray = [[self.quoteDictionary valueForKey:@"Name"] mutableCopy];
                
            }
            
            else{
                
                [self.titleNameArray addObject:[self.quoteDictionary valueForKey:@"Name"]];
                
            }
            
            if ([[self.quoteDictionary valueForKey:@"Symbol"] isKindOfClass:[NSArray class]]) {
                
                self.stockNameArray = [[self.quoteDictionary valueForKey:@"Symbol"] mutableCopy];
                NSLog(@"Stock name is : %@", self.stockNameArray);
                
            }
            
            else{
                
                [self.stockNameArray addObject:[self.quoteDictionary valueForKey:@"Symbol"]];
                NSLog(@"Stock name is : %@", self.stockNameArray);
                
            }
            
            if ([[self.quoteDictionary valueForKey:@"LastTradePriceOnly"] isKindOfClass:[NSArray class]]) {
                
                self.lastTradePriceArray = [[self.quoteDictionary valueForKey:@"LastTradePriceOnly"] mutableCopy];
                NSLog(@"LastTradePrice is : %@", self.lastTradePriceArray);
                
            }
            
            else{
                
                [self.lastTradePriceArray addObject:[self.quoteDictionary valueForKey:@"LastTradePriceOnly"]];
                NSLog(@"LastTradePrice is : %@", self.lastTradePriceArray);
                
            }
            
            if ([[self.quoteDictionary valueForKey:@"ChangeinPercent"] isKindOfClass:[NSArray class]]) {
                
                self.changeInPercentageArray = [[self.quoteDictionary valueForKey:@"ChangeinPercent"] mutableCopy];
                NSLog(@"Change in percentage is : %@", self.changeInPercentageArray);
                
            }
            
            else{
                
                [self.changeInPercentageArray addObject:[self.quoteDictionary valueForKey:@"ChangeinPercent"]];
                NSLog(@"Change in percentage is : %@", self.changeInPercentageArray);
                
            }
            
            if ([[self.quoteDictionary valueForKey:@"Open"] isKindOfClass:[NSArray class]]) {
                
                self.openValueArray = [[self.quoteDictionary valueForKey:@"Open"] mutableCopy];
                NSLog(@"open Value is : %@", self.openValueArray);
                
            }
            
            else{
                
                [self.openValueArray addObject:[self.quoteDictionary valueForKey:@"Open"]];
                NSLog(@"open Value is : %@", self.openValueArray);
                
            }
            
            if ([[self.quoteDictionary valueForKey:@"DaysHigh"] isKindOfClass:[NSArray class]]) {
                
                self.highValueArray = [[self.quoteDictionary valueForKey:@"DaysHigh"] mutableCopy];
                NSLog(@"Day High is : %@", self.highValueArray);
                
            }
            
            else{
                
                [self.highValueArray addObject:[self.quoteDictionary valueForKey:@"DaysHigh"]];
                NSLog(@"Day High is: %@", self.highValueArray);
                
            }
            
            if ([[self.quoteDictionary valueForKey:@"DaysLow"] isKindOfClass:[NSArray class]]) {
                
                self.lowValueArray = [[self.quoteDictionary valueForKey:@"DaysLow"] mutableCopy];
                NSLog(@"Day Low is : %@", self.lowValueArray);
                
            }
            
            else{
                
                [self.lowValueArray addObject:[self.quoteDictionary valueForKey:@"DaysLow"]];
                NSLog(@"Day Low is: %@", self.lowValueArray);
                
            }
            
            if ([[self.quoteDictionary valueForKey:@"Volume"] isKindOfClass:[NSArray class]]) {
                
                self.volumeArray = [[self.quoteDictionary valueForKey:@"Volume"] mutableCopy];
                NSLog(@"Volume is : %@", self.volumeArray);
                
            }
            
            else{
                
                [self.volumeArray addObject:[self.quoteDictionary valueForKey:@"Volume"]];
                NSLog(@"Volume is: %@", self.volumeArray);
                
            }
            
            if ([[self.quoteDictionary valueForKey:@"PERatio"] isKindOfClass:[NSArray class]]) {
                
                self.peRatioArray = [[self.quoteDictionary valueForKey:@"PERatio"] mutableCopy];
                NSLog(@"PERatio is : %@", self.peRatioArray);
                
            }
            
            else{
                
                [self.peRatioArray addObject:[self.quoteDictionary valueForKey:@"PERatio"]];
                NSLog(@"PERatio is: %@", self.peRatioArray);
                
            }
            
            if ([[self.quoteDictionary valueForKey:@"MarketCapitalization"] isKindOfClass:[NSArray class]]) {
                
                self.mktCapArray = [[self.quoteDictionary valueForKey:@"MarketCapitalization"] mutableCopy];
                NSLog(@"MarketCapitalization is : %@", self.mktCapArray);
                
            }
            
            else{
                
                [self.mktCapArray addObject:[self.quoteDictionary valueForKey:@"MarketCapitalization"]];
                NSLog(@"MarketCapitalization is: %@", self.mktCapArray);
                
            }
            
            if ([[self.quoteDictionary valueForKey:@"YearHigh"] isKindOfClass:[NSArray class]]) {
                
                self.yearHighArray = [[self.quoteDictionary valueForKey:@"YearHigh"] mutableCopy];
                NSLog(@"YearHigh is : %@", self.yearHighArray);
                
            }
            
            else{
                
                [self.yearHighArray addObject:[self.quoteDictionary valueForKey:@"YearHigh"]];
                NSLog(@"YearHigh is: %@", self.yearHighArray);
                
            }
            
            if ([[self.quoteDictionary valueForKey:@"YearLow"] isKindOfClass:[NSArray class]]) {
                
                self.yearLowArray = [[self.quoteDictionary valueForKey:@"YearLow"] mutableCopy];
                NSLog(@"YearLow is : %@", self.yearLowArray);
                
            }
            
            else{
                
                [self.yearLowArray addObject:[self.quoteDictionary valueForKey:@"YearLow"]];
                NSLog(@"YearLow is: %@", self.yearLowArray);
                
            }
            
            if ([[self.quoteDictionary valueForKey:@"AverageDailyVolume"] isKindOfClass:[NSArray class]]) {
                
                self.avgVolumeArray = [[self.quoteDictionary valueForKey:@"AverageDailyVolume"] mutableCopy];
                NSLog(@"AverageDailyVolume is : %@", self.avgVolumeArray);
                
            }
            
            else{
                
                [self.avgVolumeArray addObject:[self.quoteDictionary valueForKey:@"AverageDailyVolume"]];
                NSLog(@"AverageDailyVolume is: %@", self.avgVolumeArray);
                
            }
            
            
            if ([[self.quoteDictionary valueForKey:@"DividendYield"] isKindOfClass:[NSArray class]]) {
                
                self.yieldArray = [[self.quoteDictionary valueForKey:@"DividendYield"] mutableCopy];
                NSLog(@"DividendYield is : %@", self.yieldArray);
                
            }
            
            else{
                
                [self.yieldArray addObject:[self.quoteDictionary valueForKey:@"DividendYield"]];
                NSLog(@"DividendYield is: %@", self.yieldArray);
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
                
            });
            
        }
    }];
    
    [dataTask resume];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.stockNameArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.stockNameLabel.text = [_stockNameArray objectAtIndex:indexPath.row];
    
    id lastTradePrice = [self.lastTradePriceArray objectAtIndex:indexPath.row];
    id changeInPercentage = [self.changeInPercentageArray objectAtIndex:indexPath.row];
    
    if ([lastTradePrice isKindOfClass:[NSNull class]]) {
        
        cell.lastTradePriceLabel.text = @"--";
        
    }
    
    else{
        
        cell.lastTradePriceLabel.text = lastTradePrice;
        
    }
    
    
    if ([changeInPercentage isKindOfClass:[NSNull class]]) {
        
        cell.changeInPercentageLabel.text = @"--";
        cell.changeInPercentageLabel.backgroundColor = [UIColor darkGrayColor];
    }
    
    else if ([changeInPercentage hasPrefix:@"+"]){
        
        cell.changeInPercentageLabel.text = changeInPercentage;
        cell.changeInPercentageLabel.backgroundColor = [UIColor greenColor];
        
    }
    
    else{
        
        cell.changeInPercentageLabel.text = changeInPercentage;
        cell.changeInPercentageLabel.backgroundColor = [UIColor redColor];
        
    }
    
    return cell;
    
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    DetailsViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
//     id openValue = [self.openValueArray objectAtIndex:indexPath.row];
//    if ([openValue isKindOfClass:[NSNull class]]) {
//        
//        vc.openValueString = @"--";
//        
//    }
//    
//    else{
//        
//        vc.openValueString = openValue;
//        
//    }
//
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
//    
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *path = [[self.tableView indexPathsForSelectedRows] objectAtIndex:0];
    if ([segue.identifier isEqualToString:@"send2"]) {
        DetailsViewController *vc = [segue destinationViewController];
        id openValue = [self.openValueArray objectAtIndex:path.row];
        if ([openValue isKindOfClass:[NSNull class]]) {
            
            vc.openValueString = @"--";
            
        }
        
        else{
            
            vc.openValueString = openValue;
            
        }


        
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





@end

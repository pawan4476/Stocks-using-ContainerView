//
//  ViewController.m
//  StocksUsingContainerView
//
//  Created by Nagam Pawan on 11/3/16.
//  Copyright © 2016 Nagam Pawan. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "TableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.stocksResults = [[NSMutableArray alloc]init];
    
    [self getSession:@"http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22YHOO%22%2C%22AAPL%22%2C%22GOOG%22%2C%22MSFT%22%2C%22CNX%22%2C%22IT%22%2C%22SBUX%22%2C%22NKE%22%2C%22DAX%22%2C%22%5EN225%22%2C%22NSE%22)%0A%09%09&env=http%3A%2F%2Fdatatables.org%2Falltables.env&format=json"];
    
     [self fetchData];
    [self.myTableView reloadData];

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSManagedObjectContext *)getContext {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    return context;

}

-(NSPersistentStoreCoordinator *)getPersistentStoreCoordinator{
    
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    NSPersistentStoreCoordinator *persistentStoreCoordinator = appDelegate.persistentContainer.persistentStoreCoordinator;
    return persistentStoreCoordinator;
    
}

-(void)fetchData{
    
    NSManagedObjectContext *context = [self getContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"StocksEntity8"];
    NSError *error = nil;
    self.stocksArray = [[NSArray alloc]initWithArray:[context executeFetchRequest:request error:&error]];
    self.stocksResults = [[NSMutableArray alloc]initWithArray:self.stocksArray];
    [self.myTableView reloadData];
    
    if (self.stocksArray.count > 0) {
        
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"StocksEntity8"];
        NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc]initWithFetchRequest:request];
        NSError *deleteError = nil;
        [[self getPersistentStoreCoordinator] executeRequest:delete withContext:context error:&deleteError];
        [self.myTableView reloadData];
        
    }
    
}

-(void)getSession:(NSString *)jsonUrl{
    
    NSManagedObjectContext *context = [self getContext];
//    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"StocksEntity3"];
//    NSError *error = nil;
//    self.stocksArray = [[NSArray alloc]initWithArray:[context executeFetchRequest:request error:&error]];
//    self.stocksResults = [[NSMutableArray alloc]initWithArray:self.stocksArray];
//    [self.myTableView reloadData];
   // if (self.stocksArray) {
        
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:jsonUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.jsonResults = [[[json valueForKey:@"query"] valueForKey:@"results"]valueForKey:@"quote"];
//        if (self.jsonResults.count > 0) {
//            
//            NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"StocksEntity3"];
//            NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc]initWithFetchRequest:request];
//            NSError *deleteError = nil;
//            [[self getPersistentStoreCoordinator] executeRequest:delete withContext:context error:&deleteError];
//            [self.myTableView reloadData];
//            
//        }
        
        for (NSDictionary *performDic in self.jsonResults) {
            
            NSManagedObject *stockObjectDb = [NSEntityDescription insertNewObjectForEntityForName:@"StocksEntity8" inManagedObjectContext:context];
            NSString *tempStockName = [performDic valueForKey:@"Symbol"];
            [stockObjectDb setValue:tempStockName forKey:@"stockName"];
            NSString *tempLastTradePrice = [NSString stringWithFormat:@"%@", [performDic valueForKey:@"LastTradePriceOnly"]];
            [stockObjectDb setValue:tempLastTradePrice forKey:@"lastTradeprice"];
            NSString *tempChangeInPercent = [NSString stringWithFormat:@"%@", [performDic valueForKey:@"ChangeinPercent"]];
            [stockObjectDb setValue:tempChangeInPercent forKey:@"changeInPercentage"];
            
            if (![context save:nil]) {
                
                NSLog(@"Data not saved");
                
            }
            
            else{
                
                NSLog(@"Data saved successfully");
                [self.myTableView reloadData];
                
            }
           // [self.myTableView reloadData];
            
        }
        [self.myTableView reloadData];
    }];
    
    [dataTask resume];
        [self.myTableView reloadData];
        
   // }
    
//    else{
//        
//        NSLog(@"Data is present");
//       // [self fetchData];
//        [self.myTableView reloadData];
//        
//    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.stocksResults.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     //[self.myTableView reloadData];
    TableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"cell"];
    self.stockObject = [self.stocksResults objectAtIndex:indexPath.row];
    id lastTradeprice = [self.stockObject valueForKey:@"lastTradeprice"];
    id changeInPercent = [self.stockObject valueForKey:@"changeInPercentage"];
    cell.stockNameLabel.text = [self.stockObject valueForKey:@"stockName"];
    if ([lastTradeprice isKindOfClass:[NSNull class]]) {
        
        cell.lastTradePriceLabel.text = @"--";
        
    }
    
    else{
        
        cell.lastTradePriceLabel.text = lastTradeprice;
        
    }
    
    if ([changeInPercent isKindOfClass:[NSNull class]]) {
        
        cell.changeInPercentageLabel.text = @"--";
        
    }
    
    else{
        
        cell.changeInPercentageLabel.text = changeInPercent;
        
    }
   
    return cell;
    
}
@end

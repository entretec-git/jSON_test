

#import "MasterViewController.h"


#import "JSONModelLib.h"
#import "KivaFeed.h"
#import "HUD.h"


@interface MasterViewController ()
{
    KivaFeed* _feed;

}
@end


@implementation MasterViewController


-(void)viewDidAppear:(BOOL)animated
{
        //show loader view
    [HUD showUIBlockingIndicatorWithText:@"Fetching JSON"];
    
        //fetch the feed
    
//    [JSONHTTPClient getJSONFromURLWithString:@"http://knack.com.au/rain_json/"
//          completion:^(NSDictionary *json, JSONModelError *err) {
//    
//              NSError* error = nil;
//                _feed = [[KivaFeed alloc] initWithDictionary:json error:&error];
//                NSLog(@"RainData: %@", _feed.rainData);
//              
//              [HUD hideUIBlockingIndicator];
//
//              [self.tableView reloadData];   }];
//    
    
    _feed = [[KivaFeed alloc] initFromURLWithString:@"http://knack.com.au/rain_json/"
                                         completion:^(JSONModel *model, JSONModelError *err)
                                            {
                                             //hide the loader view
                                             [HUD hideUIBlockingIndicator];
                                             
                                            //json fetched
                                                    // NSLog(@"RainData: %@", _feed.rainData);
                                            [self.tableView reloadData];
                                             
                                         }];
}

#pragma mark - table methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _feed.rainData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RainModel * rain = _feed.rainData[indexPath.row];
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@  %@ mm",rain.rainfall_area,rain.rainfall_year];
    return cell;
    
    
}


@end
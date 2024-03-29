

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
    _feed = [[KivaFeed alloc] initFromURLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"
                                         completion:^(JSONModel *model, JSONModelError *err) {
                                             
                                                 //hide the loader view
                                             [HUD hideUIBlockingIndicator];
                                             
                                                 //json fetched
                                             NSLog(@"loans: %@", _feed.loans);
                                             
                                         }];
}




@end
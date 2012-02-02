//
//  SecondViewController.h
//  MyMoney
//
//  Created by byeong cheol lim on 11. 12. 18..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GADBannerView.h"
#import <iAd/iAd.h>
#define kSampleAdUnitID @"a14eee214a06cef";
@interface SecondViewController : UIViewController<UITabBarDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate ,GADBannerViewDelegate, ADBannerViewDelegate >
{
    GADBannerView *bannerView_;//admob
    ADBannerView* adBanner; // iAD
}
-(float)toColorValue:(float)rgbValue;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,retain) IBOutlet UILabel *cardLabel;
@property (nonatomic,retain) IBOutlet UILabel *shopLabel;
@property (nonatomic,retain) IBOutlet UILabel *priceLabel;
@property (nonatomic,retain) IBOutlet UILabel *dateLabel ;
@property (nonatomic,retain) IBOutlet UITableView *myTableView;
@property (nonatomic,retain) IBOutlet UITableViewCell *tableViewCell;
@end

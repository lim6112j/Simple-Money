//
//  MyTabBarViewController.h
//  MyMoney
//
//  Created by byeong cheol lim on 11. 12. 19..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import <UIKit/UIKit.h>
// Import GADBannerView’s definition from the SDK
#import "GADBannerView.h"
#import <iAd/iAd.h>
#define kSampleAdUnitID @"a14eee214a06cef";
@interface MyTabBarViewController : UITabBarController<GADBannerViewDelegate, ADBannerViewDelegate>
{
    GADBannerView *bannerView_;//admob
    ADBannerView* adBanner; // iAD
    UIView *contentView;
}
-(float)toColorValue:(float)rgbValue;
@property BOOL isiAdLoaded,isAdMobLoaded;

@end

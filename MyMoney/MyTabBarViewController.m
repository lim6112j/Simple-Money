//
//  MyTabBarViewController.m
//  MyMoney
//
//  Created by byeong cheol lim on 11. 12. 19..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "FirstViewController.h"
@implementation MyTabBarViewController
@synthesize isiAdLoaded,isAdMobLoaded;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    self.isAdMobLoaded=NO;
    self.isiAdLoaded=NO;
    contentView=[self.view retain];
    self.view=[[[UIView alloc]initWithFrame:contentView.frame]autorelease];
    [self.view addSubview:contentView];
    
    if (NSClassFromString(@"GADBannerView")) {
        // Create a view of the standard size at the bottom of the screen.
        bannerView_ = [[GADBannerView alloc]
                       initWithFrame:CGRectMake(0.0,
                                                self.view.frame.size.height -
                                                GAD_SIZE_320x50.height-self.tabBar.frame.size.height,
                                                GAD_SIZE_320x50.width,
                                                GAD_SIZE_320x50.height)];
        NSLog(@"tabbar height is %f",self.tabBar.frame.size.height);
        // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
        bannerView_.adUnitID = kSampleAdUnitID;
        
        // Let the runtime know which UIViewController to restore after taking
        // the user wherever the ad goes and add it to the view hierarchy.
        bannerView_.rootViewController = self;
        [self.view addSubview:bannerView_];
        
        // Initiate a generic request to load it with an ad.
        [bannerView_ loadRequest:[GADRequest request]];
    }
    // iAd 배너
    //if( NSClassFromString(@"ADBannerView") )
    if(!NSClassFromString(@"ADBannerView") )
    {
        /*
        adBanner = [[ADBannerView alloc] initWithFrame:CGRectZero];
        [adBanner setRequiredContentSizeIdentifiers:
         [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, nil]];
        
        [adBanner setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];
        [adBanner setFrame:CGRectMake(0, 410, 320, 50)];
        [adBanner setDelegate:self];
        [self.view addSubview:adBanner];
        [adBanner release];
         */
        adBanner = [[ADBannerView alloc] initWithFrame:CGRectZero];
        //adBanner=[[ADBannerView alloc] initWithFrame: CGRectMake(0, contentView.bounds.size.height-50, 320, 50)];
        [adBanner setRequiredContentSizeIdentifiers:
         [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, nil]];
        [adBanner setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];
        //[adBanner setFrame:CGRectMake(0, 434, 320, 50)];
        [adBanner setFrame:CGRectMake(0.0,
                                      self.view.frame.size.height -
                                      GAD_SIZE_320x50.height-self.tabBar.frame.size.height,
                                      GAD_SIZE_320x50.width,
                                      GAD_SIZE_320x50.height)];
        //adBanner.backgroundColor=[UIColor colorWithRed:[self toColorValue:223] green:[self toColorValue:233] blue:[self toColorValue:219] alpha:1];
        adBanner.hidden=YES;
        adBanner.delegate = self;
        [self.view addSubview: adBanner]; 
    }
}
-(float)toColorValue:(float)rgbValue
{
    return rgbValue/255;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
#pragma mark iAD Delegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (self.isAdMobLoaded==NO) {
        adBanner.hidden=NO;
        [UIView beginAnimations:@"animateBannerAppear" context:nil];
        //[adBanner setFrame:CGRectMake(0, 384, 320, 50)];
        //[adBanner setFrame:CGRectMake(0, 320, 320, 50)];
        [adBanner setFrame:CGRectMake(0.0,
                                      self.view.frame.size.height -
                                      GAD_SIZE_320x50.height-self.tabBar.frame.size.height,
                                      GAD_SIZE_320x50.width,
                                      GAD_SIZE_320x50.height)];
        [UIView commitAnimations];
        self.isiAdLoaded=YES;
    }

}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{

        [UIView beginAnimations:@"animateBannerOff" context:nil];
        //[adBanner setFrame:CGRectMake(0, 384, 320, 50)];
    [adBanner setFrame:CGRectMake(0.0,
                                  self.view.frame.size.height -
                                  GAD_SIZE_320x50.height-self.tabBar.frame.size.height,
                                  GAD_SIZE_320x50.width,
                                  GAD_SIZE_320x50.height)];
        
        [UIView commitAnimations];
    

}
#pragma mark -
#pragma mark adMob Delegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView 
{
    if (self.isiAdLoaded==NO) {
        [UIView beginAnimations:@"BannerSlide" context:nil];
        [bannerView_ setFrame:CGRectMake(0.0,
                                         self.view.frame.size.height -
                                         GAD_SIZE_320x50.height-self.tabBar.frame.size.height,
                                         GAD_SIZE_320x50.width,
                                         GAD_SIZE_320x50.height)];
        [UIView commitAnimations];
        self.isAdMobLoaded=YES;
        }
}

- (void)adView:(GADBannerView *)bannerView
didFailToReceiveAdWithError:(GADRequestError *)error 
{
    [UIView beginAnimations:@"BannerSlide" context:nil];
    [bannerView_ setFrame:CGRectMake(0.0,
                                     self.view.frame.size.height -
                                     GAD_SIZE_320x50.height,
                                     GAD_SIZE_320x50.width,
                                     GAD_SIZE_320x50.height)];
    [UIView commitAnimations];
}

@end

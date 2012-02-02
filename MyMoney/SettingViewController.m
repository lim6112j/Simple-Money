//
//  SettingViewController.m
//  MyMoney
//
//  Created by byeong cheol lim on 11. 12. 19..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import "SettingViewController.h"
@interface  SettingViewController()

- (void)_initControl;
- (void)_initLabel;

@end
@implementation SettingViewController
@synthesize scrollView=_scrollView,controlContainerView,numberLabel;
-(void)dealloc
{
    [controlContainerView release];
	[numberLabel release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Settings", @"this is comment");
        self.tabBarItem.image = [UIImage imageNamed:@"third"];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self _initControl];
    [self _initLabel];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.controlContainerView=nil;
    self.numberLabel=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
#pragma mark HorizontalSliderControl delegate methods

- (void)horizontalSliderControlValueChanged:(NSInteger)value
{
	[[self numberLabel] setText:[NSString stringWithFormat:@"%d", value]];
}

#pragma mark -
#pragma mark Private methods

- (void)_initControl
{
	HorizontalSliderControl *horizontalSliderControl = [[HorizontalSliderControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 60.0f)];
	[horizontalSliderControl setDelegate:self];
	[[self controlContainerView] addSubview:horizontalSliderControl];
	[horizontalSliderControl release];
}

- (void)_initLabel
{
	[self numberLabel].textColor = [UIColor whiteColor];
    [self numberLabel].shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.35];
    [self numberLabel].shadowOffset = CGSizeMake(0, -1.0);
	[self numberLabel].text = @"1";
}
@end

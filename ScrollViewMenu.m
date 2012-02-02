//
//  ScrollViewMenu.m
//  MyMoney
//
//  Created by byeong cheol lim on 11. 12. 26..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import "ScrollViewMenu.h"

@implementation ScrollViewMenu

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
-(void)loadView
{
    ScrollView *scrollView=[[ScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    scrollView.backgroundColor =[UIColor clearColor];
    self.view=scrollView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

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

@end

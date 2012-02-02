//
//  SettingViewController.h
//  MyMoney
//
//  Created by byeong cheol lim on 11. 12. 19..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScrollView.h"
#import "HorizontalSliderControl.h"
@interface SettingViewController : UIViewController<HorizontalSliderControlDelegate>
@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIView *controlContainerView;
@property (nonatomic, retain) IBOutlet UILabel *numberLabel;
@end

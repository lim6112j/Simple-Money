//
//  ScrollViewPagingExampleViewController.h
//  ScrollViewPagingExample
//
//
//  Created by byeong cheol lim on 11. 12. 25..
//  Copyright (c) 2011년 Byeong Cheol Lim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ItemView.h"
#define kItemWidth 47
#define kItemBelowWidth 50
@interface ScrollViewPagingExampleViewController : UIViewController<UIScrollViewDelegate> {
	IBOutlet UIScrollView	*_scrollView;
    IBOutlet UIScrollView	*_scrollViewBottom;
    SystemSoundID ssid;
    float lastScrollPosition;
    float positionY;
}
- (NSString *)applicationDocumentsDirectory ;
-(UIImage *)addText:(UIImage *)img text:(NSString *)text1;
@property(nonatomic,retain)IBOutlet UILabel *label;
@property(nonatomic,retain)IBOutlet UILabel *labelBelow;
@end


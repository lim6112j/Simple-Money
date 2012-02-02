//
//  MyScrollView.m
//  MyMoney
//
//  Created by byeong cheol lim on 11. 12. 20..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIImage *bg = [[UIImage imageNamed:@"slider.png"]stretchableImageWithLeftCapWidth:15 topCapHeight:0];
    [bg drawInRect:self.bounds];
}


@end

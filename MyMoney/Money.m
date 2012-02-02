//
//  Money.m
//  MyMoney
//
//  Created by byeong cheol lim on 11. 12. 18..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import "Money.h"


@implementation Money
- (NSString *)customSectionTitle {
    
    // Date formatter
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    // Return title calculated from entity's attributes
    // Or any other date calculations you need
    return [formatter stringFromDate:self.useDate];
    
}
@dynamic amount;
@dynamic card;
@dynamic owner;
@dynamic shop;
@dynamic useDate;

@end

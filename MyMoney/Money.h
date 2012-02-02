//
//  Money.h
//  MyMoney
//
//  Created by byeong cheol lim on 11. 12. 18..
//  Copyright (c) 2011년 SK M&S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Money : NSManagedObject
- (NSString *)customSectionTitle;
@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSString * card;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSString * shop;
@property (nonatomic, retain) NSDate * useDate;

@end

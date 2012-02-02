//
//  PlistLoader.h
//  DoodleFalling
//
//  Created by lim byeong cheol on 11. 9. 23..
//  Copyright 2011년 ZenCom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistLoader : NSObject
{
    NSMutableDictionary *dic;
}
-(NSMutableDictionary *)PlistLoadFromFileName:(NSString *)fileName;
- (NSString *)applicationDocumentsDirectory;
@end

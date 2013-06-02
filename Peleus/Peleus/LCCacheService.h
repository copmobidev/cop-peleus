//
//  LCCacheService.h
//  Peleus
//
//  Created by chris.liu on 6/2/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

// 提供本地数据缓存实现
@interface LCCacheService : NSObject
{
    double timeInterval;
}

+ (void)setTimeInterval:(NSTimeInterval)timeInterval;

+ (void)addCacheData:(NSData*)data forKey:(NSString*)key;
+ (NSData*)getCacheDataByKey:(NSString*)key;


@end
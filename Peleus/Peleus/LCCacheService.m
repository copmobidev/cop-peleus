//
//  LCCacheService.m
//  Peleus
//
//  Created by chris.liu on 6/2/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCCacheService.h"

@implementation LCCacheService


+ (void)setTimeInterval:(NSTimeInterval)timeInterval
{
    
}

+ (void)addCacheData:(NSData*)data forKey:(NSString*)key
{
    
}

+ (NSData*)getCacheDataByKey:(NSString*)key
{
    NSString *path = [self cacheFilePath:@"driveData"];
    NSFileManager *fm=[NSFileManager defaultManager];
    if ([fm fileExistsAtPath:path]) {
        return [fm contentsAtPath:path];
    }
    return nil;
}

+ (void)deleteCacheDataByKey:(NSString*)key
{
    
}


+ (NSString*)cacheFilePath:(NSString*)fileName
{
    NSString* path=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path=[path stringByAppendingString:@"/"];
    path=[path stringByAppendingString:fileName];
    
    return path;
}

@end

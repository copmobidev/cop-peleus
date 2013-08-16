//
//  LCStore.m
//  Achilles
//
//  Created by weiyanen on 13-6-5.
//  Copyright (c) 2013年 cop-studio. All rights reserved.
//

#import "LCStore.h"

@implementation LCStore

NSString * const RegisteredInfoKey = @"RegisteredInfo";

#pragma mark - Private Methods

LCSINGLETON_IN_M(LCStore)

- (id)init {
    if (self = [super init]) {
		
    }
    return self;
}

- (NSString*)getFilePathWithPath:(StorePath)storePath fileName:(NSString*)fileName {
    NSString *resultString = nil;
    switch (storePath) {
        case kStorePathCache: {
            resultString = [NSString stringWithFormat:@"%@/%@.plist", LCCachePath, fileName];
            break;
        }
        case kStorePathDocument: {
            resultString = [NSString stringWithFormat:@"%@/%@.plist", LCDocumentPath, fileName];
            break;
        }
        case kStorePathTmp: {
            resultString = [NSString stringWithFormat:@"%@/%@.plist",
                            NSTemporaryDirectory(), fileName];
            break;
        }
        default:
            NSLog(@"Unknown StorePath.[%u]", storePath);
            break;
    }
	
    return resultString;
}

#pragma mark - Public Methods

- (NSArray *)plistArrayForKey:(NSString *)key {
    return [self plistArrayForKey:key inPath:kStorePathCache];
}

- (BOOL)setPlistArray:(NSArray*)array forKey:(NSString*)key {
    return [self setPlistArray:array forKey:key inPath:kStorePathCache];
}

- (id)plistObjectForKey:(NSString *)key {
    return [self plistObjectForKey:key inPath:kStorePathCache];
}

- (BOOL)setPlistObject:(id<NSCoding>)obj forKey:(NSString*)key {
    return [self setPlistObject:obj forKey:key inPath:kStorePathCache];
}

#pragma mark - Plist Atomic Methods

// plist array
- (NSArray *)plistArrayForKey:(NSString *)key inPath:(StorePath)storePath {
    NSString *filePath = [self getFilePathWithPath:storePath fileName:key];
    return [NSArray arrayWithContentsOfFile:filePath];
}

- (BOOL)setPlistArray:(NSArray*)array forKey:(NSString*)key inPath:(StorePath)storePath {
    NSString *filePath = [self getFilePathWithPath:storePath fileName:key];
    BOOL suc = [array writeToFile:filePath atomically:YES];
    if (!suc) {
        NSLog(@"plist save error:%@,%u,%@", key, storePath, array);
    }
    return suc;
}

// plist object
- (id)plistObjectForKey:(NSString *)key inPath:(StorePath)storePath {
    NSString *filePath = [self getFilePathWithPath:storePath fileName:key];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return nil;
}

- (BOOL)setPlistObject:(id<NSCoding>)obj forKey:(NSString*)key inPath:(StorePath)storePath {
    NSString *filePath = [self getFilePathWithPath:storePath fileName:key];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    BOOL suc = [data writeToFile:filePath atomically:YES];
    if (!suc) {
        NSLog(@"plist save error:%@,%u,%@", key, storePath, obj);
    }
    return suc; // bool for success or fail
}

#pragma mark - UserDefaults for Custom Data

- (void)setUserDefaultObject:(id<NSCoding>)obj forKey:(NSString*)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [LCUserDefaults setObject:data forKey:key];
    [LCUserDefaults synchronize];
}

- (id)userDefaultObjectForKey:(NSString*)key {
    NSData *data = [LCUserDefaults objectForKey:key];
    if (data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return nil;
}

- (void)setUserDefaultBool:(BOOL)flag forKey:(NSString *)key {
	[LCUserDefaults setBool:flag forKey:key];
	[LCUserDefaults synchronize];
}

- (BOOL)userDefaultBoolForKey:(NSString *)key {
	return [LCUserDefaults boolForKey:key];
}

@end

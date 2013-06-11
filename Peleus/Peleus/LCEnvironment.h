//
//  LCEnvironment.h
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCEnvironment : NSObject


+ (LCEnvironment *)sharedEnvironment;

- (BOOL)debug;

- (NSString *)deviceId;

- (NSString *)userAgent;

- (NSString *)token;

- (NSString *)setToken;

/*
 App的版本
 */
- (NSString *)version;

/*
 设备的型号
 iPhone, iPad, iPod, iOS (is unknown)
 */
- (NSString *)deviceModel;

/*
 硬件版本
 */
- (NSString *)platform;

/*
 AppStore中的AppId
 */
- (NSString *)appId;

/*
 Info.plist中定义
 如"com.cop.achilles"
 */
- (NSString *)bundleId;

@end

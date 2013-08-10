//
//  LCEnvironment.h
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCEnvironment : NSObject
{
    NSString *_token;
}

+ (LCEnvironment *)sharedEnvironment;

- (BOOL)debug;

- (NSString *)userAgent;

- (NSString *)token;

- (void)setToken:(NSString *)token;

/*
 *   App的版本
 */
- (NSString *)version;

/*
 *   设备的型号
 *   iPhone, iPad, iPod, iOS (is unknown)
 */
- (NSString *)deviceModel;

/*
 *   硬件版本
 */
- (NSString *)platform;

/*
 *   AppStore中的AppId
 */
- (NSString *)appId;

@end
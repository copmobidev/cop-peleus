//
//  LCEnvironment.m
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCEnvironment.h"
#import <UIKit/UIDevice.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

static LCEnvironment *_sharedEnvironment = nil;

@implementation LCEnvironment

+ (LCEnvironment *)sharedEnvironment
{
    @synchronized(self) {
        if (_sharedEnvironment == nil) {
            _sharedEnvironment = [[LCEnvironment alloc] init];
        }
    }
    return _sharedEnvironment;
}

- (BOOL)debug
{
    return YES;
}

- (NSString *)userAgent
{
    return [NSString stringWithFormat:@"MApi 1.0 achilles %@ %@ %@ %@",
           [self version],
           [self deviceModel],
           [[UIDevice currentDevice] systemVersion],
           [self platform]];
}

- (NSString *)token
{
    return nil;
}

- (void)setToken:(NSString *)token
{
    _token = token;
}

- (NSString *)version
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

- (NSString *)deviceModel
{
    return [[UIDevice currentDevice] model];
}

- (NSString *)platform
{
    return @"IOS";
}

- (NSString *)appId
{
    return nil;
}

- (NSString *)bundleId
{
    return @"com.cop.achilles";
}

@end
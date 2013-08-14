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
    return [NSString stringWithFormat:@"MApi 1.0 %@ %@ %@ IOS %@",
            [self bundleId],
            [self appVersion],
            [self platformString],
            [self deviceVersion]];
}

- (NSString *)token
{
    return @"6c25e31d8fda33258dcfcc2046ba5121e0c78784e32032bd06a8bd2b3d96cb72";
}

- (void)setToken:(NSString *)token
{
    _token = token;
}

- (NSString *)appVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

- (NSString *)deviceModel
{
    return [[UIDevice currentDevice] model];
}

- (NSString *)deviceVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)appId
{
    return nil;
}

- (NSString *)bundleId
{
    return @"achilles";
}

- (NSString *)platform
{
    size_t size;

    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

- (NSString *)platformString
{
    NSString *platform = [self platform];

    if ([platform isEqualToString:@"iPhone1,1"]) {
        return @"iPhone 1G";
    }

    if ([platform isEqualToString:@"iPhone1,2"]) {
        return @"iPhone 3G";
    }

    if ([platform isEqualToString:@"iPhone2,1"]) {
        return @"iPhone 3GS";
    }

    if ([platform isEqualToString:@"iPhone3,1"]) {
        return @"iPhone 4";
    }

    if ([platform isEqualToString:@"iPod1,1"]) {
        return @"iPod Touch 1G";
    }

    if ([platform isEqualToString:@"iPod2,1"]) {
        return @"iPod Touch 2G";
    }

    if ([platform isEqualToString:@"iPod3,1"]) {
        return @"iPod Touch 3G";
    }

    if ([platform isEqualToString:@"iPod4,1"]) {
        return @"iPod Touch 4G";
    }

    if ([platform isEqualToString:@"iPad1,1"]) {
        return @"iPad";
    }

    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) {
        return @"iPhone Simulator";
    }

    return platform;
}

@end
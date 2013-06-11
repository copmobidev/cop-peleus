//
//  LCEnvironment.m
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCEnvironment.h"
#import "UIDevice+IdentifierAddition.h"

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

- (NSString *)deviceId
{
    return [[UIDevice currentDevice] uniqueMACUDIDIdentifier];
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

- (void)setToken:(NSString*)token
{
    self.token = token;
}

- (NSString *)version
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

- (NSString *)deviceModel
{
    return nil;
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

- (NSString *)appId
{
    return nil;
}

- (NSString *)bundleId
{
    return @"com.cop.achilles";
}

- (NSString *)macaddress
{
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;

    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;

    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }

    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }

    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }

    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }

    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);

    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x",
        *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3), *(ptr + 4), *(ptr + 5)];
    free(buf);
    return [outstring uppercaseString];
}

@end
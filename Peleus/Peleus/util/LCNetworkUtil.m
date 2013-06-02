//
//  LCNetworkUtil.m
//  Peleus
//
//  Created by ChrisLiu  on 5/11/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCNetworkUtil.h"
#import "LCConfig.h"
#import "Reachability.h"

@implementation LCNetworkUtil

/**
 * 判断当前网络连接状况
 *
 */
+ (LCNetworkState)networkState
{
    Reachability *bizReach = [Reachability reachabilityWithHostName:COP_BIZ_SERVER];
    Reachability *obdReach = [Reachability reachabilityWithHostName:COP_OBD_SERVER];
    
    if ([bizReach currentReachabilityStatus] == NotReachable &&
        [obdReach currentReachabilityStatus] == NotReachable)
    {
        return NONE;
    }
    else if ([bizReach currentReachabilityStatus] == ReachableViaWWAN) {
        return G3_BIZ;
    }
    else if ([bizReach currentReachabilityStatus] == ReachableViaWiFi) {
        return WIFI_BIZ;
    }
    else if ([obdReach currentReachabilityStatus] == ReachableViaWiFi) {
        return WIFI_OBD;
    }
    return NONE;
}

@end

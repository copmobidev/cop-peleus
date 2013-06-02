//
//  LCNetworkUtil.h
//  Peleus
//
//  Created by ChrisLiu  on 5/11/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _LCNetworkState
{
    NONE, // 无网络连接
    G3_BIZ, // 3G网络
    WIFI_BIZ, // wifi连接internet
    WIFI_OBD // wifi连接硬件设备
} LCNetworkState;

@interface LCNetworkUtil : NSObject


+ (LCNetworkState)networkState;

@end

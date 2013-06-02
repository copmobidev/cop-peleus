//
//  LCDataService.h
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDataConfig.h"
#import "LCDataServiceDelegate.h"
#import "WhiteRaccoon.h"


@class LCTimestamp;
@class LCDriveData;

@interface LCDataService : NSObject <WRRequestDelegate>

@property (nonatomic, strong) id<LCDataServiceDelegate> delegate;


+ (LCDataService*)sharedDataService;

// 获取配置文件
- (void)obdConfig;

// 同步数据
- (void)dataSync;

// 上传数据
- (void)dataUpload;


// 获取一年数据统计时，按月划分数据，展现数据包括
// 1.每月、日刹车、加速等驾驶行为统计
// 2.每月、日平均/最佳油耗统计
// 3.每月、日平均速度统计
// 4.每月、日最佳温度统计
- (LCDriveData*)getDriveDataWithSpan:(LCTimestamp*) timestamp;

// 解析OBD硬件端原始数据
- (LCDriveData*)parseOriginData:(NSString* )originData;

@end

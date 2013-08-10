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
#import "BRRequest.h"

@class  LCTimestamp;
@class  LCDriveData;

@interface LCDataService : NSObject <BRRequestDelegate>

@property (nonatomic, strong) id <LCDataServiceDelegate> delegate;

+ (LCDataService *)sharedDataService;

#pragma mark - FTP Actions

// 获取配置文件
- (void)getConfig;

// 向obd写入配置文件
- (void)pushConfig;

// 同步数据
- (void)syncData;

// 获取ftp index
- (int)getIndex;

#pragma mark - Server Actions

// 上传数据
- (void)uploadData;

- (LCDriveData *)getDriveDataWithSpan:(LCTimestamp *)timestamp;

/*
 暂时不支持
 */
- (LCDriveData *)parseOriginData:(NSString *)originData;

@end
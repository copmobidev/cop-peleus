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
#import "LCMapiServiceDelegate.h"
#import "LCMApiService.h"
#import "BRRequest.h"


@class LCTimestamp;
@class LCDriveData;

@interface LCDataService : NSObject <BRRequestDelegate, LCMApiServiceDelegate>

@property (nonatomic, strong) id<LCDataServiceDelegate> delegate;


+ (LCDataService*)sharedDataService;

// 获取配置文件
- (void)obdConfig;

// 同步数据
- (void)dataSync;

// 上传数据
- (void)dataUpload;

- (LCDriveData*)getDriveDataWithSpan:(LCTimestamp*) timestamp;

- (LCDriveData*)parseOriginData:(NSString* )originData;

@end

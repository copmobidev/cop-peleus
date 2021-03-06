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
#import "BRRequestListDirectory.h"
#import "BRRequestCreateDirectory.h"
#import "BRRequestUpload.h"
#import "BRRequestDownload.h"
#import "BRRequestDelete.h"
#import "BRRequest+_UserData.h"
#import "ASIHTTPRequestDelegate.h"
#import "ASIFormDataRequest.h"

@class  LCTimestamp;
@class  LCDriveData;

@interface LCDataService : NSObject <BRRequestDelegate, ASIHTTPRequestDelegate>
{
    NSData *uploadData;
    NSMutableData *configData;
    NSMutableData *idxData;
    NSMutableData *driveData;
    NSMutableArray *finalData;
	BRRequestUpload *uploadFile;
    
    int point;
    int fileLength;
    NSString *idxStr;
}

@property (nonatomic, strong) id <LCDataServiceDelegate> delegate;

+ (LCDataService *)sharedDataService;

// 获取配置文件
- (void)getConfig;

// 向obd写入配置文件，从server端获取的硬件计算参数，区别于obd端config文件
- (void)pushParam;

// 同步数据
- (void)syncData;

// 上传数据,多组数据之间以分号隔开
- (void)uploadData:(NSString *)data;

- (void)getDriveDataWithSpan:(LCTimestamp *)timestamp;

/*
 暂时不支持
 */
- (LCDriveData *)parseOriginData:(NSString *)originData;

@end
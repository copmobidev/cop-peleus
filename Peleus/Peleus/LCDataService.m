//
//  LCDataService.m
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCDataService.h"
#import "LCTimestamp.h"

@implementation LCDataService

static LCDataService* sharedDataService = nil;

+ (LCDataService*)sharedDataService
{
	@synchronized(self)
    {
		if (sharedDataService == nil)
        {
			sharedDataService = [[LCDataService alloc] init];
		}
	}
	return sharedDataService;
}

- (void)obdConfig
{
    
}

- (void)dataSync
{
    NSDictionary* data = nil;
    
    WRRequestDownload* downloadFile = [[WRRequestDownload alloc] init];
    downloadFile.delegate = self;
    
    downloadFile.path = @"/data";
    downloadFile.hostname = COP_OBD_SERVER;
    downloadFile.username = @"anonymous";
    downloadFile.password = @"";
    
    [downloadFile start];
    
    [self.delegate onSyncDataSuccess:data];
}

- (void)dataUpload
{
    
}

- (void)listDriveDataFiles
{
    WRRequestListDirectory* listDir = [[WRRequestListDirectory alloc] init];
    listDir.delegate = self;
    listDir.path = @"/";
    
    listDir.hostname = COP_OBD_SERVER;
    listDir.username = @"anonymous";
    listDir.password = @"";
    
    [listDir start];
}

- (void)deleteDriveDataFiles
{
    WRRequestDelete* deleteDir = [[WRRequestDelete alloc] init];
    deleteDir.path = @"/data/";
    deleteDir.hostname = COP_OBD_SERVER;
    deleteDir.username = @"anonymous";
    deleteDir.password = @"";
    
    //we start the request
    [deleteDir start];
}

- (LCDriveData*)getDriveDataWithSpan:(LCTimestamp*)timestamp
{
    switch ([timestamp span]) {
        case YEAR:
            break;
        case MONTH:
            break;
        case WEEK:
            break;
        case TRACK:
            break;
        default:
            break;
    }
    return nil;
}

//
// 解析原始数据
// 获取一次行程数据，包含两种数据
// 1.单次行程summary数据
// 2.单次行程分析后取得的各个时间片上的统计数据，主要包括各个时间点上的平均油耗、
//
- (LCDriveData*)parseOriginData:(NSString*)originData
{
    return nil;
}

#pragma mark -
#pragma mark WRRequestDelegate implement

// obd ftp server相关请求操作成功时，解析数据并通知上层回调函数完成相关动作
- (void)requestCompleted:(WRRequest*)request
{
    
    if ([request isKindOfClass:[WRRequestDownload class]]) {
        // 成功获取行程数据
    }
    else if ([request isKindOfClass:[WRRequestListDirectory class]])
    {
        // 成功获取行程数据列表
        WRRequestListDirectory* listDir = (WRRequestListDirectory*)request;
        //we print each of the files name
        for (NSDictionary* file in listDir.filesInfo) {
            NSLog(@"%@", [file objectForKey:(id)kCFFTPResourceName]);
        }
    }
    else if ([request isKindOfClass:[WRRequestDelete class]])
    {
        // 删除数据成功
    }
}

// obd ftp 获取数据失败时，通知上层回调函数做相应处理
- (void)requestFailed:(WRRequest* )request
{
    
}


@end

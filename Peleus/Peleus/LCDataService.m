//
//  LCDataService.m
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCDataService.h"
#import "LCTimestamp.h"
#import "BRRequestListDirectory.h"
#import "BRRequestCreateDirectory.h"
#import "BRRequestUpload.h"
#import "BRRequestDownload.h"
#import "BRRequestDelete.h"
#import "LCMapiRequest.h"

@implementation LCDataService

static LCDataService* _sharedDataService = nil;

+ (LCDataService*)sharedDataService
{
	@synchronized(self)
    {
		if (_sharedDataService == nil)
        {
			_sharedDataService = [[LCDataService alloc] init];
		}
	}
	return _sharedDataService;
}

- (void)obdConfig
{
    return nil;
}

- (void)dataSync
{
    NSDictionary* data = nil;
    
    BRRequestDownload* downloadFile = [[BRRequestDownload alloc] init];
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
    BRRequestListDirectory* listDir = [[BRRequestListDirectory alloc] init];
    listDir.delegate = self;
    listDir.path = @"/";
    
    listDir.hostname = COP_OBD_SERVER;
    listDir.username = @"anonymous";
    listDir.password = @"";
    
    [listDir start];
}

- (void)deleteDriveDataFiles
{
    BRRequestDelete* deleteDir = [[BRRequestDelete alloc] init];
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


- (LCDriveData*)parseOriginData:(NSString*)originData
{
    return nil;
}

#pragma mark -
#pragma mark BRRequestDelegate implement

// obd ftp server相关请求操作成功时，解析数据并通知上层回调函数完成相关动作
- (void)requestCompleted:(BRRequest*)request
{
    
    if ([request isKindOfClass:[BRRequestDownload class]])
    {
        
    }
    else if ([request isKindOfClass:[BRRequestListDirectory class]])
    {
        // 成功获取行程数据列表
        BRRequestListDirectory* listDir = (BRRequestListDirectory*)request;
        //we print each of the files name
        for (NSDictionary* file in listDir.filesInfo)
        {
            NSLog(@"%@", [file objectForKey:(id)kCFFTPResourceName]);
        }
    }
    else if ([request isKindOfClass:[BRRequestDelete class]])
    {
        // 删除数据成功
    }
}

// obd ftp 获取数据失败时，通知上层回调函数做相应处理
- (void)requestFailed:(BRRequest* )request
{
    
}

- (BOOL)shouldOverwriteFileWithRequest:(BRRequest *)request
{
    return false;
}

#pragma mark -
#pragma mark MApiServiceDelegate implement

- (void)onRequestStart:(LCMApiRequest*)request
{
    
}

- (void)onRequestFinished:(LCMApiRequest*)request
{
    
}

- (void)onRequestFailed:(LCMApiRequest*)request
{
    
}

@end

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
#import "BRRequestUpload.h"
#import "BRRequestDownload.h"
#import "BRRequestDelete.h"

@interface LCDataService()

- (NSUInteger)getFTPIndex;

@end

@implementation LCDataService

static LCDataService *_sharedDataService = nil;

LCSINGLETON_IN_M(LCDataService)

- (NSUInteger)getFTPIndex {
	
}

- (void)getConfig
{
    NSData *config = nil;

    BRRequestDownload *fileDowndloadReq = [[BRRequestDownload alloc] init];
    fileDowndloadReq.delegate = self;
    fileDowndloadReq.tag = @"config";
    fileDowndloadReq.path = @"/config";
    fileDowndloadReq.hostname = COP_OBD_SERVER;
    fileDowndloadReq.username = COP_OBD_USER;
    fileDowndloadReq.password = COP_OBD_PWD;
    [fileDowndloadReq start];
    [self.delegate onSyncDataSuccess:config];
}

- (void)pushConfig
{
    ;
}

- (void)syncData
{
    NSData *data = nil;
    BRRequestDownload *fileDowndloadReq = [[BRRequestDownload alloc] init];
    fileDowndloadReq.delegate = self;
    fileDowndloadReq.tag = @"data";
    fileDowndloadReq.path = @"/data/";
    fileDowndloadReq.hostname = COP_OBD_SERVER;
    fileDowndloadReq.username = COP_OBD_USER;
    fileDowndloadReq.password = COP_OBD_PWD;
    [fileDowndloadReq start];
    [self.delegate onSyncDataSuccess:data];
}

- (void)uploadData
{}

- (void)deleteDriveDataFiles
{
    BRRequestDelete *fileDelReq = [[BRRequestDelete alloc] init];
    fileDelReq.path = @"/data/";
    fileDelReq.hostname = COP_OBD_SERVER;
    fileDelReq.username = COP_OBD_USER;
    fileDelReq.password = COP_OBD_PWD;

    // we start the request
    [fileDelReq start];
}

- (LCDriveData *)getDriveDataWithSpan:(LCTimestamp *)timestamp
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

/*
 *   暂时不在本地做数据解析
 */
- (LCDriveData *)parseOriginData:(NSString *)originData
{
    return nil;
}

#pragma mark -
#pragma mark BRRequestDelegate implement
// obd ftp server相关请求操作成功时，解析数据并通知上层回调函数完成相关动作
- (void)requestCompleted:(BRRequest *)request
{
    if ([request isKindOfClass:[BRRequestDownload class]]) {
        if ([request.tag isEqualToString:@"config"]) {
            // obd配置同步完成
            NSData *config = nil;
            [self.delegate onGetConfigSuccess:config];
            
        } else if ([request.tag isEqualToString:@"data"]) {
            // 数据同步完成
            
        }
        
    } else if ([request isKindOfClass:[BRRequestListDirectory class]]) {
        // 成功获取行程数据列表
        BRRequestListDirectory *listDir = (BRRequestListDirectory *)request;

        // we print each of the files name
        for (NSDictionary *file in listDir.filesInfo) {
            NSLog(@"%@", [file objectForKey:(id)kCFFTPResourceName]);
        }
    } else if ([request isKindOfClass:[BRRequestDelete class]]) {
        // 删除数据成功
    }
}

// obd ftp 获取数据失败时，通知上层回调函数做相应处理
- (void)requestFailed:(BRRequest *)request
{}

- (BOOL)shouldOverwriteFileWithRequest:(BRRequest *)request
{
    return false;
}

@end
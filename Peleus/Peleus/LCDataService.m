//
//  LCDataService.m
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCDataService.h"
#import "LCDataParser.h"
#import "LCTimestamp.h"
#import "BRRequestListDirectory.h"
#import "BRRequestUpload.h"
#import "BRRequestDownload.h"
#import "BRRequestDelete.h"
#import "BRRequestQueue.h"
#import "JSONKit.h"

@implementation LCDataService

static LCDataService *_sharedDataService = nil;
static int lstFile = 0;
static int curFile = 0;


+ (LCDataService *)sharedDataService
{
    @synchronized(self) {
        if (_sharedDataService == nil) {
            _sharedDataService = [[LCDataService alloc] init];
        }
    }
    return _sharedDataService;
}

- (void)getConfig
{
    BRRequestDownload *fileDowndloadReq = [[BRRequestDownload alloc] init];
    fileDowndloadReq.delegate = self;
    fileDowndloadReq.tag = OBD_CMD_CONFIG_GET;
    fileDowndloadReq.path = OBD_PATH_CONFIG;
    fileDowndloadReq.hostname = COP_OBD_SERVER;
    fileDowndloadReq.username = COP_OBD_USER;
    fileDowndloadReq.password = COP_OBD_PWD;
    configData = [[NSMutableData alloc] init];
    
    [fileDowndloadReq start];
    
}

- (void)delParam
{
    BRRequestDelete *fileDelReq = [[BRRequestDelete alloc] init];
    fileDelReq.delegate = self;
    fileDelReq.tag = OBD_CMD_PARAM_DEL;
    fileDelReq.path = OBD_PATH_PARAM;
    fileDelReq.hostname = COP_OBD_SERVER;
    fileDelReq.username = COP_OBD_USER;
    fileDelReq.password = COP_OBD_PWD;
    [fileDelReq start];
}

- (void)addParam
{
    NSString *idxStr = @"3.2";
    uploadData = [idxStr dataUsingEncoding: NSASCIIStringEncoding];
    BRRequestUpload *fileUploadReq = [[BRRequestUpload alloc] init];
    fileUploadReq.delegate = self;
    fileUploadReq.tag = OBD_CMD_PARAM_PUSH;
    fileUploadReq.path = OBD_PATH_PARAM;
    fileUploadReq.hostname = COP_OBD_SERVER;
    fileUploadReq.username = COP_OBD_USER;
    fileUploadReq.password = COP_OBD_PWD;
    [fileUploadReq start];
}

- (void)pushParam
{
    [self delParam];
}

- (void)delIndex
{
    BRRequestDelete *fileDelReq = [[BRRequestDelete alloc] init];
    fileDelReq.delegate = self;
    fileDelReq.tag = OBD_CMD_PARAM_DEL;
    fileDelReq.hostname = OBD_PATH_IDX;
    fileDelReq.username = COP_OBD_SERVER;
    fileDelReq.username = COP_OBD_USER;
    fileDelReq.password = COP_OBD_PWD;
    [fileDelReq start];
}

- (void)pushIndex
{
    
    NSString *idxStr = @"000000000000037000000000000043";
    uploadData = [idxStr dataUsingEncoding: NSASCIIStringEncoding];;
    BRRequestUpload *fileUploadReq = [[BRRequestUpload alloc] init];
    fileUploadReq.delegate = self;
    fileUploadReq.tag = OBD_CMD_IDX_PUSH;
    fileUploadReq.path = OBD_PATH_IDX;
    fileUploadReq.hostname = COP_OBD_SERVER;
    fileUploadReq.username = COP_OBD_USER;
    fileUploadReq.password = COP_OBD_PWD;
    [fileUploadReq start];
}

- (void)getIndex
{
    BRRequestDownload *fileDowndloadReq = [[BRRequestDownload alloc] init];
    fileDowndloadReq.delegate = self;
    fileDowndloadReq.tag = OBD_CMD_IDX_GET;
    fileDowndloadReq.path = OBD_PATH_IDX;
    fileDowndloadReq.hostname = COP_OBD_SERVER;
    fileDowndloadReq.username = COP_OBD_USER;
    fileDowndloadReq.password = COP_OBD_PWD;
    idxData = [[NSMutableData alloc] init];
    [fileDowndloadReq start];
    
}

- (void)syncData
{
    [self getIndex];
    finalData = [[NSMutableArray alloc] init];
}

- (void)getDriveDataFromOBD
{
    driveData = [[NSMutableData alloc] init];
    BRRequestDownload *fileDowndloadReq = [[BRRequestDownload alloc] init];
    fileDowndloadReq.delegate = self;
    fileDowndloadReq.tag = OBD_CMD_DATA_GET;
    NSString * tmp = [NSString stringWithFormat:@"%d", point];
    fileDowndloadReq.path =[NSString stringWithFormat:@"/data/%@%@", [@"000000000000000" substringFromIndex:[tmp length]], tmp];
    NSLog(@"%@", fileDowndloadReq.path);
    fileDowndloadReq.hostname = COP_OBD_SERVER;
    fileDowndloadReq.username = COP_OBD_USER;
    fileDowndloadReq.password = COP_OBD_PWD;
    idxData = [[NSMutableData alloc] init];
    [fileDowndloadReq start];
}

- (void)uploadData
{
    // API 

}


#pragma mark - ASIHTTP Delegate

//- (void)requestFinished:(ASIHTTPRequest *)request {
//	
//	
//	[request setResponseEncoding:NSUTF8StringEncoding];
//	
//	// 当以文本形式读取返回内容时用这个方法
//	NSString *json = [request responseString];
//}


- (LCDriveData *)getDriveDataWithSpan:(LCTimestamp *)timestamp
{
	
//	NSURL *url = [NSURL URLWithString:[COP_BIZ_SERVER stringByAppendingString:@"/argus/mycar/get"]];
//	ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
//	//ua必填，否则没有responseString，为nil
//	[request addRequestHeader:@"ua" value:UA];
//	[request setPostValue:TOKEN    forKey:@"token"];
//	[request setPostValue:@"1362150000000" forKey:@"beginTime"];
//	[request setPostValue:@"1362150000000" forKey:@"engTime"];
//	
//	[request setDelegate:self];
//	[request startAsynchronous];
	
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
        if ([request.tag isEqualToString:OBD_CMD_CONFIG_GET]) {
            // obd配置同步完成
            [self.delegate onGetConfigSuccess:configData];
        } else if ([request.tag isEqualToString:OBD_CMD_IDX_GET]) {
            // 成功获取Index
            NSString *idxContent = [[NSString alloc] initWithData:idxData encoding:NSASCIIStringEncoding];
            NSLog(@"%@", idxContent);
            @try {
                NSString *curFile = [idxContent substringFromIndex:16];
                NSString *lstFile = [idxContent substringToIndex:15];
                fileLength = [curFile intValue];
                point = [lstFile intValue];
                if (fileLength >= point) {
                    [self getDriveDataFromOBD];
                }
            }
            @catch (NSException *exception) {
                NSLog(@"read file error");
            }
            // start drive data download
        } else if ([request.tag isEqualToString:OBD_CMD_DATA_GET]) {
            // 硬件端数据同步完成
            if (fileLength <= point) {
                [finalData addObject:driveData];
                [self.delegate onSyncDataSuccess:finalData];
            } else {
                [finalData addObject:driveData];
                point ++;
                [self getDriveDataFromOBD];
            }
        }
        
    } else if ([request isKindOfClass:[BRRequestDelete class]]) {
        // 删除数据成功
        if ([request.tag isEqualToString:OBD_CMD_PARAM_DEL]) {
            [self addParam];
        }
        
    } else if ([request isKindOfClass:[BRRequestUpload class]]) {
        if ([request.tag isEqualToString:OBD_CMD_PARAM_PUSH]) {
            [self.delegate onPushParamSucess];
        } else {
            
        }
    }
}

- (void)requestDataAvailable:(BRRequestDownload *)request
{
    if ([request.tag isEqualToString:OBD_CMD_CONFIG_GET]) {
        [configData appendData:request.receivedData];
    } else if ([request.tag isEqualToString:OBD_CMD_IDX_GET]) {
        [idxData appendData:request.receivedData];
    } else if ([request.tag isEqualToString:OBD_CMD_DATA_GET]) {
        [driveData appendData:request.receivedData];
    }
}

- (long)requestDataSendSize:(BRRequestUpload *)request
{
    NSLog(@"lenth:%d", [uploadData length]);
    return [uploadData length];
}

- (NSData *)requestDataToSend:(BRRequestUpload *)request
{
    NSLog(@"requestDataToSend");
    NSData *tmp = uploadData;
    uploadData = nil;
    return tmp;
}

// obd ftp 获取数据失败时，通知上层回调函数做相应处理
- (void)requestFailed:(BRRequest *)request
{
    NSLog(@"%@-%@", request.tag, [request description]);
    if ([request isKindOfClass:[BRRequestDownload class]]) {
        if ([request.tag isEqualToString:OBD_CMD_CONFIG_GET]) {
            // obd配置同步完成
            [self.delegate onGetConfigFail];
        } else if ([request.tag isEqualToString:OBD_CMD_IDX_GET]) {
            // 成功获取Index
            [self.delegate onSyncDataFail];
        } else if ([request.tag isEqualToString:OBD_CMD_DATA_GET]) {
            // 硬件端数据同步完成
            [self.delegate onSyncDataFail];
        }
    } else if ([request isKindOfClass:[BRRequestDelete class]]) {
        if ([request.tag isEqualToString:OBD_CMD_PARAM_DEL]) {
            [self addParam];
        }
        
    } else if ([request isKindOfClass:[BRRequestUpload class]]) {
        if ([request.tag isEqualToString:OBD_CMD_PARAM_PUSH]) {
            [self.delegate onPushParamFail];
        } else {
            
        }
    }
//	else if ([request isKindOfClass:[ASIHTTPRequest class]]) {
//		// asi http request fail
//	}
}

@end
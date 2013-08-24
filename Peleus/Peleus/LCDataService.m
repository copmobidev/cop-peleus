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
#import "LCEnvironment.h"
#import "ASIFormDataRequest.h"
#import "LCTypeParser.h"
#import "LCDriveData.h"
#import "LCDrivePiece.h"

@implementation LCDataService

static LCDataService *_sharedDataService = nil;

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
    BRRequestDownload *fileDowndloadReq = [[BRRequestDownload alloc] initWithDelegate:self];

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
    NSString *paramStr = @"3.1";

    uploadData = [paramStr dataUsingEncoding:NSASCIIStringEncoding];

    uploadFile = [[BRRequestUpload alloc] initWithDelegate:self];
    uploadFile.tag = OBD_CMD_PARAM_PUSH;
    uploadFile.path = OBD_PATH_PARAM;
    uploadFile.hostname = COP_OBD_SERVER;
    uploadFile.username = COP_OBD_USER;
    uploadFile.password = COP_OBD_PWD;

    [uploadFile start];
}

- (void)pushParam
{
    [self addParam];
}

- (void)delIndex
{
    BRRequestDelete *fileDelReq = [[BRRequestDelete alloc] init];

    fileDelReq.delegate = self;
    fileDelReq.tag = OBD_CMD_IDX_DEL;
    fileDelReq.hostname = OBD_PATH_IDX;
    fileDelReq.username = COP_OBD_SERVER;
    fileDelReq.username = COP_OBD_USER;
    fileDelReq.password = COP_OBD_PWD;
    [fileDelReq start];
}

- (void)pushIndex
{
    NSString    *tmpCur = [NSString stringWithFormat:@"%d", point];
    NSString    *curIdx = [NSString stringWithFormat:@"%@%@", [@"000000000000000" substringFromIndex :[tmpCur length]], tmpCur];
    NSString    *tmpLst = [NSString stringWithFormat:@"%d", fileLength];
    NSString    *lstIdx = [NSString stringWithFormat:@"%@%@", [@"000000000000000" substringFromIndex :[tmpLst length]], tmpLst];

    idxStr = [NSString stringWithFormat:@"%@%@", curIdx, lstIdx];
    uploadData = [idxStr dataUsingEncoding:NSASCIIStringEncoding];

    uploadFile = [[BRRequestUpload alloc] initWithDelegate:self];
    uploadFile.tag = OBD_CMD_IDX_PUSH;
    uploadFile.path = OBD_PATH_IDX;
    uploadFile.hostname = COP_OBD_SERVER;
    uploadFile.username = COP_OBD_USER;
    uploadFile.password = COP_OBD_PWD;
    [uploadFile start];
}

- (void)getIndex
{
    BRRequestDownload *fileDowndloadReq = [[BRRequestDownload alloc] initWithDelegate:self];

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

    BRRequestDownload *fileDowndloadReq = [[BRRequestDownload alloc] initWithDelegate:self];
    fileDowndloadReq.tag = OBD_CMD_DATA_GET;
    NSString *tmp = [NSString stringWithFormat:@"%d", point];

    fileDowndloadReq.path = [NSString stringWithFormat:@"/data/%@%@", [@"000000000000000" substringFromIndex :[tmp length]], tmp];
    fileDowndloadReq.hostname = COP_OBD_SERVER;
    fileDowndloadReq.username = COP_OBD_USER;
    fileDowndloadReq.password = COP_OBD_PWD;

    //    idxData = [[NSMutableData alloc] init];

    [fileDowndloadReq start];
}

- (void)uploadData:(NSString *)data
{
    // API
    NSString            *ua = [[LCEnvironment sharedEnvironment] userAgent];
    NSString            *token = [[LCEnvironment sharedEnvironment] token];
    NSURL               *url = [NSURL URLWithString:API_MYCAR_UPLOAD];
    ASIFormDataRequest  *request = [ASIFormDataRequest requestWithURL:url];

    [request addRequestHeader:@"ua" value:ua];
    [request setPostValue:token forKey:@"token"];
    [request setPostValue:data forKey:@"data"];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    request.tag = SERVER_UPLOAD;
    [request start];
}

- (void)getDriveDataWithSpan:(LCTimestamp *)timestamp
{
    NSURL *url = [NSURL URLWithString:API_MYCAR_GET];

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];

    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"ua" value:UA];
    [request setPostValue:TOKEN forKey:@"token"];
    [request setPostValue:[LCTypeParser long2String:timestamp.beginTime] forKey:@"beginTime"];
    [request setPostValue:[LCTypeParser long2String:timestamp.endTime] forKey:@"endTime"];
    [request setPostValue:@"0" forKey:@"span"];
    request.tag = SERVER_GET_DRIVE_DATA;
    [request setDelegate:self];

    [request start];
}

/*
 *   暂时不在本地做数据解析
 */

/*
 *   - (LCDriveData *)parseOriginData:(NSString *)originData
 *   {
 *    return nil;
 *   }
 */

#pragma mark -
#pragma mark BRRequestDelegate implement
// obd ftp server相关请求操作成功时，解析数据并通知上层回调函数完成相关动作
- (void)brRequestCompleted:(BRRequest *)request
{
    NSLog(@"brRequestCompleted:%@-%@", request.tag, [request description]);

    if ([request isKindOfClass:[BRRequestDownload class]]) {
        if ([request.tag isEqualToString:OBD_CMD_CONFIG_GET]) {
            // obd配置同步完成
            [self.delegate onGetConfigSuccess:configData];
        } else if ([request.tag isEqualToString:OBD_CMD_IDX_GET]) {
            // 成功获取Index
            NSString *idxContent = [[NSString alloc] initWithData:idxData encoding:NSASCIIStringEncoding];
            NSLog(@"%@", idxContent);
            @try {
                NSString    *curFile = [idxContent substringFromIndex:16];
                NSString    *lstFile = [idxContent substringToIndex:15];
                fileLength = [curFile intValue];
                point = [lstFile intValue];

                if (fileLength > point) {
                    point++;
                    [self getDriveDataFromOBD];
                } else {
                    [self.delegate onSyncDataSuccess:[NSArray array]];
                }
            }
            @catch(NSException *exception) {
                NSLog(@"read file error");
            }

            // start drive data download
        } else if ([request.tag isEqualToString:OBD_CMD_DATA_GET]) {
            // 硬件端数据同步完成
            if (fileLength <= point) {
                [finalData addObject:driveData];
                // push index file, if success then call delegate.
                [self pushIndex];
            } else {
                [finalData addObject:driveData];
                point++;
                [self getDriveDataFromOBD];
            }

            driveData = nil;
        }
    } else if ([request isKindOfClass:[BRRequestDelete class]]) {
        // 删除文件成功
        if ([request.tag isEqualToString:OBD_CMD_PARAM_DEL]) {
            [self addParam];    // 上传配置参数
        } else if ([request.tag isEqualToString:OBD_CMD_IDX_DEL]) {
            [self pushIndex];   // 上传新的索引文件
        }
    } else if ([request isKindOfClass:[BRRequestUpload class]]) {
        if ([request.tag isEqualToString:OBD_CMD_PARAM_PUSH]) {
            [self.delegate onPushParamSucess];
        } else if ([request.tag isEqualToString:OBD_CMD_IDX_PUSH]) {
            [self.delegate onSyncDataSuccess:finalData];
        }

        uploadFile = nil;
    }
}

// obd ftp 获取数据失败时，通知上层回调函数做相应处理
- (void)brRequestFailed:(BRRequest *)request
{
    NSLog(@"brRequestFailed:%@-%@", request.tag, [request description]);

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
        } else if ([request.tag isEqualToString:OBD_CMD_IDX_PUSH]) {
            [self.delegate onSyncDataFail];
        }

        uploadFile = nil;
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

- (void)percentCompleted:(BRRequest *)request
{
    NSLog(@"%f completed...", request.percentCompleted);

    NSLog(@"%ld bytes this iteration", request.bytesSent);
    NSLog(@"%ld total bytes", request.totalBytesSent);
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

- (BOOL)shouldOverwriteFileWithRequest:(BRRequest *)request
{
    // ----- set this as appropriate if you want the file to be overwritten
    if ([request.tag isEqualToString:OBD_CMD_PARAM_PUSH] || [request.tag isEqualToString:OBD_CMD_IDX_PUSH]) {
        // ----- if uploading param.in, we set it to YES
        return YES;
    }

    // ----- anything else (directories, etc) we set to NO
    return NO;
}

#pragma mark -
#pragma mark ASIRequestDelegate implement

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSError         *error;
    NSDictionary    *responseDict = [NSJSONSerialization JSONObjectWithData:[request responseData] options:NSJSONReadingMutableLeaves error:&error];
    //	NSLog(@"%@", responseDict);

    NSDictionary *dataSummaryDict;

    switch (request.tag) {
        case SERVER_GET_DRIVE_DATA:
            {
                dataSummaryDict = [[responseDict valueForKey:@"data"] valueForKey:@"dataSummary"][0];
                LCDriveData *driveData = [[LCDriveData alloc] initWithDictionary:dataSummaryDict];

                NSMutableArray  *drivePieces = [NSMutableArray array];
                NSArray         *dataPieceDictArray = [[responseDict valueForKey:@"data"] valueForKey:@"dataPieces"][0];

                for (id dataPieceDict in dataPieceDictArray) {
                    LCDrivePiece *drivePiece = [[LCDrivePiece alloc] initWithDictionary:dataPieceDict];
                    [drivePieces addObject:drivePiece];
                }

                [self.delegate onGetDriveDataSuccess:@{@"dataSummary": driveData, @"dataPieces": drivePieces}];
                break;
            }

        case SERVER_UPLOAD:
            {
                [self.delegate onUploadDataSucess:responseDict];
                break;
            }

        default:
            {
                break;
            }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    switch (request.tag) {
        case SERVER_GET_DRIVE_DATA:
            [self.delegate onGetDriveDataFail];
            break;

        case SERVER_UPLOAD:
            [self.delegate onUploadDataFail];
            break;

        default:
            break;
    }
}

@end
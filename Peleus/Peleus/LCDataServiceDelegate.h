//
//  LCDataServiceDelegate.h
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LCDataServiceDelegate <NSObject>

/*
 获取配置
 */
- (void)onGetConfigSuccess:(NSDictionary*) config;
- (void)onGetConfigFail;

/*
 同步数据
 */
- (void)onSyncDataSuccess:(NSDictionary*) data;
- (void)onSyncDataFail;

/*
 上传数据
 */
- (void)onUploadDataSucess:(NSDictionary*) callback;
- (void)onUploadDataFail;

@end

//
//  LCDataConfig.h
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#ifndef LCDATACONFIG
#define LCDATACONFIG

#pragma mark - OBD Config

#define COP_OBD_SERVER          @"localhost"
#define COP_OBD_USER            @"nobody"
#define COP_OBD_PWD             @"xampp"

#define OBD_CMD_CONFIG_GET      @"config-get"
#define OBD_CMD_PARAM_PUSH      @"param-push"
#define OBD_CMD_PARAM_DEL       @"param-del"
#define OBD_CMD_IDX_GET         @"idx-get"
#define OBD_CMD_IDX_DEL         @"idx-del"
#define OBD_CMD_IDX_PUSH        @"idx-push"
#define OBD_CMD_DATA_GET        @"data-get"

#define OBD_PATH_IDX            @"/data/index"
#define OBD_PATH_DATA           @"/data"
#define OBD_PATH_CONFIG         @"/config.in"
#define OBD_PATH_PARAM          @"/param.in"

#pragma mark - Server Config

#define COP_BIZ_SERVER          @"58.210.101.202:59102"
#define UA						@"mapi 1.0 peseus 1.0.0 motorola MB525 Android 2.3.5"
#define TOKEN					@"6c25e31d8fda33258dcfcc2046ba5121e0c78784e32032bd06a8bd2b3d96cb72"

#pragma mark - Api Config

// 账户
#define API_ACCOUNT_BOUND       @"http://58.210.101.202:59102/argus/account/bound"
#define API_ACCOUNT_REBOUND     @"http://58.210.101.202:59102/argus/account/rebound"
#define API_ACCOUNT_UPDATE      @"http://58.210.101.202:59102/argus/account/update"
#define API_ACCOUNT_UPLOAD      @"http://58.210.101.202:59102/argus/account/upload"
// 行程数据
#define API_MYCAR_GET           @"http://58.210.101.202:59102/argus/mycar/get"
#define API_MYCAR_UPLOAD        @"http://58.210.101.202:59102/argus/mycar/upload"
// 加油账单
#define API_FUELBILL_GET        @"http://58.210.101.202:59102/argus/fuelbill/get"
#define API_FUELBILL_ADD        @"http://58.210.101.202:59102/argus/fuelbill/add"
#define API_FUELBILL_UPATE      @"http://58.210.101.202:59102/argus/fuelbill/update"
#define API_FUELBILL_DELETE     @"http://58.210.101.202:59102/argus/fuelbill/delete"
// 其他
#define API_OTHER_CONFIG        @"http://58.210.101.202:59102/argus/other/config"
#define API_OTHER_FEEDBACK      @"http://58.210.101.202:59102/argus/other/feedback"


#define SERVER_GET_DRIVE_DATA 1000

#define SERVER_UPLOAD		  2000

#pragma mark - Singleton

#define LCSINGLETON_IN_H(classname) \
+ (id)sharedInstance;

#define LCSINGLETON_IN_M(classname) \
\
__strong static id _shared##classname = nil; \
\
+ (id)sharedInstance { \
@synchronized(self) \
{ \
if (_shared##classname == nil) \
{ \
_shared##classname = [[super allocWithZone:NULL] init]; \
} \
} \
return _shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
return [self sharedInstance]; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

#endif	// End of File
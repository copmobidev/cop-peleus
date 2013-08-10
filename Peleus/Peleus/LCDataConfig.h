//
//  LCDataConfig.h
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#ifndef LCDataConfig_h
#define LCDataConfig_h


#pragma mark - OBD Ftp Config

#define COP_OBD_SERVER      @"localhost"
#define COP_OBD_USER        @"nobody"
#define COP_OBD_PWD         @""


#pragma mark - Biz Server Config

#define COP_BIZ_SERVER      @"http://58.210.101.202:59102"
#define COP_BIZ_API_BOUND	@"/argus/account/bound"
#define TOKEN				@"6c25e31d8fda33258dcfcc2046ba5121e0c78784e32032bd06a8bd2b3d96cb72"
#define UA					@"MApi 1.0 achilles 1.0.0 IPhone 4S IOS 6.0"


#pragma mark - Singleton Config

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

#endif
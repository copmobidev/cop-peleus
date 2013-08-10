//
//  LCDataConfig.h
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#ifndef LCDataConfig_h
#define LCDataConfig_h
//host is only host part, do not include protocol , port and detail path

//#define COP_BIZ_SERVER      @"58.210.101.202:59102"

#define COP_BIZ_SERVER      @"58.210.101.202"
#define COP_OBD_SERVER      @"192.168.111.1"
#define COP_OBD_USER        @"anybody"
#define COP_OBD_PWD         @""


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
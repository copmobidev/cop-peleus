//
//  LCDataConfig.h
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//
//host is only host part, do not include protocol , port and detail path

//#define COP_BIZ_SERVER      @"58.210.101.202:59102"

#define COP_BIZ_SERVER          @"58.210.101.202"
#define COP_OBD_SERVER          @"192.168.1.151"
#define COP_OBD_USER            @"nobody"
#define COP_OBD_PWD             @"xampp"
#define UA						@"mapi 1.0 peseus 1.0.0 motorola MB525 Android 2.3.5"
#define TOKEN					@"6c25e31d8fda33258dcfcc2046ba5121e0c78784e32032bd06a8bd2b3d96cb72"


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

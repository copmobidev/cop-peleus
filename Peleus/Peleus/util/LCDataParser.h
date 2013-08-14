//
//  LCDataParser.h
//  core
//
//  Created by chris.liu on 5/31/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCDriveData;

@interface LCDataParser : NSObject

+ (NSDictionary *)parseOBDConfig:(NSString *) config;
+ (LCDriveData *)parseDriveData:(NSString *) data;


@end

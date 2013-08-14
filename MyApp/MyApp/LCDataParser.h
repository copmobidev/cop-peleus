//
//  LCDataParser.h
//  MyApp
//
//  Created by chris.liu on 8/1/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDriveData.h"
#import "LCDrivePiece.h"


@interface LCDataParser : NSObject


+ (void)parseDriveData:(NSString *) data;
+ (NSDictionary *)parseOBDConfig:(NSString*) data;

@end

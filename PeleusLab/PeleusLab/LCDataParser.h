//
//  LCDataParser.h
//  data-parser
//
//  Created by ChrisLiu  on 5/19/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCDriveRoute;
@class LCDrivingPiece;
@class LCDriveSummary;

@interface LCDataParser : NSObject

+ (LCDriveRoute*)parseDriveData:(NSString*) data;
+ (LCDrivingPiece*)parseDrivingPiece:(NSString*) data;
+ (LCDriveSummary*)parseDriveSummary:(NSString*)data;

+ (char)hex2char:(NSString *) hex;
+ (int)hex2int:(NSString *) hex;

@end

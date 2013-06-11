//
//  LCDriveData.h
//  core
//
//  Created by chris.liu on 6/1/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LCDriveSummary;

@interface LCDriveData : NSObject

@property (nonatomic, strong) LCDriveSummary    *summary;
@property (nonatomic, strong) NSMutableArray    *pieces;

@end
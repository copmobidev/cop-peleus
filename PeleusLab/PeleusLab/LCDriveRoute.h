//
//  LCDriveRoute.h
//  data-parser
//
//  Created by chris.liu on 5/28/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDriveSummary.h"

@interface LCDriveRoute : NSObject

@property (nonatomic, strong) LCDriveSummary* summary;
@property (nonatomic, strong) NSMutableArray* pieces;

@end

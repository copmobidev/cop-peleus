//
//  LCTimestamp.h
//  core
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _LCSpan
{
    TRACK, 
    WEEK, 
    MONTH, 
    YEAR 
} LCSpan;

@interface LCTimestamp : NSObject

@property (nonatomic, readwrite) LCSpan span;
@property (nonatomic, readwrite) long beginTime;
@property (nonatomic, readwrite) long endTime;

@end

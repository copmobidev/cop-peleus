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
    TRACK, // 单词行程,最小统计切片（default via min，当单次行程时间较长时适当合并行程）
    WEEK, // 周,最小统计切片为日
    MONTH, // 月,最小统计切片为日
    YEAR // 按年,最小统计切片为月
} LCSpan; // 统计跨度

@interface LCTimestamp : NSObject

@property (nonatomic, readwrite) LCSpan span;
@property (nonatomic, readwrite) long beginTime;
@property (nonatomic, readwrite) long endTime;

@end

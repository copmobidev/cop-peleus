//
//  LCDriveSummary.h
//  data-parser
//
//  Created by chris.liu on 5/28/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCDriveSummary : NSObject

@property (nonatomic, assign, readwrite) long timestamp; // 行程时间戳
@property (nonatomic, assign, readwrite) long startTime; // 起始时间
@property (nonatomic, assign, readwrite) double startLat; // 起始纬度
@property (nonatomic, assign, readwrite) char startDir1; // 起始方向（东西）
@property (nonatomic, assign, readwrite) double startLng; // 起始经度
@property (nonatomic, assign, readwrite) char startDir2; // 起始方向（南北）
@property (nonatomic, assign, readwrite) int startEle; // 其实海拔
@property (nonatomic, assign, readwrite) long endTime; // 结束时间
@property (nonatomic, assign, readwrite) double endLat; // 结束纬度
@property (nonatomic, assign, readwrite) char endDir1; // 结束方向（东西）
@property (nonatomic, assign, readwrite) double endLng; // 结束经度
@property (nonatomic, assign, readwrite) char endDir2; // 结束方向（南北）
@property (nonatomic, assign, readwrite) int endEle; // 结束海拔
@property (nonatomic, assign, readwrite) int time; // 总时间
@property (nonatomic, assign, readwrite) int airPressure; // 环境气压
@property (nonatomic, assign, readwrite) int fuelLV; // 油量
@property (nonatomic, assign, readwrite) int bat; // 电池电量
@property (nonatomic, assign, readwrite) int temp;
@property (nonatomic, assign, readwrite) int dist;
@property (nonatomic, assign, readwrite) int maxSPD;
@property (nonatomic, assign, readwrite) int bstFuel;
@property (nonatomic, assign, readwrite) int avgSPD;
@property (nonatomic, assign, readwrite) int avgFuel;
@property (nonatomic, assign, readwrite) int totalFuel;
@property (nonatomic, assign, readwrite) int lstFuelLV;
@property (nonatomic, assign, readwrite) int acc;
@property (nonatomic, assign, readwrite) int brk;
@property (nonatomic, assign, readwrite) int overSPD;
@property (nonatomic, assign, readwrite) int idleSPD;
@property (nonatomic, assign, readwrite) int sliding;
@property (nonatomic, assign, readwrite) int fastRate;
@property (nonatomic, assign, readwrite) int slowRate;
@property (nonatomic, assign, readwrite) int jamRate;
@property (nonatomic, strong) NSString* errorCodes;

@end

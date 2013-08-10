//
//  LCDriveSummary.h
//  Peleus
//
//  Created by chris.liu on 5/21/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCDriveSummary : NSObject

@property (nonatomic, readwrite) long beginTime; // 开始时间
@property (nonatomic, readwrite) double beginLat; // 开始纬度
@property (nonatomic, readwrite) double beginLng; // 开始经度
@property (nonatomic, readwrite) double beginEle; // 行程开始海拔
@property (nonatomic, readwrite) long endTime; // 结束时间
@property (nonatomic, readwrite) double endLat; // 结束纬度
@property (nonatomic, readwrite) double endLng; // 结束经度
@property (nonatomic, readwrite) double endEle; // 行程结束海拔
@property (nonatomic, readwrite) double dist; // 行程总里程
@property (nonatomic, readwrite) double fuel; // 行程总耗油量
@property (nonatomic, readwrite) int errDist; // 故障灯亮起后行驶里程数,最大65535
@property (nonatomic, readwrite) int clrDist; // 故障码清除后行驶里程数,最大65535
@property (nonatomic, readwrite) double maxSPD; // 行程最高速度
@property (nonatomic, readwrite) double bstSPD; // 行程最佳速度
@property (nonatomic, readwrite) double avgFuel; // 行程平均油耗
@property (nonatomic, readwrite) double bstFeul; // 行程最佳速度
@property (nonatomic, readwrite) int FuelLV; // 油量，最高位为是否加油标志
@property (nonatomic, readwrite) double lstFuelLV; // 最后一分钟油箱存量
@property (nonatomic, readwrite) double bat; // 电池电量 BAT/10
@property (nonatomic, readwrite) int airPressure; // 环境气压
@property (nonatomic, readwrite) double temp; // 环境温度
@property (nonatomic, readwrite) double avgCoolTemp; // 平均水箱温度
@property (nonatomic, readwrite) double maxCoolTemp; // 最高水箱温度
@property (nonatomic, readwrite) double avgPadPos; // 节气门位置平均值
@property (nonatomic, readwrite) double maxPadPos; // 节气门位置最大值
@property (nonatomic, readwrite) double minPadPos; // 节气门位置最小值
@property (nonatomic, readwrite) double avgRPM; // 平均转速
@property (nonatomic, readwrite) double maxRPM; // 最高转速
@property (nonatomic, readwrite) int acc; // 行程总急加速次数
@property (nonatomic, readwrite) int brk; // 行程总急刹车次数
@property (nonatomic, readwrite) double overSPD; // 行程总超速时间百分比
@property (nonatomic, readwrite) double idleSPD; // 行程总怠速时间百分比
@property (nonatomic, readwrite) double sliding; // 行程总滑行时间百分比
@property (nonatomic, readwrite) double fast; // 本次行程顺畅的时间比率
@property (nonatomic, readwrite) double slow; // 本次行程缓慢的时间比率
@property (nonatomic, readwrite) double jam; // 本次行程堵车的时间比率(包含怠速）
@property (nonatomic, readwrite) NSString* errCodes; // 错误码
@property (nonatomic, readwrite) NSString* minuteData; // 每分钟行程数据
@property (nonatomic, readwrite) double score; // 行程得分

@end
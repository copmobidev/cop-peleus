//
//  LCDriveData.h
//  MyApp
//
//  Created by chris.liu on 8/1/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface LCDriveData : Jastor

/* property根据json结构列举 */

@property (nonatomic, readwrite) NSNumber *acc; // 行程总急加速次数
@property (nonatomic, readwrite) NSNumber *avgCoolTemp; // 平均水箱温度
@property (nonatomic, readwrite) NSString *avgFuel; // 行程平均油耗
@property (nonatomic, readwrite) NSNumber *avgPadPos; // 节气门位置平均值
@property (nonatomic, readwrite) NSNumber *avgRPM; // 平均转速
@property (nonatomic, readwrite) NSString *avgSPD;
@property (nonatomic, readwrite) NSNumber *beginEle; // 行程开始海拔
@property (nonatomic, readwrite) NSNumber *brk; // 行程总急刹车次数
@property (nonatomic, readwrite) NSNumber *bstFuel; // 行程最佳速度
@property (nonatomic, readwrite) NSNumber *bstSPD; // 行程最佳速度
@property (nonatomic, readwrite) NSNumber *count;
@property (nonatomic, readwrite) NSNumber *dist; // 行程总里程
@property (nonatomic, readwrite) NSNumber *endTime; // 结束时间
@property (nonatomic, readwrite) NSNumber *fast; // 本次行程顺畅的时间比率
@property (nonatomic, readwrite) NSNumber *fuel; // 行程总耗油量
@property (nonatomic, readwrite) NSNumber *idleSPD; // 行程总怠速时间百分比
@property (nonatomic, readwrite) NSNumber *jam; // 本次行程堵车的时间比率(包含怠速）
@property (nonatomic, readwrite) NSNumber *maxPadPos; // 节气门位置最大值
@property (nonatomic, readwrite) NSNumber *maxSPD; // 行程最高速度
@property (nonatomic, readwrite) NSNumber *overSPD; // 行程总超速时间百分比
@property (nonatomic, readwrite) NSNumber *sliding; // 行程总滑行时间百分比
@property (nonatomic, readwrite) NSNumber *slow; // 本次行程缓慢的时间比率
@property (nonatomic, readwrite) NSNumber *temp; // 环境温度
@property (nonatomic, readwrite) NSNumber *timeSpace;


//@property (nonatomic, readwrite) NSNumber *errDist; // 故障灯亮起后行驶里程数,最大65535
//@property (nonatomic, readwrite) NSNumber *clrDist; // 故障码清除后行驶里程数,最大65535
//@property (nonatomic, readwrite) NSNumber *FuelLV; // 油量，最高位为是否加油标志
//@property (nonatomic, readwrite) NSNumber *lstFuelLV; // 最后一分钟油箱存量
//@property (nonatomic, readwrite) NSNumber *bat; // 电池电量 BAT/10
//@property (nonatomic, readwrite) NSNumber *airPressure; // 环境气压
//@property (nonatomic, readwrite) NSNumber *maxCoolTemp; // 最高水箱温度
//@property (nonatomic, readwrite) NSNumber *minPadPos; // 节气门位置最小值
//@property (nonatomic, readwrite) NSNumber *maxRPM; // 最高转速
//@property (nonatomic, readwrite) NSString *errCodes; // 错误码
//@property (nonatomic, readwrite) NSString *minuteData; // 每分钟行程数据
//@property (nonatomic, readwrite) NSNumber *score; // 行程得分
//@property (nonatomic, readwrite) NSNumber *beginTime; // 开始时间
//@property (nonatomic, readwrite) NSNumber *beginLat; // 开始纬度
//@property (nonatomic, readwrite) NSNumber *beginLng; // 开始经度

//@property (nonatomic, readwrite) NSNumber *endLat; // 结束纬度
//@property (nonatomic, readwrite) NSNumber *endLng; // 结束经度
//@property (nonatomic, readwrite) NSNumber *endEle; // 行程结束海拔

@end

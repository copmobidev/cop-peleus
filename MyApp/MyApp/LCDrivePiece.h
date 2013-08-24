//
//  LCDrivePiece.h
//  MyApp
//
//  Created by chris.liu on 8/1/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCDrivePiece : NSObject

@property (nonatomic, readwrite) long timestamp; // 时间戳
@property (nonatomic, readwrite) double lat; // 纬度
@property (nonatomic, readwrite) double lng; // 经度
@property (nonatomic, readwrite) char dir1, dir2;
@property (nonatomic, readwrite) int ele; // 海拔
@property (nonatomic, readwrite) int dist; // 里程
@property (nonatomic, readwrite) double fuel; // 该分钟耗油量
@property (nonatomic, readwrite) double bstFuel; // 最低油耗
@property (nonatomic, readwrite) double avgFeul; // 平均油耗
@property (nonatomic, readwrite) double maxSPD; // 最高速度
@property (nonatomic, readwrite) double bstSPD; // 最佳速度
@property (nonatomic, readwrite) double avgSPD; // 平均速度
@property (nonatomic, readwrite) double avgRPM; // 平均转速
@property (nonatomic, readwrite) double maxRPM; // 最大转速
@property (nonatomic, readwrite) double avgCalLoad; // 平均负载
@property (nonatomic, readwrite) double avgCoolTemp; // 平均水箱温度
@property (nonatomic, readwrite) double avgPadPos; // 节气门位置平均值
@property (nonatomic, readwrite) double maxPadPos; // 节气门位置最大值
@property (nonatomic, readwrite) double minPadPos; // 节气门位置最小值
@property (nonatomic, readwrite) double fuelLV; // 油箱存量
@property (nonatomic, readwrite) int acc; // 急加速次数
@property (nonatomic, readwrite) int brk; // 急刹车次数
@property (nonatomic, readwrite) double overSPD; // 超速时间
@property (nonatomic, readwrite) double idleSPD; // 怠速时间
@property (nonatomic, readwrite) double sliding; // 滑行时间
@property (nonatomic, readwrite) double score; // 行程切片得分


@end

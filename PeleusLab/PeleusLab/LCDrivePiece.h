//
//  LCDrivePiece.h
//  data-parser
//
//  Created by chris.liu on 5/20/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCDrivePiece : NSObject

@property (nonatomic, assign, readwrite) double timestamp; // 时间戳
@property (nonatomic, assign, readwrite) double lat; // 纬度
@property (nonatomic, assign, readwrite) char dir1; // 方向（南/北）
@property (nonatomic, assign, readwrite) double lng; // 经度
@property (nonatomic, assign, readwrite) char dir2; // 方向（东/西）
@property (nonatomic, assign, readwrite) int ele; // 海拔
@property (nonatomic, assign, readwrite) int maxSPD; // 最高时速
@property (nonatomic, assign, readwrite) int bstFuel; // 最佳油耗
@property (nonatomic, assign, readwrite) int dist; // 里程
@property (nonatomic, assign, readwrite) int avgSPD; // 平均速度
@property (nonatomic, assign, readwrite) int avgRPM; // 平均转速
@property (nonatomic, assign, readwrite) int avgFuel; // 最低油耗
@property (nonatomic, assign, readwrite) int totalFuel; // 总油耗
@property (nonatomic, assign, readwrite) int calLoad; // 平均负载
@property (nonatomic, assign, readwrite) int coolTemp; // 水箱温度
@property (nonatomic, assign, readwrite) int avgPadPos; // 平均节气门位置
@property (nonatomic, assign, readwrite) int maxPadPos; // 最大节气门位置
@property (nonatomic, assign, readwrite) int minPadPos; // 最小节气门位置
@property (nonatomic, assign, readwrite) int fuelLV; // 邮箱存量
@property (nonatomic, assign, readwrite) int acc; // 加速次数
@property (nonatomic, assign, readwrite) int brk; // 刹车次数
@property (nonatomic, assign, readwrite) int overSPD; // 超速时间比
@property (nonatomic, assign, readwrite) int idleSPD; // 怠速时间比
@property (nonatomic, assign, readwrite) int sliding; // 滑行时间比

@end

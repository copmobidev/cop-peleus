//
//  LCDrivePiece.h
//  MyApp
//
//  Created by chris.liu on 8/1/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface LCDrivePiece : Jastor

@property (nonatomic, readwrite) NSNumber *timestamp; // 时间戳
@property (nonatomic, readwrite) NSNumber *lat; // 纬度
@property (nonatomic, readwrite) NSNumber *lng; // 经度
@property (nonatomic, readwrite) NSString *dir1;
@property (nonatomic, readwrite) NSString *dir2;
@property (nonatomic, readwrite) NSNumber *ele; // 海拔
@property (nonatomic, readwrite) NSNumber *dist; // 里程
@property (nonatomic, readwrite) NSNumber *fuel; // 该分钟耗油量
@property (nonatomic, readwrite) NSNumber *bstFuel; // 最低油耗
@property (nonatomic, readwrite) NSNumber *avgFeul; // 平均油耗
@property (nonatomic, readwrite) NSNumber *maxSPD; // 最高速度
@property (nonatomic, readwrite) NSNumber *bstSPD; // 最佳速度
@property (nonatomic, readwrite) NSNumber *avgSPD; // 平均速度
@property (nonatomic, readwrite) NSNumber *avgRPM; // 平均转速
@property (nonatomic, readwrite) NSNumber *maxRPM; // 最大转速
@property (nonatomic, readwrite) NSNumber *avgCalLoad; // 平均负载
@property (nonatomic, readwrite) NSNumber *avgCoolTemp; // 平均水箱温度
@property (nonatomic, readwrite) NSNumber *avgPadPos; // 节气门位置平均值
@property (nonatomic, readwrite) NSNumber *maxPadPos; // 节气门位置最大值
@property (nonatomic, readwrite) NSNumber *minPadPos; // 节气门位置最小值
@property (nonatomic, readwrite) NSNumber *fuelLV; // 油箱存量
@property (nonatomic, readwrite) NSNumber *acc; // 急加速次数
@property (nonatomic, readwrite) NSNumber *brk; // 急刹车次数
@property (nonatomic, readwrite) NSNumber *overSPD; // 超速时间
@property (nonatomic, readwrite) NSNumber *idleSPD; // 怠速时间
@property (nonatomic, readwrite) NSNumber *sliding; // 滑行时间
@property (nonatomic, readwrite) NSNumber *score; // 行程切片得分

@end

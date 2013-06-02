//
//  LCDataParser.m
//  data-parser
//
//  Created by ChrisLiu  on 5/19/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCDataParser.h"
#import "LCDriveRoute.h"
#import "LCDrivePiece.h"

@implementation LCDataParser

+ (LCDriveRoute*)parseDriveData:(NSString*) data
{
    LCDriveRoute* driveRoute = [[LCDriveRoute alloc] init];
    
    long piece_num = data.length / 80 -1;
    NSRange range;
    range.location = 0;
    range.length = 80;
    for (int i=0; i<piece_num; ++i)
    {
        range.location = i * 80;
        NSString* piece = [data substringWithRange:range];
        NSLog(@"%@", piece);
    }
    NSString* summary = [data substringFromIndex:piece_num * 80];
    NSLog(@"%@", summary);
    return driveRoute;
}

+ (LCDrivePiece* )parseDrivingPiece:(NSString*) data
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    
    LCDrivePiece* drivePiece = [[LCDrivePiece alloc] init];
    int year = 0, month = 0, day = 0;
    int hour = 0, minute = 0, second = 0;
    NSRange range;
    range.length = 2;
    for(int i=0; i<[data length]; i+=2)
    {
        range.location = i;
        NSString* hex = [data substringWithRange:range];
        switch (i) {
            case 0: // 数据类型
            case 2: // 后续字节数
                break;
            case 4: // 年
                year = [self hex2int:hex];
                break;
            case 6: // 月
                month = [self hex2int:hex];
                break;
            case 8: // 日
                day = [self hex2int:hex];
                break;
            case 10: // 小时
                hour = [self hex2int:hex];
                break;
            case 12: // 分钟
                minute = [self hex2int:hex];
                break;
            case 14: // 秒
            {
                second = [self hex2int:hex];
                NSString *curDateStr = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d", year, month, day, hour, minute, second];
                NSDate *date = [dateFormat dateFromString:curDateStr];
                drivePiece.timestamp = [date timeIntervalSince1970];
                break;
            }
            case 16: // 纬度DD
                drivePiece.lat = [self hex2int:hex];
                break;
            case 18: // 纬度MM
                drivePiece.lat += [self hex2int:hex] / 100.0;
                break;
            case 20: // 纬度MM
                drivePiece.lat += [self hex2int:hex] / 10000.0;
                break;
            case 22: // 纬度MM
                drivePiece.lat += [self hex2int:hex] / 1000000.0;
                break;
            case 24: // dir1
                drivePiece.dir1 = [self hex2char:hex];
                break;
            case 26: // 经度0D
                drivePiece.lng = [self hex2int:hex] * 100.0;
                break;
            case 28: // 经度DD
                drivePiece.lng += [self hex2int:hex];
                break;
            case 30: // 经度MM
                drivePiece.lng += [self hex2int:hex] / 100.0;
                break;
            case 32: // 经度MM
                drivePiece.lng += [self hex2int:hex] / 10000.0;
                break;
            case 34: // 经度MM
                drivePiece.lng += [self hex2int:hex] / 1000000.0;
                break;
            case 36: // dir2
                drivePiece.dir2 = [self hex2char:hex];
                break;
            case 38: // 海拔
                drivePiece.ele = [self hex2int:hex];
                break;
            case 40: // 最高速度
                drivePiece.maxSPD = [self hex2int:hex];
                break;
            case 42: // 最低油耗
                drivePiece.bstFuel = [self hex2int:hex];
                break;
            case 44: // 里程 DIST_H
                drivePiece.dist = [self hex2int:hex];
                break;
            case 46: // 里程 DIST_L
                drivePiece.dist += [self hex2int:hex];
                break;
            case 48: // 平均速度
                drivePiece.avgSPD = [self hex2int:hex];
                break;
            case 50: // 平均转速 AVG_RPM_H
                drivePiece.avgRPM = [self hex2int:hex];
                break;
            case 52: // 平均转速 AVG_RPM_L
                drivePiece.avgRPM += [self hex2int:hex];
                break;
            case 54: // 平均油耗
                drivePiece.avgFuel = [self hex2int:hex];
                break;
            case 56: // 总油耗
                drivePiece.totalFuel = [self hex2int:hex];
                break;
            case 58: // 平均负载
                drivePiece.calLoad = [self hex2int:hex];
                break;
            case 60: // 平均水箱温度
                drivePiece.coolTemp = [self hex2int:hex];
                break;
            case 62: // 节气门平均值
                drivePiece.avgPadPos = [self hex2int:hex];
                break;
            case 64: // 节气门最大值
                drivePiece.maxPadPos = [self hex2int:hex];
                break;
            case 66: // 节气门最小值
                drivePiece.minPadPos = [self hex2int:hex];
                break;
            case 68: // 邮箱存量
                drivePiece.fuelLV = [self hex2int:hex];
                break;
            case 70: // 加速次数
                drivePiece.acc = [self hex2int:hex];
                break;
            case 72: // 刹车次数
                drivePiece.brk = [self hex2int:hex];
                break;
            case 74: // 超速时间比
                drivePiece.overSPD = [self hex2int:hex];
                break;
            case 76: // 怠速时间比
                drivePiece.idleSPD = [self hex2int:hex];
                break;
            case 78: // 滑行时间比
                drivePiece.sliding = [self hex2int:hex];
                break;
            default:
                break;
        }
    }
    return drivePiece;
}

+ (LCDriveSummary*)parseDriveSummary:(NSString*)data
{
    LCDriveSummary* driveSummary = [[LCDriveSummary alloc] init];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yy-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式
    
    int year = 0, month = 0, day = 0;
    int hour = 0, minute = 0, second = 0;
    NSRange range;
    range.length = 2;
    for(int i=0; i<[data length]; i+=2)
    {
        range.location = i;
        NSString* hex = [data substringWithRange:range];
        switch (i) {
            case 0: // 数据类型
            case 2: // 后续字节数
                break;
            case 4: // 年
                year = [self hex2int:hex];
                break;
            case 6: // 月
                month = [self hex2int:hex];
                break;
            case 8: // 日
                day = [self hex2int:hex];
                break;
            case 10: // 小时
                hour = [self hex2int:hex];
                break;
            case 12: // 分钟
                minute = [self hex2int:hex];
                break;
            case 14: // 秒
            {
                second = [self hex2int:hex];
                NSString *curDateStr = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d",
                                        year, month, day, hour, minute, second];
                NSDate *date = [dateFormat dateFromString:curDateStr];
                driveSummary.timestamp = [date timeIntervalSince1970];
                driveSummary.startTime = [date timeIntervalSince1970];
                break;
            }
            case 16: // 纬度DD
                driveSummary.startLat = [self hex2int:hex];
                break;
            case 18: // 纬度MM
                driveSummary.startLat += [self hex2int:hex] / 100.0;
                break;
            case 20: // 纬度MM
                driveSummary.startLat += [self hex2int:hex] / 10000.0;
                break;
            case 22: // 纬度MM
                driveSummary.startLat += [self hex2int:hex] / 1000000.0;
                break;
            case 24: // dir1
                driveSummary.startDir1 = [self hex2char:hex];
                break;
            case 26: // 经度0D
                driveSummary.startLng = [self hex2int:hex] * 100.0;
                break;
            case 28: // 经度DD
                driveSummary.startLng += [self hex2int:hex];
                break;
            case 30: // 经度MM
                driveSummary.startLng += [self hex2int:hex] / 100.0;
                break;
            case 32: // 经度MM
                driveSummary.startLng += [self hex2int:hex] / 10000.0;
                break;
            case 34: // 经度MM
                driveSummary.startLng += [self hex2int:hex] / 1000000.0;
                break;
            case 36: // dir2
                driveSummary.startDir2 = [self hex2char:hex];
                break;
            case 38: // 海拔
                driveSummary.startEle = [self hex2int:hex];
                break;
            case 40: 
                year = [self hex2int:hex];
                break;
            case 42:
                month = [self hex2int:hex];
                break;
            case 44:
                day = [self hex2int:hex];
                break;
            case 46: 
                hour = [self hex2int:hex];
                break;
            case 48: 
                minute = [self hex2int:hex];
                break;
            case 50:
            {
                second = [self hex2int:hex];
                NSString *curDateStr = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d",
                                        year, month, day, hour, minute, second];
                NSDate *date = [dateFormat dateFromString:curDateStr];
                driveSummary.endTime = [date timeIntervalSince1970];
                break;
            }
            case 52: 
                driveSummary.endLat = [self hex2int:hex];
                break;
            case 54:
                driveSummary.endLat += [self hex2int:hex] / 100.0;
                break;
            case 56: 
                driveSummary.endLat += [self hex2int:hex] / 10000.0;
                break;
            case 58: 
                driveSummary.endLat += [self hex2int:hex] / 1000000.0;
                break;
            case 60:
                driveSummary.endDir1 = [self hex2char:hex];
                break;
            case 62:
                driveSummary.endLng = [self hex2int:hex] * 100.0;
                break;
            case 64:
                driveSummary.endLng += [self hex2int:hex];
                break;
            case 66:
                driveSummary.endLng += [self hex2int:hex] / 100.0;
                break;
            case 68:
                driveSummary.endLng += [self hex2int:hex] / 10000.0;
                break;
            case 70:
                driveSummary.endLng += [self hex2int:hex] / 1000000.0;
                break;
            case 72:
                driveSummary.endDir2 = [self hex2char:hex];
                break;
            case 74:
                driveSummary.endEle = [self hex2int:hex];
                break;
            case 76:
                driveSummary.time = [self hex2int:hex];
                break;
            case 78:
                driveSummary.airPressure = [self hex2int:hex];
                break;
            case 80: 
                driveSummary.fuelLV = [self hex2int:hex];
                break;
            case 82:
                driveSummary.bat = [self hex2int:hex];
                break;
            case 84:
            case 86:
            case 88:
            case 90:
                break;
            case 92:
                driveSummary.temp = [self hex2int:hex];
                break;
            case 94:
                driveSummary.dist = [self hex2int:hex];
                break;
            case 96:
                driveSummary.dist += [self hex2int:hex];
                break;
            case 98:
                driveSummary.maxSPD = [self hex2int:hex];
                break;
            case 100:
                driveSummary.bstFuel = [self hex2int:hex];
                break;
            case 102:
                driveSummary.avgSPD = [self hex2int:hex];
                break;
            case 104:
                driveSummary.avgFuel = [self hex2int:hex];
                break;
            case 106:
            case 108:
                break;
            case 110:
                driveSummary.fuelLV = [self hex2int:hex];
                break;
            case 112:
                driveSummary.acc = [self hex2int:hex];
                break;
            case 114:
                driveSummary.brk = [self hex2int:hex];
                break;
            case 116:
                driveSummary.overSPD = [self hex2int:hex];
                break;
            case 118:
                driveSummary.idleSPD = [self hex2int:hex];
                break;
            case 120:
                driveSummary.sliding = [self hex2int:hex];
                break;
            case 122:
                driveSummary.fastRate = [self hex2int:hex];
                break;
            case 124:
                driveSummary.slowRate = [self hex2int:hex];
                break;
            case 126:
                driveSummary.jamRate = [self hex2int:hex];
                break;
            default:
                break;
        }
    }
    return driveSummary;
}

+ (char)hex2char:(NSString*) hex
{
    int value = 0;
    sscanf([hex cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
    return (char)value;
}

+ (int)hex2int:(NSString*) hex
{
    unichar hex_char1 = [hex characterAtIndex:0];
    unichar hex_char2 = [hex characterAtIndex:1];
    return [self char2int:hex_char1] * 16 + [self char2int:hex_char2];
}

+ (int)char2int:(char) ch
{
    int int_ch = -1;
    if(ch >= '0' && ch <= '9')
    {
        int_ch = (ch - 48); //// 0 的Ascll - 48
    }
    else if(ch >= 'A' && ch <='F')
    {
        int_ch = ch - 55; //// A 的Ascll - 65
    }
    else
    {
        int_ch = ch - 87; //// a 的Ascll - 97
    }
    return int_ch;
}

@end

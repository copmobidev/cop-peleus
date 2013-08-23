//
//  LCDataParser.m
//  core
//
//  Created by chris.liu on 5/31/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCDataParser.h"
#import "LCDriveData.h"
#import "LCDrivePiece.h"

@implementation LCDataParser

/*
 *   解析OBD配置文件
 */
+ (NSDictionary *)parseOBDConfig:(NSString *)config
{
    NSRange range;
    range.location = 86;
    range.length = 32;
    NSString *cid = [config substringWithRange:range];
    range.length = 2;
    NSLog(@"%@", config);
    int     length = [config length];
    char    tmp[length / 2];
    for (int i = 0; i < length / 2; ++i) {
        tmp[i] = 0;
    }
    for (int i = 0; i < length; i += 2) {
        range.location = i;
        NSString *hex = [config substringWithRange:range];
        tmp[i / 2] = [self hex2char:hex];
    }
    
    char    vinArray[17] = {0};
    char    obdArray[8] = {0};
    char    calidArray[8] = {0};
    for (int i = 0; i < length / 2; ++i) {
        if ((i > 16) && (i < 33)) {
            vinArray[i - 16] = tmp[i];
        } else if ((i > 33) && (i < 42)) {
            obdArray[i - 33] = tmp[i];
        } else if ((i > 111) && (i < 120)) {
            calidArray[i - 112] = tmp[i];
        }
    }
    NSString *vin = [NSString stringWithCString:vinArray encoding:NSASCIIStringEncoding];
    NSLog(@"vin:%s", vinArray);
    NSString *obd = [NSString stringWithCString:obdArray encoding:NSASCIIStringEncoding];
    NSLog(@"obd:%s", obdArray);
    NSString *calid = [NSString stringWithCString:calidArray encoding:NSASCIIStringEncoding];
    NSLog(@"calid:%s", calidArray);
    NSDictionary *dict = @{@"vin":vin, @"obd":obd, @"calid":calid, @"cid":cid};
    return dict;
}

/*
 *   解析行程数据
 */
/*
+ (LCDriveData *)parseDriveData:(NSString *)data
{
    int     piece_num = data.length / 90 - 1;
    NSRange range;

    range.location = 0;
    range.length = 90;

    for (int i = 0; i < piece_num; ++i) {
        range.location = i * 90;
        NSString        *piece = [data substringWithRange:range];
        LCDrivePiece    *drivePiece = [self parseDrivePiece:piece];
        NSLog(@"%f", drivePiece.maxSPD);
    }

    NSString    *summary = [data substringFromIndex:piece_num * 90];
    LCDriveData *driveData = [self parseDriveSummary:summary];
    driveData.minuteData = [data substringToIndex:piece_num * 90];
    NSLog(@"%f", driveData.maxSPD);
    return driveData;
}
*/
/*
 *   解析行程摘要数据
 */
/*
+ (LCDriveData *)parseDriveSummary:(NSString *)data
{
    LCDriveData     *driveData = [[LCDriveData alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];   // 实例化一个NSDateFormatter对象

    [dateFormat setDateFormat:@"yy-MM-dd HH:mm:ss"];                // 设定时间格式,这里可以设置成自己需要的格式

    int     year = 0, month = 0, day = 0;
    int     hour = 0, minute = 0, second = 0;
    double  lat = 0.0, lng = 0.0;
    int     ele = 0, dist = 0, errDist = 0, clrDist = 0, fuel = 0, avgFeul = 0, avgRPM = 0, maxRPM = 0;
    NSRange range;
    range.length = 2;

    for (int i = 0; i < [data length]; i += 2) {
        range.location = i;
        NSString *hex = [data substringWithRange:range];
        switch (i) {
            case 0: // 数据类型
            case 2: // 后续字节数
                break;

            case 4: // 年
                year = [hex integerValue];
                break;

            case 6: // 月
                month = [hex integerValue];
                break;

            case 8: // 日
                day = [hex integerValue];
                break;

            case 10: // 小时
                hour = [hex integerValue];
                break;

            case 12: // 分钟
                minute = [hex integerValue];
                break;

            case 14: // 秒
                {
                    second = [hex integerValue];
                    NSString *dateStr = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d",
                        year, month, day, hour, minute, second];
                    NSDate *date = [dateFormat dateFromString:dateStr];
                    driveData.beginTime = [date timeIntervalSince1970];
                    break;
                }

            case 16:
                lat = [hex integerValue];
                break;

            case 18:
                lat += [hex integerValue] / 100.0;
                break;

            case 20:
                lat += [hex integerValue] / 10000.0;
                break;

            case 22:
                lat += [hex integerValue] / 1000000.0;
                driveData.beginLat = lat;
                break;

            case 24:
                break;

            case 26:
                lng = [hex integerValue] * 100.0;
                break;

            case 28:
                lng += [hex integerValue];
                break;

            case 30:
                lng += [hex integerValue] / 100.0;
                break;

            case 32:
                lng += [hex integerValue] / 10000.0;
                break;

            case 34:
                lng += [hex integerValue] / 1000000.0;
                driveData.beginLng = lng;
                break;

            case 38:
                ele = [hex integerValue];
                break;

            case 40:
                ele = [hex integerValue] + ele * 100;
                driveData.beginEle = ele;
                break;

            case 42:
                year = [hex integerValue];
                break;

            case 44:
                month = [hex integerValue];
                break;

            case 46:
                day = [hex integerValue];
                break;

            case 48:
                hour = [hex integerValue];
                break;

            case 50:
                minute = [hex integerValue];
                break;

            case 52:
                {
                    second = [hex integerValue];
                    NSString *dateStr = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d",
                        year, month, day, hour, minute, second];
                    NSDate *date = [dateFormat dateFromString:dateStr];
                    driveData.endTime = [date timeIntervalSince1970];
                    break;
                }

            case 54:
                lat = [hex integerValue];
                break;

            case 56:
                lat += [hex integerValue] / 100.0;
                break;

            case 58:
                lat += [hex integerValue] / 10000.0;
                break;

            case 60:
                lat += [hex integerValue] / 1000000.0;
                driveData.endLat = lat;
                break;

            case 62:
                break;

            case 64:
                lng = [hex integerValue] * 100.0;
                break;

            case 66:
                lng += [hex integerValue];
                break;

            case 68:
                lng += [hex integerValue] / 100.0;
                break;

            case 70:
                lng += [hex integerValue] / 10000.0;
                break;

            case 72:
                lng += [hex integerValue] / 1000000.0;
                driveData.endLng = lng;
                break;

            case 74:
                break;

            case 76:
                ele = [hex integerValue];
                break;

            case 78:
                ele = [hex integerValue] + ele * 100;
                driveData.endEle = ele;
                break;

            case 80:
                break;

            case 82:
                driveData.airPressure = [self hex2int:hex];
                break;

            case 84:
                driveData.FuelLV = [self hex2int:hex];
                break;

            case 86:
                driveData.bat = [self hex2int:hex];
                break;

            case 88:
                errDist = [self hex2int:hex];
                break;

            case 90:
                errDist = [self hex2int:hex] + errDist * 256;
                driveData.errDist = errDist;
                break;

            case 92:
                clrDist = [self hex2int:hex];
                break;

            case 94:
                clrDist = [self hex2int:hex] + clrDist * 256;
                driveData.clrDist = clrDist;
                break;

            case 96:
                driveData.temp = [self hex2int:hex];
                break;

            case 98:
                dist = [self hex2int:hex];
                break;

            case 100:
                dist = [self hex2int:hex] + dist * 256;
                driveData.dist = dist;
                break;

            case 102:
                driveData.maxSPD = [self hex2int:hex];
                break;

            case 104:
                driveData.bstFeul = [self hex2int:hex];
                break;

            case 106:
                driveData.bstSPD = [self hex2int:hex];
                break;

            case 108:
                fuel = [self hex2int:hex];
                break;

            case 110:
                fuel = [self hex2int:hex] + fuel * 256;
                driveData.fuel = fuel;
                break;

            case 112:
                avgFeul = [self hex2int:hex];
                break;

            case 114:
                avgFeul = [self hex2int:hex] + fuel * 256;
                driveData.avgFuel = avgFeul;
                break;

            case 116:
                driveData.lstFuelLV = [self hex2int:hex];
                break;

            case 118:
                driveData.avgCoolTemp = [self hex2int:hex];
                break;

            case 120:
                driveData.maxCoolTemp = [self hex2int:hex];
                break;

            case 122:
                driveData.avgPadPos = [self hex2int:hex];
                break;

            case 124:
                driveData.maxPadPos = [self hex2int:hex];
                break;

            case 126:
                driveData.minPadPos = [self hex2int:hex];
                break;

            case 128:
                avgRPM = [self hex2int:hex];
                break;

            case 130:
                avgRPM = [self hex2int:hex] + avgRPM * 256;
                driveData.avgRPM = avgRPM;
                break;

            case 132:
                maxRPM = [self hex2int:hex];
                break;

            case 134:
                maxRPM = [self hex2int:hex] + maxRPM * 256;
                driveData.maxRPM = maxRPM;
                break;

            case 136:
                driveData.acc = [self hex2int:hex];
                break;

            case 138:
                driveData.brk = [self hex2int:hex];
                break;

            case 140:
                driveData.overSPD = [self hex2int:hex];
                break;

            case 144:
                driveData.idleSPD = [self hex2int:hex];
                break;

            case 146:
                driveData.sliding = [self hex2int:hex];
                break;

            case 148:
                driveData.fast = [self hex2int:hex];
                break;

            case 150:
                driveData.slow = [self hex2int:hex];
                break;

            case 152:
                driveData.jam = [self hex2int:hex];
                break;
        }
    }

    return driveData;
}

*/

/*
 *   解析行程切片数据
 */
/*
+ (LCDrivePiece *)parseDrivePiece:(NSString *)data
{
    LCDrivePiece    *drivePiece = [[LCDrivePiece alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];   // 实例化一个NSDateFormatter对象

    [dateFormat setDateFormat:@"yy-MM-dd HH:mm:ss"];                // 设定时间格式,这里可以设置成自己需要的格式

    int     year = 0, month = 0, day = 0;
    int     hour = 0, minute = 0, second = 0;
    double  lat = 0.0, lng = 0.0;
    int     ele = 0, dist = 0, avgFeul = 0, avgRPM = 0, maxRPM = 0;
    NSRange range;
    range.length = 2;

    for (int i = 0; i < [data length]; i += 2) {
        range.location = i;
        NSString *hex = [data substringWithRange:range];
        switch (i) {
            case 0: // 数据类型
            case 2: // 后续字节数
                break;

            case 4: // 年
                year = [hex integerValue];
                break;

            case 6: // 月
                month = [hex integerValue];
                break;

            case 8: // 日
                day = [hex integerValue];
                break;

            case 10: // 小时
                hour = [hex integerValue];
                break;

            case 12: // 分钟
                minute = [hex integerValue];
                break;

            case 14: // 秒
                {
                    second = [hex integerValue];
                    NSString *dateStr = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d",
                        year, month, day, hour, minute, second];
                    NSDate *date = [dateFormat dateFromString:dateStr];
                    drivePiece.timestamp = [date timeIntervalSince1970];
                    break;
                }

            case 16:
                lat = 0.0;
                lat = [hex integerValue];
                break;

            case 18:
                lat += [hex integerValue] / 100.0;
                break;

            case 20:
                lat += [hex integerValue] / 10000.0;
                break;

            case 22:
                lat += [hex integerValue] / 1000000.0;
                drivePiece.lat = lat;
                break;

            case 24:
                break;

            case 26:
                lng = [hex integerValue] * 100.0;
                break;

            case 28:
                lng += [hex integerValue];
                break;

            case 30:
                lng += [hex integerValue] / 100.0;
                break;

            case 32:
                lng += [hex integerValue] / 10000.0;
                break;

            case 34:
                lng += [hex integerValue] / 1000000.0;
                drivePiece.lng = lng;
                break;

            case 38:
                ele = [hex integerValue];
                break;

            case 40:
                ele = [hex integerValue] + ele * 100;
                drivePiece.ele = ele;
                break;

            case 42:
                drivePiece.maxSPD = [self hex2int:hex];
                break;

            case 44:
                drivePiece.bstFuel = [self hex2int:hex];
                break;

            case 46:
                drivePiece.bstSPD = [self hex2int:hex];
                break;

            case 48:
                dist = [self hex2int:hex];
                break;

            case 50:
                dist = [self hex2int:hex] + dist * 256;
                drivePiece.dist = dist;
                break;

            case 52:
                drivePiece.avgSPD = [self hex2int:hex];
                break;

            case 54:
                avgRPM = [self hex2int:hex];
                break;

            case 56:
                avgRPM = [self hex2int:hex] + avgRPM * 256;
                drivePiece.avgRPM = avgRPM;
                break;

            case 58:
                maxRPM = [self hex2int:hex];
                break;

            case 60:
                maxRPM = [self hex2int:hex] + maxRPM * 256;
                drivePiece.maxRPM = maxRPM;
                break;

            case 62:
                drivePiece.fuel = [self hex2int:hex];
                break;

            case 64:
                avgFeul = [self hex2int:hex];
                break;

            case 66:
                avgFeul = [self hex2int:hex] + avgFeul * 256;
                drivePiece.avgFeul = avgFeul;
                break;

            case 68:
                drivePiece.avgCalLoad = [self hex2int:hex];
                break;

            case 70:
                drivePiece.avgCoolTemp = [self hex2int:hex];
                break;

            case 72:
                drivePiece.avgPadPos = [self hex2int:hex];
                break;

            case 74:
                drivePiece.maxPadPos = [self hex2int:hex];
                break;

            case 76:
                drivePiece.minPadPos = [self hex2int:hex];
                break;

            case 78:
                drivePiece.fuelLV = [self hex2int:hex];
                break;

            case 80:
                drivePiece.acc = [self hex2int:hex];
                break;

            case 82:
                drivePiece.brk = [self hex2int:hex];
                break;

            case 84:
                drivePiece.overSPD = [self hex2int:hex];
                break;

            case 86:
                drivePiece.idleSPD = [self hex2int:hex];
                break;

            case 88:
                drivePiece.sliding = [self hex2int:hex];
                break;
        }
    }

    return drivePiece;
}
*/

+ (char)hex2char:(NSString *)hex
{
    @try {
        int value = 0;
        sscanf([hex cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        return (char)value;
    }
    @catch(NSException *exception) {
        return '0';
    }
}

+ (int)hex2int:(NSString *)hex
{
    @try {
        unichar hex_char1 = [hex characterAtIndex:0];
        unichar hex_char2 = [hex characterAtIndex:1];

        return [self char2int:hex_char1] * 16 + [self char2int:hex_char2];
    }
    @catch(NSException *exception) {
        return 0;
    }
}

+ (int)char2int:(char)ch
{
    @try {
        int int_ch = -1;

        if ((ch >= '0') && (ch <= '9')) {
            int_ch = (ch - 48); //// 0 的Ascll - 48
        } else if ((ch >= 'A') && (ch <= 'F')) {
            int_ch = ch - 55;   //// A 的Ascll - 65
        } else {
            int_ch = ch - 87;   //// a 的Ascll - 97
        }

        return int_ch;
    }
    @catch(NSException *exception) {
        return 0;
    }
}


/*
+ (double)score:(LCDrivePiece *)drivePiece withLevel:(int)level
{
    double score = 0.0;

    if (drivePiece.avgSPD < 120.0) {
        score = (144 - (120 - drivePiece.avgSPD) * (120 - drivePiece.avgSPD) / 100) * (drivePiece.sliding / 100) -
            (drivePiece.acc + drivePiece.brk) * (sqrt(level) + 1);
    } else {
        score = -(drivePiece.avgSPD - 120) * (drivePiece.avgSPD - 120) / 100 * (drivePiece.sliding / 100) -
            (drivePiece.acc + drivePiece.brk) * (sqrt(level) + 1);
    }

    score = score > 0.0 ? score : 0.0;
    return score;
}
 */

@end
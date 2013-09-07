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
+ (LCDriveData *)parseDriveData:(NSString *)data
{
    int     piece_num = data.length / 90 - 1;
    NSRange range;

    range.location = 0;
    range.length = 90;
    NSMutableArray *drivePieces = [[NSMutableArray alloc] init];
    for (int i = 0; i < piece_num; ++i) {
        range.location = i * 90;
        NSString        *piece = [data substringWithRange:range];
        LCDrivePiece    *drivePiece = [self parseDrivePiece:piece];
        [drivePieces addObject:drivePiece];
        NSLog(@"%@", drivePiece.maxSPD);
    }

    NSString    *summary = [data substringFromIndex:piece_num * 90];
    LCDriveData *driveData = [self parseDriveSummary:summary];
    NSLog(@"%@", driveData.maxSPD);
    driveData.drivePieces = drivePieces;
    return driveData;
}

/*
 *   解析行程摘要数据
 */
+ (LCDriveData *)parseDriveSummary:(NSString *)data
{
    LCDriveData     *driveData = [[LCDriveData alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];   // 实例化一个NSDateFormatter对象

    [dateFormat setDateFormat:@"yy-MM-dd HH:mm:ss"];                // 设定时间格式,这里可以设置成自己需要的格式

    int     year = 0, month = 0, day = 0;
    int     hour = 0, minute = 0, second = 0;
    NSNumber     *dist = 0, *fuel = 0, *avgFeul = 0, *avgRPM = 0;
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
                    driveData.beginTime = [[NSNumber alloc] initWithLong:[date timeIntervalSince1970]];
                    break;
                }

            case 16:
            case 18:
            case 20:
            case 22:
            case 24:
            case 26:
            case 28:
            case 30:
            case 32:
            case 34:
            case 38:
            case 40:
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
                    driveData.endTime = [[NSNumber alloc] initWithLong:[date timeIntervalSince1970]];
                    break;
                }

            // end lat
            case 54:
            case 56:
            case 58:
            case 60:
            case 62:
                break;

            // end lng
            case 64:
            case 66:
            case 68:
            case 70:
            case 72:
                break;

            // dir
            case 74:
                break;

            // end ele
            case 76:
            case 78:
                break;

            case 80:
                break;
                // airPressure
            case 82:
                break;
                // fuelLV
            case 84:
                break;
                // bat
            case 86:
                break;
                // errDist
            case 88:
            case 90:
                break;
                // clrDist
            case 92:
            case 94:
                break;

            case 96:
                driveData.temp = [self hex2int:hex];
                break;

            case 98:
                dist = [self hex2int:hex];
                break;

            case 100:
                dist = [[NSNumber alloc] initWithInt:[[self hex2int:hex] integerValue] + [dist integerValue] * 256];
                driveData.dist = dist;
                break;

            case 102:
                driveData.maxSPD = [self hex2int:hex];
                break;

            case 104:
                driveData.bstFuel = [self hex2int:hex];
                break;

            case 106:
                driveData.bstSPD = [self hex2int:hex];
                break;

            case 108:
                fuel = [self hex2int:hex];
                break;

            case 110:
                fuel = [[NSNumber alloc] initWithInt:[[self hex2int:hex] integerValue] + [fuel integerValue] * 256];
                driveData.fuel = fuel;
                break;

            case 112:
                avgFeul = [self hex2int:hex];
                break;

            case 114:
                avgFeul = [[NSNumber alloc] initWithInt:[[self hex2int:hex] integerValue] + [fuel integerValue] * 256];
                driveData.avgFuel = avgFeul;
                break;
                // lst fuel lv
            case 116:
                break;

            case 118:
                driveData.avgCoolTemp = [self hex2int:hex];
                break;
                // max cool temp
            case 120:
                break;

            case 122:
                driveData.avgPadPos = [self hex2int:hex];
                break;

            case 124:
                driveData.maxPadPos = [self hex2int:hex];
                break;
                // min pad pos
            case 126:
                break;

            case 128:
                avgRPM = [self hex2int:hex];
                break;

            case 130:
                avgRPM = [[NSNumber alloc] initWithInt:[[self hex2int:hex] integerValue] + [avgRPM integerValue] * 256];
                driveData.avgRPM = avgRPM;
                break;
                // max rpm
            case 132:
            case 134:
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

/*
 *   解析行程切片数据
 */

+ (LCDrivePiece *)parseDrivePiece:(NSString *)data
{
    LCDrivePiece    *drivePiece = [[LCDrivePiece alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];   // 实例化一个NSDateFormatter对象

    [dateFormat setDateFormat:@"yy-MM-dd HH:mm:ss"];                // 设定时间格式,这里可以设置成自己需要的格式

    int         year = 0, month = 0, day = 0;
    int         hour = 0, minute = 0, second = 0;
    NSNumber    *dist = 0, *avgFeul = 0, *avgRPM = 0, *maxRPM = 0;
    NSRange     range;
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
                    drivePiece.timestamp = [[NSNumber alloc] initWithLong:[date timeIntervalSince1970]];
                    break;
                }
                // lat
            case 16:
            case 18:
            case 20:
            case 22:
                break;
                // dir
            case 24:
                break;
                // lng
            case 26:
            case 28:
            case 30:
            case 32:
            case 34:
                break;
                // ele
            case 38:
            case 40:
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
                dist = [[NSNumber alloc] initWithInt:[[self hex2int:hex] integerValue] + [dist integerValue] * 256];
                drivePiece.dist = dist;
                break;

            case 52:
                drivePiece.avgSPD = [self hex2int:hex];
                break;

            case 54:
                avgRPM = [self hex2int:hex];
                break;

            case 56:
                avgRPM = [[NSNumber alloc] initWithInt:[[self hex2int:hex] integerValue] + [avgRPM integerValue] * 256];
                drivePiece.avgRPM = avgRPM;
                break;

            case 58:
                maxRPM = [self hex2int:hex];
                break;

            case 60:
                maxRPM = [[NSNumber alloc] initWithInt:[[self hex2int:hex] integerValue] + [maxRPM integerValue] * 256];
                drivePiece.maxRPM = maxRPM;
                break;

            case 62:
                drivePiece.fuel = [self hex2int:hex];
                break;

            case 64:
                avgFeul = [self hex2int:hex];
                break;

            case 66:
                avgFeul = [[NSNumber alloc] initWithInt:[[self hex2int:hex] integerValue] + [avgFeul integerValue] * 256];
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

+ (NSNumber *)hex2int:(NSString *)hex
{
    @try {
        unichar hex_char1 = [hex characterAtIndex:0];
        unichar hex_char2 = [hex characterAtIndex:1];

        return [[NSNumber alloc] initWithInt:[self char2int:hex_char1] * 16 + [self char2int:hex_char2] ];
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

@end
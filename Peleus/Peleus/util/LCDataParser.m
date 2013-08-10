//
//  LCDataParser.m
//  core
//
//  Created by chris.liu on 5/31/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCDataParser.h"

@implementation LCDataParser


/*
 解析OBD配置文件
 */
+ (NSDictionary *)parseConfig:(NSString*) data
{
    NSRange range;
    range.location = 86;
    range.length = 32;
    NSString *cid = [data substringWithRange:range];
    range.length = 2;
    char tmp[[data length]/2];
    for(int i=0; i<[data length]; i+=2)
    {
        range.location = i;
        NSString *hex = [data substringWithRange:range];
        tmp[i / 2] = [self hex2char:hex];
    }
    char vinArray[17];
    char obdArray[8];
    char calidArray[8];
    for (int i=0; i<[data length]; ++i) {
        if (i> 16 && i< 33) {
            vinArray[i -16] = tmp[i];
        } else if (i > 33 && i < 42) {
            obdArray[i - 33] = tmp[i];
        } else if (i > 111 && i < 120) {
            calidArray[i - 112] = tmp[i];
        }
    }
    NSString *vin = [NSString stringWithCString:vinArray encoding:NSASCIIStringEncoding];
    NSString *obd = [NSString stringWithCString:obdArray encoding:NSASCIIStringEncoding];
    NSString *calid = [NSString stringWithCString:calidArray encoding:NSASCIIStringEncoding];
    NSDictionary *dict = @{@"vin":vin,@"obd":obd, @"calid":calid, @"cid":cid};
    return dict;
}

+ (char)hex2char:(NSString *)hex
{
    @try {
        int value = 0;
        sscanf([hex cStringUsingEncoding:NSASCIIStringEncoding], "%x", &value);
        return (char)value;
    }
    @catch (NSException *exception) {
        return '0';
    }
    @finally {
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
    @catch (NSException *exception) {
        return 0;
    }
    @finally {
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
    @catch (NSException *exception) {
        return 0;
    }
    @finally {
        return 0;
    }
}

@end

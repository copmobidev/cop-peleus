//
//  LCTypeParser.m
//  Peleus
//
//  Created by weiyanen on 13-8-17.
//  Copyright (c) 2013年 cop-studio. All rights reserved.
//

#import "LCTypeParser.h"

@implementation LCTypeParser

#pragma mark - type to string

+ (NSString *)long2String:(long)value {
	return [NSString stringWithFormat:@"%ld", value];
}

#pragma mark - string to type

+ (long)string2Long:(NSString *)value {
	return (long)value;
}

+ (double)string2Double:(NSString *)value {
	return [value doubleValue];
}

+ (int)string2Int:(NSString *)value {
	return [value intValue];
}

@end

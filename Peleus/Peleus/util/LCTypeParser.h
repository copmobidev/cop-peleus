//
//  LCTypeParser.h
//  Peleus
//
//  Created by weiyanen on 13-8-17.
//  Copyright (c) 2013年 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCTypeParser : NSObject

#pragma mark - type to string

+ (NSString *)long2String:(long)value;

#pragma mark - string to type

+ (long)string2Long:(NSString *)value;

+ (double)string2Double:(NSString *)value;

+ (int)string2Int:(NSString *)value;


@end

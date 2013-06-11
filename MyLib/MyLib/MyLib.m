//
//  MyLib.m
//  MyLib
//
//  Created by chris.liu on 6/9/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "MyLib.h"

@implementation MyLib

- (NSInteger) add:(NSInteger)a and:(NSInteger)b
{
    return a + b;
}

+ (NSString*) connect:(NSString *)str1 and:(NSString *)str2
{
    return [NSString stringWithFormat:@"%@ %@", str1, str2];
}

@end

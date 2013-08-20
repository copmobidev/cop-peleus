//
//  LCDriveData.m
//  MyApp
//
//  Created by chris.liu on 8/1/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCDriveData.h"
#import "NSObject+Properties.h"

@implementation LCDriveData

- (LCDriveData *)initWithDriveData:(NSDictionary *)dict {
	self = [super init];
	if (self) {
		NSLog(@"%@", [self propertyNames]);
		
//		for (NSString *propertyName in [LCDriveData propertyNames]) {
//			[self setValue:[dict valueForKey:propertyName] forKey:propertyName];
//		}
	}
	return self;
}

@end

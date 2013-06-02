//
//  LCSqliteManager.m
//  Peleus
//
//  Created by chris.liu on 6/2/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCSqliteManager.h"

@implementation LCSqliteManager

@synthesize dbPath;


static LCSqliteManager* sharedSqliteManger = nil;

+ (LCSqliteManager*)sharedSqliteManger
{
    @synchronized([LCSqliteManager class])
	{
		if (!sharedSqliteManger)
        {
            [[self alloc] init];
        }
		return sharedSqliteManger;
	}
	return nil;
}

+ (id)alloc
{
    @synchronized([LCSqliteManager class])
	{
		NSAssert(sharedSqliteManger == nil,
                 @"Attempted to allocate a second instance of a singleton.");
		sharedSqliteManger = [super alloc];
		return sharedSqliteManger;
	}
	return nil;
}

- (void)checkAndCreateDatabaseWithOverwrite:(BOOL)overWriteDB
{
    
}

- (NSArray*)executeSql:(NSString*)sql
{
    return nil;
}

@end

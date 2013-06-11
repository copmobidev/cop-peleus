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
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSqliteManger = [[LCSqliteManager alloc] init];
    });
    
    return sharedSqliteManger;
}


- (void)checkAndCreateDatabaseWithOverwrite:(BOOL)overWriteDB
{
    
}

- (NSArray*)executeSql:(NSString*)sql
{
    return nil;
}

@end

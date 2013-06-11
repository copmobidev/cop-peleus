//
//  LCSqliteManager.h
//  Peleus
//
//  Created by chris.liu on 6/2/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface LCSqliteManager : NSObject
{
    NSString *dbPath;
}

@property (nonatomic, strong) NSString *dbPath;

+ (LCSqliteManager *)sharedSqliteManger;

- (void)checkAndCreateDatabaseWithOverwrite:(BOOL)overWriteDB;

- (NSArray *)executeSql:(NSString *)sql;

@end
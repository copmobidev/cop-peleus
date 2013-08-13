//
//  LCViewController.m
//  MyApp
//
//  Created by chris.liu on 6/9/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCViewController.h"
#import "LCDataService.h"
#import "LCEnvironment.h"
#import "LCTimestamp.h"

@interface LCViewController ()

@end

@implementation LCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction Implement

- (IBAction)getConfig:(id)sender
{
    [self.tf1 setText:[[LCEnvironment sharedEnvironment] userAgent]];
    [[LCDataService sharedDataService] getConfig];
}

- (IBAction)pushConfig:(id)sender
{
    [[LCDataService sharedDataService] pushParam];
}

- (IBAction)syncData:(id)sender
{
    [[LCDataService sharedDataService] syncData];
}

- (IBAction)uploadData:(id)sender
{
    [[LCDataService sharedDataService] uploadData];
}

- (IBAction)getData:(id)sender
{
    LCTimestamp *timestamp = [[LCTimestamp alloc] init];
    timestamp.span = WEEK;
    timestamp.beginTime = [self time2longWithYear:45134 withMonth:10 withDay:26 withHour:8 withMinute:0 withSecond:0];
    timestamp.endTime = [self time2longWithYear:45325 withMonth:7 withDay:4 withHour:11 withMinute:38 withSecond:43];
    [[LCDataService sharedDataService] getDriveDataWithSpan:timestamp];
}


#pragma mark - Util

- (long)time2longWithYear:(int)year withMonth:(int)month withDay:(int)day withHour:(int)hour withMinute:(int)minute withSecond:(int)second {
	NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yy-MM-dd HH:mm:ss"];//设定时间格式
	NSString *dateStr = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d", 2013, 8, 23, 23, 38, 28];
	NSDate *date = [dateFormat dateFromString:dateStr];
	return (long)[date timeIntervalSince1970];
}

#pragma mark - Delegate Methods

- (void)onGetConfigSuccess:(NSData *)config
{
    [self.tf1 setText:@"get config successful"];
}

- (void)onGetConfigFail
{
    [self.tf1 setText:@"get config fail"];
}

- (void)onSyncDataSuccess:(NSDictionary *)data
{
    [self.tf1 setText:@"sync data successful"];
}

- (void)onSyncDataFail
{
    [self.tf1 setText:@"sync data fail"];
}


@end

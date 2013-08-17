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
#import "LCDataParser.h"

@interface LCViewController ()

@end

@implementation LCViewController

@synthesize tfResult;

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
    NSString *config = @"A54B57502D666173742D696E697420204C4757464633413532414230303535343220313031393232363020123014AC0FA00FA012ED10450FC00FB22020202020BE3EB811800000000000000001F800002020202021202020202020202020202020202020202020202020202020202020000000000000000020202020202020C3";
    NSDictionary *dict = [LCDataParser parseOBDConfig:config];
    NSLog(@"%@", dict);
    [self.tfResult setText:[[LCEnvironment sharedEnvironment] userAgent]];
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
    NSString *data = @"012D05010100013400000000000000000000000000000500000000000000000013880000000000FF0000000100012D0501010002340000000000000000000000000000050000000003C803C80013880D8A000000FF0000000100012D0501010003060000000000000000000000000020020000100401FA03D4840337078A000000FF0000000601024D05010100010100000000000000000000000000050101000306000000000000000000000000000300FF0000000000FF001000020000840E17FF5C8A00000000EB03D40000000400010048";
    [[LCDataService sharedDataService] uploadData:data];
}

- (IBAction)parseDriveData:(id)sender
{
    NSString *data = @"012D130715151448311775344E012036368245001527052701891704B50725CE07222284121900FF0000000603012D130715151548311754234E01203642814500180B0600000400037D045EEBC2740886000000FF0000003800012D130715151648311727914E01203650584500073A033901FE1E0578082153048E1C86091800FF0000000F0C012D130715151748311714914E01203651004500F130071001391204E70813E5060A1688061700FF0000001609012D130715151848311709174E01203647674500F1130D0F001F0103F9068A3F27680E88011600FF0000003100012D130715151931311692794E012036531245000234023401EB2905C607CF3304791E86091700FF0000000111024D130715151349311797174E0120362957450000130715151931311692794E012036531245000206FFFF80FFFFFFFFFF00AE3A023403632AADFF868807190000B808210000002B0B1B1A2E00";
    [LCDataParser parseDriveData:data];
    //    NSLog(@"%@", [LCDataParser parseDriveData:data]);
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
    [self.tfResult setText:@"get config successful"];
}

- (void)onGetConfigFail
{
    [self.tfResult setText:@"get config fail"];
}

- (void)onSyncDataSuccess:(NSDictionary *)data
{
    [self.tfResult setText:@"sync data successful"];
}

- (void)onSyncDataFail
{
    [self.tfResult setText:@"sync data fail"];
}

- (void)onPushParamSucess
{
    
}

- (void)onPushParamFail
{
    
}

- (void)onUploadDataSucess:(NSDictionary *)data
{
    
}

- (void)onUploadDataFail {
    
}

@end

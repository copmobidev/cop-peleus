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
#import "LCDriveData.h"
#import "LCDrivePiece.h"

@interface LCViewController ()

@end

@implementation LCViewController

@synthesize tfResult;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[[LCDataService sharedDataService] setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction Implement

- (IBAction)getConfig:(id)sender
{
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
	NSDictionary *dict = [LCDataParser parseOBDConfig:[[NSString alloc] initWithData:config encoding:NSASCIIStringEncoding]];
	NSLog(@"%@", dict);
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
    NSLog(@"%@", data);
	LCDriveData *driveData = [[LCDriveData alloc] init];
	NSDictionary *dataDict = [[data valueForKey:@"data"] valueForKey:@"dataSummary"];
	driveData.beginTime = [[dataDict valueForKey:@"beginTime"] longValue];
	driveData.beginLat = [[dataDict valueForKey:@"beginLat"] doubleValue];
	driveData.beginLng = [[dataDict valueForKey:@"beginLng"] doubleValue];
	driveData.beginEle = [[dataDict valueForKey:@"beginEle"] doubleValue];
	driveData.endTime = [[dataDict valueForKey:@"endTime"] longValue];
	driveData.endLat = [[dataDict valueForKey:@"endLat"] doubleValue];
	driveData.endLng = [[dataDict valueForKey:@"endLng"] doubleValue];
	driveData.endEle = [[dataDict valueForKey:@"endEle"] doubleValue];
	driveData.dist = [[dataDict valueForKey:@"dist"] doubleValue];
	driveData.fuel = [[dataDict valueForKey:@"fuel"] doubleValue];
	driveData.errDist = [[dataDict valueForKey:@"errDist"] intValue];
	driveData.clrDist = [[dataDict valueForKey:@"clrDist"] intValue];
	driveData.maxSPD = [[dataDict valueForKey:@"maxSPD"] doubleValue];
	driveData.bstSPD = [[dataDict valueForKey:@"bstSPD"] doubleValue];
	driveData.avgFuel = [[dataDict valueForKey:@"avgFuel"] doubleValue];
	driveData.bstFeul = [[dataDict valueForKey:@"bstFeul"] doubleValue];
	driveData.FuelLV = [[dataDict valueForKey:@"FuelLV"] intValue];
	driveData.lstFuelLV = [[dataDict valueForKey:@"lstFuelLV"] doubleValue];
	driveData.bat = [[dataDict valueForKey:@"bat"] doubleValue];
	driveData.airPressure = [[dataDict valueForKey:@"airPressure"] intValue];
	driveData.temp = [[dataDict valueForKey:@"temp"] doubleValue];
	driveData.avgCoolTemp = [[dataDict valueForKey:@"avgCoolTemp"] doubleValue];
	driveData.maxCoolTemp = [[dataDict valueForKey:@"maxCoolTemp"] doubleValue];
	driveData.avgPadPos = [[dataDict valueForKey:@"avgPadPos"] doubleValue];
	[driveData setValue:[dataDict valueForKey:@"avgPadPos"] forKey:@"avgPadPos"];
	driveData.maxPadPos = [[dataDict valueForKey:@"maxPadPos"] doubleValue];
	driveData.minPadPos = [[dataDict valueForKey:@"minPadPos"] doubleValue];
	driveData.avgRPM = [[dataDict valueForKey:@"avgRPM"] doubleValue];
	driveData.maxRPM = [[dataDict valueForKey:@"maxRPM"] doubleValue];
	driveData.acc = [[dataDict valueForKey:@"acc"] intValue];
	driveData.brk = [[dataDict valueForKey:@"brk"] intValue];
	driveData.overSPD = [[dataDict valueForKey:@"overSPD"] doubleValue];
	driveData.idleSPD = [[dataDict valueForKey:@"idleSPD"] doubleValue];
	driveData.sliding = [[dataDict valueForKey:@"sliding"] doubleValue];
	driveData.fast = [[dataDict valueForKey:@"fast"] doubleValue];
	driveData.slow = [[dataDict valueForKey:@"slow"] doubleValue];
	driveData.jam = [[dataDict valueForKey:@"jam"] doubleValue];
	driveData.errCodes = [dataDict valueForKey:@"errCodes"];
	driveData.minuteData = [dataDict valueForKey:@"minuteData"];
	driveData.score = [[dataDict valueForKey:@"score"] doubleValue];
	
	LCDrivePiece *drivePiece = [[LCDrivePiece alloc] init];
	NSDictionary *pieceDict = [[data valueForKey:@"data"] valueForKey:@"dataPieces"];
	drivePiece.timestamp = [[pieceDict valueForKey:@"timestamp"] longValue];
	drivePiece.lat = [[pieceDict valueForKey:@"lat"] doubleValue];
	drivePiece.lng = [[pieceDict valueForKey:@"lng"] doubleValue];
	drivePiece.dir1 = [[pieceDict valueForKey:@"dir1"] charValue];
	drivePiece.dir2 = [[pieceDict valueForKey:@"dir2"] charValue];
	drivePiece.ele = [[pieceDict valueForKey:@"ele"] intValue];
	drivePiece.dist = [[pieceDict valueForKey:@"dist"] intValue];
	drivePiece.fuel = [[pieceDict valueForKey:@"fuel"] doubleValue];
	drivePiece.bstFuel = [[pieceDict valueForKey:@"bstFuel"] doubleValue];
	drivePiece.avgFeul = [[pieceDict valueForKey:@"avgFeu"] doubleValue];
	drivePiece.maxSPD = [[pieceDict valueForKey:@"maxSPD"] doubleValue];
	drivePiece.bstSPD = [[pieceDict valueForKey:@"bstSPD"] doubleValue];
	drivePiece.avgSPD = [[pieceDict valueForKey:@"avgSPD"] doubleValue];
	drivePiece.avgRPM = [[pieceDict valueForKey:@"avgRPM"] doubleValue];
	drivePiece.maxRPM = [[pieceDict valueForKey:@"maxRPM"] doubleValue];
	drivePiece.avgCalLoad = [[pieceDict valueForKey:@"avgCalLoad"] doubleValue];
	drivePiece.avgCoolTemp = [[pieceDict valueForKey:@"avgCoolTemp"] doubleValue];
	drivePiece.avgPadPos = [[pieceDict valueForKey:@"avgPadPos"] doubleValue];
	drivePiece.maxPadPos = [[pieceDict valueForKey:@"maxPadPos"] doubleValue];
	drivePiece.minPadPos = [[pieceDict valueForKey:@"minPadPos"] doubleValue];
	drivePiece.fuelLV = [[pieceDict valueForKey:@"fuelLV"] doubleValue];
	drivePiece.acc = [[pieceDict valueForKey:@"acc"] intValue];
	drivePiece.brk = [[pieceDict valueForKey:@"brk"] intValue];
	drivePiece.overSPD = [[pieceDict valueForKey:@"overSPD"] doubleValue];
	drivePiece.idleSPD = [[pieceDict valueForKey:@"idleSPD"] doubleValue];
	drivePiece.sliding = [[pieceDict valueForKey:@"sliding"] doubleValue];
	drivePiece.score = [[pieceDict valueForKey:@"score"] doubleValue];
}

- (void)onUploadDataFail {
    
}

@end

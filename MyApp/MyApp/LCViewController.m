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

#pragma mark -
#pragma IBAction Implement

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
    timestamp.span = TRACK;
    timestamp.beginTime = 0;
    timestamp.endTime = 1;
    [[LCDataService sharedDataService] getDriveDataWithSpan:timestamp];
}

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

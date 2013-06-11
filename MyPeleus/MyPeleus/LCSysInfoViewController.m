//
//  LCSysInfoViewController.m
//  MyPeleus
//
//  Created by chris.liu on 6/9/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCSysInfoViewController.h"

@interface LCSysInfoViewController ()

@end

@implementation LCSysInfoViewController

@synthesize tvSysInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sysInfos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier =@"SimpleTableViewIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:identifier];
    }
    
    return cell;
}


#pragma mark -
#pragma mark Table Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSString *message = [[NSString alloc]initWithFormat:@"You selected is %@!",[sysInfos objectAtIndex:row]];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Information"
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:@"Confirm"
                                         otherButtonTitles:nil, nil];
    [alert show];
}

@end

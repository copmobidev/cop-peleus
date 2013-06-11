//
//  LCMainViewController.m
//  MyPeleus
//
//  Created by chris.liu on 6/9/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCMainViewController.h"

@interface LCMainViewController ()

@end

@implementation LCMainViewController

@synthesize tvService;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initServices];
    [tvService setDataSource:self];
    [tvService setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initServices
{
    services = [[NSMutableArray alloc] init];
    
    NSDictionary *serviceItem;
    serviceItem = [NSDictionary dictionaryWithObjectsAndKeys:
                   @"Board.png", @"icon",
                   @"mobi api service", @"service", nil];
    [services addObject:serviceItem];
    serviceItem = [NSDictionary dictionaryWithObjectsAndKeys:
                   @"Book.png", @"icon",
                   @"data service", @"service", nil];
    [services addObject:serviceItem];
    serviceItem = [NSDictionary dictionaryWithObjectsAndKeys:
                   @"Bug.png", @"icon",
                   @"cache service", @"service", nil];
    [services addObject:serviceItem];
    serviceItem = [NSDictionary dictionaryWithObjectsAndKeys:
                   @"Clipboard.png", @"icon",
                   @"sys info service", @"service", nil];
    [services addObject:serviceItem];
}


#pragma mark -
#pragma mark Table View Data Source Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [services count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifier =@"SimpleTableViewIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                     reuseIdentifier:identifier];
    }
    UIImage * img = [UIImage imageNamed:@"singleicon"];
    cell.imageView.image = img;
    NSUInteger row = [indexPath row];
    NSDictionary *serviceDict = [services objectAtIndex:row];
    NSString *imgName = [serviceDict objectForKey:@"icon"];
    NSString *serviceDesc = [serviceDict objectForKey:@"service"];
    [cell.imageView setImage:[UIImage imageNamed: imgName]];
    [cell.imageView setFrame:CGRectMake(0, 0, 34, 34)];
    [cell.textLabel setText:serviceDesc];
    
    return cell;
}


#pragma mark -
#pragma mark Table Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSString *message = [[NSString alloc]initWithFormat:@"You selected is %@!",[services objectAtIndex:row]];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Information"
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:@"Confirm"
                                         otherButtonTitles:nil, nil];
    [alert show];
}

@end

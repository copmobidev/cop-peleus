//
//  LCViewController.m
//  MyApp
//
//  Created by chris.liu on 6/9/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCViewController.h"

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

- (IBAction)add:(id)sender
{
    NSInteger num1 = [self.tf1.text integerValue];
    NSInteger num2 = [self.tf2.text integerValue];
    // 初始化一个新的 MyLib 实例
    MyLib* myLib = [[MyLib alloc] init];
    // 调用实例方法相加
    NSInteger result = [myLib add:num1 and:num2];
    // 显示结果
    self.tfResult.text = [NSString stringWithFormat:@"%d", result];
}


- (IBAction)append:(id)sender
{
    NSString* str1 = self.tf1.text;
    NSString* str2 = self.tf2.text;
    // 调用 MyLib 的静态方法连两个字符串
    NSString* result = [MyLib connect:str1 and:str2];
    // 显示结果
    self.tfResult.text = result;
}

@end

//
//  LCViewController.h
//  MyApp
//
//  Created by chris.liu on 6/9/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLib.h"


@interface LCViewController : UIViewController


@property (nonatomic, weak) IBOutlet UITextField* tf1;
@property (nonatomic, weak) IBOutlet UITextField* tf2;
@property (nonatomic, weak) IBOutlet UITextField* tfResult;

- (IBAction)add:(id)sender;
- (IBAction)append:(id)sender;

@end

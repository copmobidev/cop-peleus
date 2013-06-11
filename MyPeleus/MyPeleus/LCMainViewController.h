//
//  LCMainViewController.h
//  MyPeleus
//
//  Created by chris.liu on 6/9/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCMainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray* services;
}

@property (nonatomic, weak) IBOutlet UITableView* tvService;

@end

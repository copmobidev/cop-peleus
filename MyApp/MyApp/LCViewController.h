//
//  LCViewController.h
//  MyApp
//
//  Created by chris.liu on 6/9/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCDataServiceDelegate.h"


@interface LCViewController : UIViewController <LCDataServiceDelegate>
{
    
}

@property (nonatomic, weak) IBOutlet UITextField* tfResult;

- (IBAction)getConfig:(id)sender;
- (IBAction)pushConfig:(id)sender;
- (IBAction)syncData:(id)sender;
- (IBAction)uploadData:(id)sender;
- (IBAction)getData:(id)sender;
- (IBAction)parseDriveData:(id)sender;

@end

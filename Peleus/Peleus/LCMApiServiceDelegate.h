//
//  LCMApiServiceDelegate.h
//  Peleus
//
//  Created by chris.liu on 6/9/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCMApiRequest.h"

@protocol LCMApiServiceDelegate <NSObject>

- (void)onRequestStart:(LCMApiRequest *)request;
- (void)onRequestFinished:(LCMApiRequest *)request;
- (void)onRequestFailed:(LCMApiRequest *)request;

@end
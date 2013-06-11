//
//  LCMApiService.m
//  Peleus
//
//  Created by chris.liu on 6/9/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import "LCMApiService.h"

@implementation LCMApiService

@synthesize requests, responses, delegate;

static LCMApiService *_sharedMApiService = nil;

+ (LCMApiService *)sharedMApiService
{
    @synchronized(self) {
        if (_sharedMApiService == nil) {
            _sharedMApiService = [[LCMApiService alloc] init];
        }
    }
    return _sharedMApiService;
}

- (void)get:(LCMApiRequest *)request
{}

- (void)post:(LCMApiRequest *)request
{}

@end
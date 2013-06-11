//
//  LCMApiService.h
//  Peleus
//
//  Created by chris.liu on 6/9/13.
//  Copyright (c) 2013 cop-studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCMApiServiceDelegate.h"
#import "ASIHttpRequestDelegate.h"
#import "LCMapiRequest.h"
#import "LCMApiResponse.h"

@interface LCMApiService : NSObject <ASIHTTPRequestDelegate>
{
    NSMutableArray  *requests;
    NSMutableArray  *responses;
}

@property (nonatomic, strong) NSMutableArray                *requests;
@property (nonatomic, strong) NSMutableArray                *responses;
@property (nonatomic, strong) id <LCMApiServiceDelegate>    delegate;

+ (LCMApiService *)sharedMApiService;

/*
 *   以GET方式发送请求
 */
- (void)get:(LCMApiRequest *)request;

/*
 *   以POST方式发送请求
 */
- (void)post:(LCMApiRequest *)request;

@end
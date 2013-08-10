// ----------
//
//				BRRequestDownload.h
//
// filename:	BRRequestDownload.h
//
// author:		Created by Valentin Radu on 8/23/11.
//              Copyright 2011 Valentin Radu. All rights reserved.
//
//              Modified and/or redesigned by Lloyd Sargent to be ARC compliant.
//              Copyright 2012 Lloyd Sargent. All rights reserved.
//
// created:		Jul 04, 2012
//
// description:
//
// notes:		none
//
// revisions:
#import "BRGlobal.h"
#import "BRRequest.h"

@interface BRRequestDownload : BRRequest
{}

@property NSData *receivedData;

+ (BRRequestDownload *)initWithDelegate:(id)inDelegate;

@end
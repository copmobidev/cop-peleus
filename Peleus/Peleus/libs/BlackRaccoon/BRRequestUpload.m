// ----------
//
//				BRRequestUpload.m
//
// filename:	BRRequestUpload.m
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
#import "BRRequestUpload.h"

@interface BRRequestUpload ()
@end

@implementation BRRequestUpload

@synthesize listrequest;

// -----
//
//				initWithDelegate
//
// synopsis:	retval = [self initWithDelegate:inDelegate];
//					BRRequestUpload *retval	-
//					id inDelegate           -
//
// description:	initWithDelegate is designed to
//
// errors:		none
//
// returns:		Variable of type BRRequestUpload *
//
+ (BRRequestUpload *)initWithDelegate:(id)inDelegate
{
    BRRequestUpload *uploadFile = [[BRRequestUpload alloc] init];

    if (uploadFile) {
        uploadFile.delegate = inDelegate;
    }

    return uploadFile;
}

// -----
//
//				start
//
// synopsis:	[self start];
//
// description:	start is designed to
//
// errors:		none
//
// returns:		none
//
- (void)start
{
    self.maximumSize = LONG_MAX;
    bytesIndex = 0;
    bytesRemaining = 0;

    if (![self.delegate respondsToSelector:@selector(requestDataToSend:)]) {
        [self.streamInfo streamError:self errorCode:kBRFTPClientMissingRequestDataAvailable];
        InfoLog(@"%@", self.error.message);
        return;
    }

    // -----we first list the directory to see if our folder is up on the server
    self.listrequest = [BRRequestListDirectory initWithDelegate:self];
    self.listrequest.path = [self.path stringByDeletingLastPathComponent];
    self.listrequest.hostname = self.hostname;
    self.listrequest.username = self.username;
    self.listrequest.password = self.password;
    [self.listrequest start];
}

// -----
//
//				requestCompleted
//
// synopsis:	[self requestCompleted:request];
//					BRRequest *request	-
//
// description:	requestCompleted is designed to
//
// errors:		none
//
// returns:		none
//
- (void)requestCompleted:(BRRequest *)request
{
    NSString *fileName = [[self.path lastPathComponent] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];

    if ([self.listrequest fileExists:fileName]) {
        if (![self.delegate shouldOverwriteFileWithRequest:self]) {
            [self.streamInfo streamError:self errorCode:kBRFTPClientFileAlreadyExists];   // perform callbacks and close out streams
            return;
        }
    }

    if ([self.delegate respondsToSelector:@selector(requestDataSendSize:)]) {
        self.maximumSize = [self.delegate requestDataSendSize:self];
    }

    // ----- open the write stream and check for errors calling delegate methods
    // ----- if things fail. This encapsulates the streamInfo object and cleans up our code.
    [self.streamInfo openWrite:self];
}

// -----
//
//				requestFailed
//
// synopsis:	[self requestFailed:request];
//					BRRequest *request	-
//
// description:	requestFailed is designed to
//
// errors:		none
//
// returns:		none
//
- (void)requestFailed:(BRRequest *)request
{
    [self.delegate brRequestFailed:request];
}

// -----
//
//				shouldOverwriteFileWithRequest
//
// synopsis:	retval = [self shouldOverwriteFileWithRequest:request];
//					BOOL retval         -
//					BRRequest *request	-
//
// description:	shouldOverwriteFileWithRequest is designed to
//
// errors:		none
//
// returns:		Variable of type BOOL
//
- (BOOL)shouldOverwriteFileWithRequest:(BRRequest *)request
{
    return [self.delegate shouldOverwriteFileWithRequest:request];
}

// -----
//
//				stream
//
// synopsis:	[self stream:theStream handleEvent:streamEvent];
//					NSStream *theStream         -
//					NSStreamEvent streamEvent	-
//
// description:	stream is designed to
//
// errors:		none
//
// returns:		none
//
- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent
{
    // ----- see if we have cancelled the runloop
    if ([self.streamInfo checkCancelRequest:self]) {
        return;
    }

    switch (streamEvent) {
        case NSStreamEventOpenCompleted:
            {
                self.didOpenStream = YES;
                self.streamInfo.bytesTotal = 0;
                break;
            }

        case NSStreamEventHasBytesAvailable:
            {
                break;
            }

        case NSStreamEventHasSpaceAvailable:
            {
                if (bytesRemaining == 0) {
                    sentData = [self.delegate requestDataToSend:self];
                    bytesRemaining = [sentData length];
                    bytesIndex = 0;

                    // ----- we are done
                    if (sentData == nil) {
                        [self.streamInfo streamComplete:self];                  // perform callbacks and close out streams
                        return;
                    }
                }

                NSUInteger  nextPackageLength = MIN(kBRDefaultBufferSize, bytesRemaining);
                NSRange     range = NSMakeRange(bytesIndex, nextPackageLength);
                NSData      *packetToSend = [sentData subdataWithRange:range];

                [self.streamInfo write:self data:packetToSend];

                bytesIndex += self.streamInfo.bytesThisIteration;
                bytesRemaining -= self.streamInfo.bytesThisIteration;
                break;
            }

        case NSStreamEventErrorOccurred:
            {
                [self.streamInfo streamError:self errorCode:[BRRequestError errorCodeWithError:[theStream streamError]]]; // perform callbacks and close out streams
                InfoLog(@"%@", self.error.message);
                break;
            }

        case NSStreamEventEndEncountered:
            {
                [self.streamInfo streamError:self errorCode:kBRFTPServerAbortedTransfer]; // perform callbacks and close out streams
                InfoLog(@"%@", self.error.message);
                break;
            }

        case NSStreamEventNone:
            break;
    }
}

@end
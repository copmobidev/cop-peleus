#import "BRRequestDownload.h"

@implementation BRRequestDownload

@synthesize tag, receivedData;

//-----
//
//				initWithDelegate
//
// synopsis:	retval = [BRRequestDownload initWithDelegate:inDelegate];
//					BRRequestDownload *retval	-
//					id inDelegate            	-
//
// description:	initWithDelegate is designed to
//
// errors:		none
//
// returns:		Variable of type BRRequestDownload *
//
+ (BRRequestDownload *) initWithDelegate: (id) inDelegate
{
    BRRequestDownload *downloadFile = [[BRRequestDownload alloc] init];
    if (downloadFile)
        downloadFile.delegate = inDelegate;
    
    return downloadFile;
}

//-----
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
-(void) start
{
    if (![self.delegate respondsToSelector:@selector(requestDataAvailable:)])
    {
        [self.streamInfo streamError: self errorCode: kBRFTPClientMissingRequestDataAvailable];
        InfoLog(@"%@", self.error.message);
        return;
    }
    
    //----- open the read stream and check for errors calling delegate methods
    //----- if things fail. This encapsulates the streamInfo object and cleans up our code.
    [self.streamInfo openRead: self];
}



//-----
//
//				stream
//
// synopsis:	[self stream:theStream handleEvent:streamEvent];
//					NSStream *theStream      	-
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
    //----- see if we have cancelled the runloop
    if ([self.streamInfo checkCancelRequest: self])
        return;
    
    switch (streamEvent) 
    {
        case NSStreamEventOpenCompleted: 
        {
            self.maximumSize = [[theStream propertyForKey:(id)kCFStreamPropertyFTPResourceSize] integerValue];
            
            self.didOpenStream = YES;
            self.streamInfo.bytesTotal = 0;
            self.receivedData = [NSMutableData data];
            break;
        }            
        case NSStreamEventHasBytesAvailable: 
        {
            self.receivedData = [self.streamInfo read: self];
            
            if (self.receivedData)
            {
                [self.delegate requestDataAvailable: self];
            }
            
            else
            {
                InfoLog(@"Stream opened, but failed while trying to read from it.");
                [self.streamInfo streamError: self errorCode: kBRFTPClientCantReadStream];
            }
            break;
        } 
        case NSStreamEventHasSpaceAvailable: 
        {
            break;
        }            
        case NSStreamEventErrorOccurred: 
        {
            [self.streamInfo streamError: self errorCode: [BRRequestError errorCodeWithError: [theStream streamError]]];
            InfoLog(@"%@", self.error.message);
            break;
        }            
        case NSStreamEventEndEncountered: 
        {
            [self.streamInfo streamComplete: self];
            break;
        }
        case NSStreamEventNone:
            break;
    }
}


@end

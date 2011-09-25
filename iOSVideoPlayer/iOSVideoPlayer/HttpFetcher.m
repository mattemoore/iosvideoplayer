//
//  ThumbnailViewer.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-09-24.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "HttpFetcher.h"

@implementation HttpFetcher

@synthesize delegate = delegate;
@synthesize url = __url;
@synthesize error = __error;
@synthesize connection = __connection;
@synthesize dataContainer = __dataContainer;
@synthesize isSuccess = __isSuccess;
@synthesize customData = __customData;

- (id)initWithUrl:(NSString*)url userObject:(NSMutableDictionary*)customData
{
    self = [super init];
    if (self) {
        self.url = [[NSURL alloc] initWithString:url];
        self.customData = customData;
        self.dataContainer = [[NSMutableData alloc] init];
    }
    
    return self;
}

#pragma mark - NSURLDataConnection Handling


-(void)fetch
{   
    NSURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:self.url];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //TODO: handle non-200 status codes (LocalSocial)
    
    [self.dataContainer setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.dataContainer appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.isSuccess = NO;
    self.error = error;
    [self returnError];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self returnSuccess];
}

-(void)returnSuccess
{
    if ([self.delegate respondsToSelector:@selector(finishedFetcher:userObject:withError:)])
    {
        [self.delegate finishedFetcher:self.dataContainer userObject:self.customData withError:self.error];
    }
}

-(void)returnError
{
    if ([self.delegate respondsToSelector:@selector(finishedFetcher:data:userObject:withError:)])
    {
        [self.delegate finishedFetcher:nil userObject:self.customData withError:self.error];
    }
    
}


@end

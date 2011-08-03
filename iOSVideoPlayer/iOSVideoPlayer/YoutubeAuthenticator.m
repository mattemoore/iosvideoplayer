//
//  YoutubeAuthenticator.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-08-02.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "YoutubeAuthenticator.h"

#define kApiKey @"AI39si6AIfVaikIH6D3Yw_TX2rFNzPEsuMb1yvWefpPGghgLB4h2EciSsV1qPP_SntqkUfg9pAN3bpGrq8rUWpwF2dphr3EvKQ"

@implementation YoutubeAuthenticator

@synthesize isSuccess = __isSuccess;
@synthesize error = __error;

- (id)init
{
    self = [super init];
    if (self) {
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        self.urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        self.dataContainer = [[NSData alloc] init];
        self.userUploadsQuery = [NSURL URLWithString:[NSString stringWithFormat:@"https://gdata.youtube.com/feeds/api/users/default/uploads?key=%@", kApiKey]];    
        
    }
    
    return self;
}


#pragma mark - NSURLDataConnection Handling

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.isSuccess = NO;
    self.error = error;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}



@end

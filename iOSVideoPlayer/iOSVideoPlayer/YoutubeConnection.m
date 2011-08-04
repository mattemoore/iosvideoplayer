//
//  YoutubeAuthenticator.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-08-02.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "YoutubeConnection.h"

#define kApiKey @"AI39si6AIfVaikIH6D3Yw_TX2rFNzPEsuMb1yvWefpPGghgLB4h2EciSsV1qPP_SntqkUfg9pAN3bpGrq8rUWpwF2dphr3EvKQ"

@implementation YoutubeConnection

@synthesize userUploadsURL = __userUploadsURL;
@synthesize userUploadsConnection = __userUploadsConnection;
@synthesize authenticationURL = __authenticationURL;
@synthesize authenticationConnection = __authenticationConnection;

@synthesize dataContainer = __dataContainer;
@synthesize isSuccess = __isSuccess;
@synthesize error = __error;

- (id)init
{
    self = [super init];
    if (self) {
        
        self.authenticationURL = [NSURL URLWithString:@"https://www.google.com/accounts/ClientLogin"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:self.authenticationURL];
        [request setHTTPMethod:@"POST"];
        [request addValue:@"Content-Type" forHTTPHeaderField:@"application/x-www-form-urlencoded"];
        NSString *postBody = @"Email=matt.e.moore@gmail.com&Passwd=Pr0t3stTh3H3r0&service=youtube&source=K2VidApp";
        NSData *postBodyBytes = [postBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:postBodyBytes];
        self.authenticationConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        self.dataContainer = [[NSMutableData alloc] init];
        
        /*
        self.userUploadsURL= [NSURL URLWithString:[NSString stringWithFormat:@"https://gdata.youtube.com/feeds/api/users/default/uploads?key=%@", kApiKey]];    
        */
    }
    
    return self;
}


#pragma mark - NSURLDataConnection Handling

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
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
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == self.authenticationConnection)
    {
        //TODO: parse response and extract from Auth= to end, make sure no terminating character added
        //      add auth value to a property and call query connection with it as a header
        NSString *authenticationResponse = [[NSString alloc] initWithData:self.dataContainer encoding:NSUTF8StringEncoding];
        
    }
}



@end

//
//  YoutubeFetcher.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-08-02.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "YoutubeFetcher.h"

#define kApiKey @"AI39si6AIfVaikIH6D3Yw_TX2rFNzPEsuMb1yvWefpPGghgLB4h2EciSsV1qPP_SntqkUfg9pAN3bpGrq8rUWpwF2dphr3EvKQ"

@implementation YoutubeFetcher

@synthesize delegate = delegate;
@synthesize userUploadsConnection = __userUploadsConnection;
@synthesize authenticationToken = __authenticationToken;
@synthesize authenticationConnection = __authenticationConnection;
@synthesize dataContainer = __dataContainer;

@synthesize parser = __parser;
@synthesize currentVideo = __currentVideo;
@synthesize currentString = __currentString;
@synthesize parsedVideos = __parsedVideos;

@synthesize error = __error;
@synthesize isSuccess = __isSuccess;

- (id)init
{
    self = [super init];
    if (self) {
        
        self.dataContainer = [[NSMutableData alloc] init];
        self.parsedVideos = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)connectAndParse
{
    self.authenticationConnection = [[NSURLConnection alloc] initWithRequest:[self getAuthenticationURLRequest:[NSURL URLWithString:@"https://www.google.com/accounts/ClientLogin"]] delegate:self];
    
}

#pragma mark - NSURLDataConnection Handling

- (NSMutableURLRequest *)getAuthenticationURLRequest:(NSURL*)authenticationURL {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:authenticationURL];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"Content-Type" forHTTPHeaderField:@"application/x-www-form-urlencoded"];
    NSString *postBody = @"Email=matt.e.moore@gmail.com&Passwd=Pr0t3stTh3H3r0&service=youtube&source=K2VidApp";
    NSData *postBodyBytes = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postBodyBytes];
    return request;
    
}

- (NSMutableURLRequest *)getUserUploadsURLRequest:(NSURL*)userUploadsURL {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:userUploadsURL];
    
    const NSString *authHeaderPrefix = @"GoogleLogin auth=";
    NSString *authHeader = [authHeaderPrefix stringByAppendingString:self.authenticationToken];
    authHeader = [authHeader stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [request addValue:authHeader forHTTPHeaderField:@"Authorization"];
    
    const NSString *keyHeaderPrefix = @"key=";
    NSString *keyHeader = [keyHeaderPrefix stringByAppendingString:kApiKey];
    [request addValue:keyHeader forHTTPHeaderField:@"X-GData-Key"];
    
    [request setHTTPMethod:@"GET"];
    return request;
}


-(void)getUserUploads
{   
    self.userUploadsConnection = [[NSURLConnection alloc] initWithRequest:[self getUserUploadsURLRequest:[NSURL URLWithString:[NSString stringWithFormat:@"https://gdata.youtube.com/feeds/api/users/default/uploads?key=%@", kApiKey]]] delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //TODO: handle non-200 status codes
    
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
    if (connection == self.authenticationConnection)
    {
        NSString *authenticationResponse = [[NSString alloc] initWithData:self.dataContainer encoding:NSUTF8StringEncoding];
        NSString *authDelimeter = @"Auth=";
        NSArray *components = [authenticationResponse componentsSeparatedByString:authDelimeter];
        self.authenticationToken = [components objectAtIndex:1];
        [self getUserUploads];
    }
    
    if (connection == self.userUploadsConnection)
    {
        [self startParsingWithData:self.dataContainer];
    }
}


#pragma mark - XML Parsing self.parser = [[NSXMLParser alloc] ];


-(void)startParsingWithData:(NSData*)data
{
    self.parser = [[NSXMLParser alloc] initWithData:data];
    self.parser.delegate = self;
    [self.parser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser;
{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser;
{
    self.isSuccess = YES;
    [self returnSuccess];
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    self.currentString = @"";
    
    if ([elementName isEqualToString:@"entry"])
    {
        self.currentVideo = [[NSMutableDictionary alloc] init];
    }
    
    if ([elementName isEqualToString:@"media:player"])
    {
        [self.currentVideo setValue:[attributeDict objectForKey:@"url"] forKey:@"url"];
    } 
    
    if (([elementName isEqualToString:@"media:thumbnail"]) )
    {
        if ([[attributeDict objectForKey:@"width"]isEqualToString:@"320"])
            [self.currentVideo setValue:[attributeDict objectForKey:@"url"] forKey:@"thumbnailurl"];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    if ([elementName isEqualToString:@"entry"])
    {
        [self.parsedVideos addObject:self.currentVideo];
    }
    
    if ([elementName isEqualToString:@"title"])
    {
        [self.currentVideo setValue:self.currentString forKey:@"title"];
    }
    
    if ([elementName isEqualToString:@"media:description"])
    {
        [self.currentVideo setValue:[self.currentString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] forKey:@"summary"];
    }
    
    if ([elementName isEqualToString:@"yt:videoid"])
    {
        [self.currentVideo setValue:self.currentString forKey:@"id"];
    } 
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    self.currentString  = [string stringByAppendingString:self.currentString];
}

- (void)parser:(NSXMLParser *)parser foundIgnorableWhitespace:(NSString *)whitespaceString;
{
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError;
{
    self.isSuccess = NO;
    self.error = parseError;
    [self returnError];
}

-(void)returnSuccess
{
    if ([self.delegate respondsToSelector:@selector(finishedConnectAndParse:withError:)])
    {
        [self.delegate finishedConnectAndParse:self.parsedVideos withError:self.error];
    }
}

-(void)returnError
{
    if ([self.delegate respondsToSelector:@selector(finishedConnectAndParse:withError:)])
    {
        [self.delegate finishedConnectAndParse:nil withError:self.error];
    }
    
}
@end

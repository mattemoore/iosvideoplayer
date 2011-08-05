//
//  YoutubeFetcher.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-08-02.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YoutubeFetcherDelegate <NSObject>

-(void)finishedConnectAndParse:(NSArray*)videos withError:(NSError*)error;

@end

@interface YoutubeFetcher : NSObject <NSXMLParserDelegate, NSURLConnectionDataDelegate>
{
    id <YoutubeFetcherDelegate> delegate;
}

@property (nonatomic, strong) id delegate;

//connection properties
@property (nonatomic, strong) NSURLConnection *authenticationConnection;
@property (nonatomic, strong) NSString *authenticationToken;
@property (nonatomic, strong) NSURLConnection *userUploadsConnection;
@property (nonatomic, strong) NSMutableData *dataContainer;

//parsing properties
@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSMutableArray *parsedVideos;
@property (nonatomic, strong) NSMutableDictionary *currentVideo;
@property (nonatomic, strong) NSString *currentString;

@property (nonatomic, strong) NSError *error;
@property BOOL isSuccess;

//TODO: most of these should be private 
- (NSMutableURLRequest *)getAuthenticationURLRequest:(NSURL*)authenticationURL;
- (NSMutableURLRequest *)getUserUploadsURLRequest:(NSURL*)userUploadsURL;
-(void)connectAndParse;
-(void)startParsingWithData:(NSData*)data;
-(void)getUserUploads;
-(void)returnError;
-(void)returnSuccess;

@end

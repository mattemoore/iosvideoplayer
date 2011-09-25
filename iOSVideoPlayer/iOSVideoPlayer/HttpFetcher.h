//
//  ThumbnailViewer.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-09-24.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpFetcherDelegate <NSObject>

-(void)finishedFetcher:(NSData*)data userObject:(NSDictionary*)userObject withError:(NSError*)error;

@end


@interface HttpFetcher : NSObject <NSURLConnectionDataDelegate>
{
    id <HttpFetcherDelegate> delegate;
}

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSError *error;
@property BOOL isSuccess;
@property (nonatomic, strong) NSMutableData *dataContainer;
@property (nonatomic, strong) NSDictionary *customData;

-(void)returnError;
-(void)returnSuccess;
- (id)initWithUrl:(NSString*)url userObject:(NSDictionary*)customData;
-(void)fetch;

@end

//
//  YoutubeAuthenticator.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-08-02.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YoutubeConnection : NSObject <NSURLConnectionDataDelegate>
{}

@property (nonatomic, strong) NSURL *authenticationURL;
@property (nonatomic, strong) NSURLConnection *authenticationConnection;
@property (nonatomic, strong) NSURL *userUploadsURL;
@property (nonatomic, strong) NSURLConnection *userUploadsConnection;

@property (nonatomic, strong) NSMutableData *dataContainer;
@property (nonatomic,strong) NSError *error;
@property BOOL isSuccess;

@end

//
//  YoutubeAuthenticator.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-08-02.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YoutubeAuthenticator : NSObject <NSURLConnectionDataDelegate>
{}

@property (nonatomic,strong) NSError *error;
@property BOOL isSuccess;

@end

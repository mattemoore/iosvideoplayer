//
//  YoutubeFetcher.m
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-08-02.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "YoutubeFetcher.h"

@implementation YoutubeFetcher

@synthesize isSuccess = __isSuccess;
@synthesize error = __error;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end

//
//  iOSVideoPlayerTests.m
//  iOSVideoPlayerTests
//
//  Created by Matthew Moore on 11-06-22.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "iOSVideoPlayerTests.h"
#import "YoutubeParser.h"
#import "Video.h"

@implementation iOSVideoPlayerTests

@synthesize bridge = __bridge;

- (void)setUp
{
    [super setUp];
    
    
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testSingleEntryParse
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [mainBundle pathForResource:@"TestYouTubeFeed" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.bridge = [[YoutubeParser alloc] initWithURL:url];
    [self.bridge requestAndParse];
    
    assert(self.bridge.parsedVideos.count == 1);
    assert(self.bridge.isSuccess);
    
    NSDictionary *video = [self.bridge.parsedVideos objectAtIndex:0];
    assert([[video valueForKey:@"title"] isEqualToString:@"Shopping for Coats"]);
    assert([[video valueForKey:@"url"] isEqualToString:@"https://www.youtube.com/watch?v=ZTUVgYoeN_b"]);
    assert([[video valueForKey:@"summary"] isEqualToString:@"What could make for more exciting video?"]);
    assert([[video valueForKey:@"thumbnailurl"] isEqualToString:@"http://img.youtube.com/vi/ZTUVgYoeN_b/0.jpg"]);
    assert([[video valueForKey:@"id"] isEqualToString:@"ZTUVgYoeN_b"]);
}


- (void)testMultiEntryParse
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [mainBundle pathForResource:@"TestYouTubeFeedMultiEntry" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.bridge = [[YoutubeParser alloc] initWithURL:url];
    [self.bridge requestAndParse];
    
    assert(self.bridge.parsedVideos.count == 2);
    assert(self.bridge.isSuccess);
    
    NSDictionary *video = [self.bridge.parsedVideos objectAtIndex:1];
    assert([[video valueForKey:@"title"] isEqualToString:@"Shopping for CoatsXXX"]);
    assert([[video valueForKey:@"url"] isEqualToString:@"https://www.youtube.com/watch?v=ZTUVgYoeN_bXXX"]);
    assert([[video valueForKey:@"summary"] isEqualToString:@"What could make for more exciting video?XXX"]);
    assert([[video valueForKey:@"thumbnailurl"] isEqualToString:@"http://img.youtube.com/vi/ZTUVgYoeN_b/0.jpgXXX"]);
    assert([[video valueForKey:@"id"] isEqualToString:@"ZTUVgYoeN_bXXX"]);
    
}

@end

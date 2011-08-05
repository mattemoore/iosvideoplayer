//
//  iOSVideoPlayerTests.m
//  iOSVideoPlayerTests
//
//  Created by Matthew Moore on 11-06-22.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "iOSVideoPlayerTests.h"
#import "YoutubeFetcher.h"
@implementation iOSVideoPlayerTests

@synthesize fetcher = fetcher;

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
    self.fetcher = [[YoutubeFetcher alloc] init];
    [self.fetcher startParsingWithData:[NSData dataWithContentsOfFile:path]];
    
    assert(self.fetcher.parsedVideos.count == 1);
    assert(self.fetcher.isSuccess);
    
    NSDictionary *video = [self.fetcher.parsedVideos objectAtIndex:0];
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
    self.fetcher = [[YoutubeFetcher alloc] init];
    [self.fetcher startParsingWithData:[NSData dataWithContentsOfFile:path]];
  
    assert(self.fetcher.parsedVideos.count == 2);
    assert(self.fetcher.isSuccess);
    
    NSDictionary *video = [self.fetcher.parsedVideos objectAtIndex:1];
    assert([[video valueForKey:@"title"] isEqualToString:@"Shopping for CoatsXXX"]);
    assert([[video valueForKey:@"url"] isEqualToString:@"https://www.youtube.com/watch?v=ZTUVgYoeN_bXXX"]);
    assert([[video valueForKey:@"summary"] isEqualToString:@"What could make for more exciting video?XXX"]);
    assert([[video valueForKey:@"thumbnailurl"] isEqualToString:@"http://img.youtube.com/vi/ZTUVgYoeN_b/0.jpgXXX"]);
    assert([[video valueForKey:@"id"] isEqualToString:@"ZTUVgYoeN_bXXX"]);
    
}

@end

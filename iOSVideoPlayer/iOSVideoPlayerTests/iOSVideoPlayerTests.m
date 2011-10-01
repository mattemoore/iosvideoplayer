//
//  iOSVideoPlayerTests.m
//  iOSVideoPlayerTests
//
//  Created by Matthew Moore on 11-06-22.
//  Copyright 2011 Matt Moore. All rights reserved.
//

#import "iOSVideoPlayerTests.h"
#import "UserUploadsFetcher.h"
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
    self.fetcher = [[UserUploadsFetcher alloc] init];
    [self.fetcher startParsingWithData:[NSData dataWithContentsOfFile:path]];
    
    assert(self.fetcher.parsedVideos.count == 1);
    assert(self.fetcher.isSuccess);
    
    NSDictionary *video = [self.fetcher.parsedVideos objectAtIndex:0];
    assert([[video valueForKey:@"title"] isEqualToString:@"Frozen Synapse Gameplay.."]);
    assert([[video valueForKey:@"url"] isEqualToString:@"https://www.youtube.com/watch?v=oKkw_AVZMk4&feature=youtube_gdata_player"]);
    assert([[video valueForKey:@"summary"] isEqualToString:@"My first and only win so far :(\n                \n                Separation between turns isn't obvious but still should give you an idea of how the game works.."]);
    assert([[video valueForKey:@"thumbnailurl"] isEqualToString:@"http://i.ytimg.com/vi/oKkw_AVZMk4/0.jpg"]);
    assert([[video valueForKey:@"id"] isEqualToString:@"http://gdata.youtube.com/feeds/api/videos/oKkw_AVZMk4"]);
    assert([[video valueForKey:@"keywords"] isEqualToString:@"Frozen, Synapse"]);
}

- (void)testMultiEntryParse
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [mainBundle pathForResource:@"TestYouTubeFeedMultiEntry" ofType:@"xml"];
    self.fetcher = [[UserUploadsFetcher alloc] init];
    [self.fetcher startParsingWithData:[NSData dataWithContentsOfFile:path]];
  
    assert(self.fetcher.parsedVideos.count == 2);
    assert(self.fetcher.isSuccess);
    
    NSDictionary *video = [self.fetcher.parsedVideos objectAtIndex:1];
    assert([[video valueForKey:@"title"] isEqualToString:@"Frozen Synapse Gameplay.."]);
    assert([[video valueForKey:@"url"] isEqualToString:@"https://www.youtube.com/watch?v=oKkw_AVZMk4&feature=youtube_gdata_player"]);
    assert([[video valueForKey:@"summary"] isEqualToString:@"My first and only win so far :(\n                \n                Separation between turns isn't obvious but still should give you an idea of how the game works.."]);
    assert([[video valueForKey:@"thumbnailurl"] isEqualToString:@"http://i.ytimg.com/vi/oKkw_AVZMk4/0.jpg"]);
    assert([[video valueForKey:@"id"] isEqualToString:@"http://gdata.youtube.com/feeds/api/videos/oKkw_AVZMk4"]);
    assert([[video valueForKey:@"keywords"] isEqualToString:@"Frozen, Synapse"]);
    
}

@end

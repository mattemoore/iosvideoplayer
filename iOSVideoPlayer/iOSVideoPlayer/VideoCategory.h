//
//  VideoCategory.h
//  iOSVideoPlayer
//
//  Created by Matthew Moore on 11-07-04.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Video.h"


@interface VideoCategory : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString *Name;
@property (nonatomic, retain) NSSet *Videos;
@end

@interface VideoCategory (CoreDataGeneratedAccessors)
- (void)addVideosObject:(Video *)value;
- (void)removeVideosObject:(Video *)value;
- (void)addVideos:(NSSet *)value;
- (void)removeVideos:(NSSet *)value;

@end

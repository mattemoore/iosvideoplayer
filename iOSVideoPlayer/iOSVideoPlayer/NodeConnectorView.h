//
//  NodeConnectorView.h
//  iOSVideoPlayer
//
//  Created by Matt Moore on 11-10-26.
//  Copyright (c) 2011 Matt Moore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NodeConnectorView : UIView
{}

enum LineType {LineTypeStraight, LineTypeUp, LineTypeDown};

@property (atomic, assign) enum LineType connectLineType;

@end

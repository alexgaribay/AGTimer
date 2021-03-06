//
//  AGTimer.h
//  AGTimer
//
//  Created by Alex Garibay on 10/25/13.
//  Copyright (c) 2013 Alex Garibay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGTimer : NSObject
@property (readonly) BOOL isRunning;

- (void)start;
- (void)stop;
- (void)reset;
- (int)getTimeElapsedInSeconds;
- (int)getTimeRemainingInSeconds;
- (void)setStopTime:(int)seconds;
- (void)clearStopTime;

@end

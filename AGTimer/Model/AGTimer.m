//
//  AGTimer.m
//  AGTimer
//
//  Created by Alex Garibay on 10/25/13.
//  Copyright (c) 2013 Alex Garibay. All rights reserved.
//

#import "AGTimer.h"

@interface AGTimer()
@property (nonatomic, strong) NSTimer* timer;
@property int timeElapsedInSeconds;
@property int stopTimeInSeconds;
@end


@implementation AGTimer

- (id)init
{
    self = [super init];
    _timeElapsedInSeconds = 0;
    _stopTimeInSeconds = 0;
    return self;
}

- (void)start
{
    if (_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(timerTick)
                                               userInfo:nil
                                                repeats:YES];
        _isRunning = YES;
    }
}

- (void)stop
{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
        _isRunning = NO;
    }
}

- (void)reset
{
    if (_isRunning)
    {
        [self stop];
        [self setTimeElapsed: 0];
    }
}

- (void)timerTick
{
    [self setTimeElapsed:_timeElapsedInSeconds + 1];
    if (_timeElapsedInSeconds == _stopTimeInSeconds)
    {
        [self stop];
        [self sendTimerCompleteNotification];
    }
}

- (int)getTimeElapsedInSeconds
{
    return _timeElapsedInSeconds;
}

- (int)getTimeRemainingInSeconds
{
    if (_stopTimeInSeconds > 0)
    {
        return _stopTimeInSeconds - _timeElapsedInSeconds;
    }
    return 0;
}

- (void)setStopTime:(int)seconds
{
    if (seconds > 0)
    {
        _stopTimeInSeconds = seconds;
    }
}
- (void) setTimeElapsed:(int)seconds
{
    _timeElapsedInSeconds = seconds;
    [self sendTimeElapsedChangedNotification];
}

- (void)sendTimeElapsedChangedNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AGTimerElapsedChange" object:nil];
}

- (void)sendTimerCompleteNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AGTimerComplete" object:nil];
}

@end

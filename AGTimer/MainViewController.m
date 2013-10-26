//
//  MainViewController.m
//  AGTimer
//
//  Created by Alex Garibay on 10/25/13.
//  Copyright (c) 2013 Alex Garibay. All rights reserved.
//

#import "MainViewController.h"
#import "AGTimer.h"

@interface MainViewController ()
@property (strong, nonatomic) AGTimer* timer;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_timer = [[AGTimer alloc] init];
    
    // Subscribe to countdown timer notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(timerComplete)
                                                 name:@"AGTimerComplete"
                                               object:nil];
    
    // Subscribe to the timer elapsed changed. Basically it means that timer had a "tick"
    // on the clock
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTimeLabel)
                                                 name:@"AGTimerElapsedChange"
                                               object:nil];
    
    [self.countDownSwitch addTarget:self action:@selector(switchToggled) forControlEvents:UIControlEventValueChanged];
    [self updateTimeLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Start the timer
- (IBAction)startTimer:(id)sender
{
    self.countDownSwitch.enabled = NO;
    [_timer start];
}

// Stop the timer
- (IBAction)stopTimer:(id)sender
{
    self.countDownSwitch.enabled = YES;
    [_timer stop];
}

// Reset the timer
- (IBAction)resetTimer:(id)sender
{
    self.countDownSwitch.enabled = YES;
    [_timer reset];
}


// Update the time label every time the elapsedTime has changed for the timer.
- (void)updateTimeLabel
{
    if (self.countDownSwitch.isOn)
    {
        _timeElapsed.text = [NSString stringWithFormat:@"%i", [_timer getTimeRemainingInSeconds]];
    }
    else
    {
        _timeElapsed.text = [NSString stringWithFormat:@"%i", [_timer getTimeElapsedInSeconds]];
    }
}

- (void)switchToggled
{
    if (self.countDownSwitch.isOn)
    {
        [_timer reset];
        [_timer setStopTime:10];
    }
    else
    {
        [_timer clearStopTime];
    }
    [self updateTimeLabel];
}

// Make a label show temporarily to signify that the countdown timer completed.
- (void)timerComplete
{
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void)
     {
         [self.timerCompleted setAlpha:1.0];
     }
                     completion:^(BOOL finished)
     {
         if(finished)
         {
             [UIView animateWithDuration:1.0
                                   delay:7.0
                                 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                              animations:^(void)
              {
                  [self.timerCompleted setAlpha:0.0];
              }
                              completion:^(BOOL finished)
              {
                  if(finished)
                  {
                      // Do nothing
                  }
              }];
         }
     }];
}

@end

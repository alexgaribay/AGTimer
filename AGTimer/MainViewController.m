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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(timerComplete)
                                                 name:@"AGTimerComplete"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTimeLabel)
                                                 name:@"AGTimerElapsedChange"
                                               object:nil];
    [self.countDownSwitch addTarget:self action:@selector(switchToggled) forControlEvents:UIControlEventValueChanged];
    [self updateTimeLabel];
}

- (IBAction)startTimer:(id)sender
{
    self.countDownSwitch.enabled = NO;
    [_timer start];
}
- (IBAction)stopTimer:(id)sender
{
    self.countDownSwitch.enabled = YES;
    [_timer stop];
}
- (IBAction)resetTimer:(id)sender
{
    self.countDownSwitch.enabled = YES;
    [_timer reset];
}


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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)switchToggled
{
    if (self.countDownSwitch.isOn)
    {
        [_timer setStopTime:10];
    }
    else
    {
        [_timer clearStopTime];
    }
    [self updateTimeLabel];
}

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
                      //put another block her to hide both the labels.
                  }
              }];
         }
     }];
}

@end

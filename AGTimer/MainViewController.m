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
                                             selector:nil
                                                 name:@"AGTimerComplete"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTimeLabel)
                                                 name:@"AGTimerElapsedChange"
                                               object:nil];
    [self updateTimeLabel];
}

- (IBAction)startTimer:(id)sender
{
    [_timer start];
}
- (IBAction)stopTimer:(id)sender
{
    [_timer stop];
}
- (IBAction)resetTimer:(id)sender
{
    [_timer reset];
}


- (void)updateTimeLabel
{
    _timeElapsed.text = [NSString stringWithFormat:@"%i", [_timer getTimeElapsedInSeconds]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

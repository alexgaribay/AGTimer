//
//  MainViewController.h
//  AGTimer
//
//  Created by Alex Garibay on 10/25/13.
//  Copyright (c) 2013 Alex Garibay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel* timeElapsed;
@property (strong, nonatomic) IBOutlet UILabel* timerCompleted;
@property (strong, nonatomic) IBOutlet UISwitch* countDownSwitch;
@end

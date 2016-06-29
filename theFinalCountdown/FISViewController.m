//
//  FISViewController.m
//  theFinalCountdown
//
//  Created by Joe Burgess on 7/9/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController ()

@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *start;
@property (weak, nonatomic) IBOutlet UIButton *pause;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *timer;

@property (assign, nonatomic) NSInteger afterRemainder;
@property (assign, nonatomic) NSInteger remainder;  // Holds the valuie from the picker
@property (assign, nonatomic) NSTimeInterval countDownInterval;


@end

@implementation FISViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.timer.hidden = YES;
    self.cancel.hidden = YES;



	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)start:(id)sender {
    
    self.datePicker.hidden = YES;
    self.timer.hidden = NO;
    self.pause.enabled = YES;
    self.start.hidden = YES;
    self.cancel.hidden = NO;
    
    
    
    self.countDownInterval = (NSTimeInterval)self.datePicker.countDownDuration;
    self.remainder = self.countDownInterval;
    self.afterRemainder = self.countDownInterval - self.remainder%60;
    
  timerTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
    
}

- (IBAction)pause:(id)sender {
    
//    self.pause.enabled = YES;
//    self.start.hidden = YES;
//    self.cancel.hidden = NO;
    
    
    if (timerTimer == nil) {
       timerTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];

    } else {
        
        [timerTimer invalidate];
        timerTimer = nil;
    }
    
    
    
}

- (void)updateCountDown {
    
    // countDownTime = countDownTime - 1;
    
    self.afterRemainder --;
    
    NSInteger hours = self.afterRemainder/(60*60);
    NSInteger minuts = (self.afterRemainder/60) - (hours * 60);
    NSInteger seconds = self.afterRemainder - (60 * minuts) - (60 * hours * 60);
    
    if (seconds < 10 && minuts < 10 && hours < 10)
    
    {
        
    self.timer.text = [NSString stringWithFormat:@"0%li:0%li:0%li", hours, minuts, seconds];
        
    }
    
    else if (minuts < 10 && seconds > 9 && hours < 10)
    
    {
        
    self.timer.text = [NSString stringWithFormat:@"0%li:0%li:%li", hours, minuts, seconds];

    }
    
    else if (minuts > 9 && seconds > 9 && hours < 10)
    
    {
        
    self.timer.text = [NSString stringWithFormat:@"0%li:%li:%li", hours, minuts, seconds];

    }
    
    else if (minuts > 9 && seconds < 10 && hours < 10)
    
    {
        
    self.timer.text = [NSString stringWithFormat:@"0%li:%li:0%li", hours, minuts, seconds];

    }
    
    else if (minuts > 9 && seconds > 9 && hours > 9)
    
    {
        
    self.timer.text = [NSString stringWithFormat:@"%li:%li:%li", hours, minuts, seconds];

    }

    
    if (seconds == 0 && minuts == 0 && hours == 0) {
        
        [timerTimer invalidate];
    }
}


- (IBAction)cancel:(id)sender {
    
    self.timer.text = [NSString stringWithFormat:@"Ready?"];
    self.timer.hidden = YES;
    self.datePicker.hidden = NO;
    self.pause.enabled = NO;
    self.cancel.hidden = YES;
    self.start.hidden = NO;
    
    [timerTimer invalidate];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

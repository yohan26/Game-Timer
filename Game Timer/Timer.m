//
//  Timer.m
//  Game Timer
//
//  Created by Yasser Al-Khder on 2013-09-04.
//  Copyright (c) 2013 Yasser Al-Khder. All rights reserved.
//

#import "Timer.h"

@interface Timer ()

@property (nonatomic) float startTime;
@property (strong, nonatomic) NSTimer *countdownTimer;

@end

@implementation Timer

- (id)initWithTime:(float)time {
    self = [self init];
    if (self) {
        self.startTime = time;
        self.player1Time = time;
        self.player2Time = time;
        self.status = noPlayerRunning;
    }
    else {
        NSLog(@"did not init properly");
    }
    
    return self;
}

- (void)timerFired {
    //TODO: Make it pass by reference
    switch (self.status) {
        case player1Running:
            self.player1Time = [self decrementTime:(self.player1Time)];
            break;
        case player2Running:
            self.player2Time = [self decrementTime:self.player2Time];
            break;
        default:
            NSLog(@"%u", self.status);
            break;
    }
}

- (float)decrementTime:(float)time {
    if (time <= 0.0f) {
        [self.countdownTimer invalidate];
        self.status = noPlayerRunning;
    }
    time = MAX(time - 0.1f, 0.0f);
    return time;
}

- (void)startTimer {
    [self.countdownTimer invalidate];
    self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

@end

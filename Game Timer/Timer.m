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
@property (nonatomic) float player1Time;
@property (nonatomic) float player2Time;

@end

@implementation Timer

- (id)initWithTime:(float)time {
    self = [self init];
    if (self) {
        self.startTime = time;
        self.player1Time = time;
        self.player2Time = time;
    }
    else {
        NSLog(@"did not init properly");
    }
    
    return self;
}

@end

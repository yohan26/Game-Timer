//
//  Timer.h
//  Game Timer
//
//  Created by Yasser Al-Khder on 2013-09-04.
//  Copyright (c) 2013 Yasser Al-Khder. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    noPlayerRunning,
    player1Running,
    player2Running
} timerStatus;

@interface Timer : NSObject

@property (nonatomic, readonly) float startTime;
@property (nonatomic) float player1Time;
@property (nonatomic) float player2Time;
@property (nonatomic) timerStatus status;

- (id)initWithTime:(float)time;
- (void)startTimer;

@end

//
//  Timer.h
//  Game Timer
//
//  Created by Yasser Al-Khder on 2013-09-04.
//  Copyright (c) 2013 Yasser Al-Khder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject

@property (nonatomic, readonly) float player1Time;
@property (nonatomic, readonly) float player2Time;

- (id)initWithTime:(float)time;

@end

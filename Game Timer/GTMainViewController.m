//
//  GTMainViewController.m
//  Game Timer
//
//  Created by Yasser Al-Khder on 2013-08-31.
//  Copyright (c) 2013 Yasser Al-Khder. All rights reserved.
//

#import "GTMainViewController.h"
#import "Timer.h"

@interface GTMainViewController ()

@property (strong, nonatomic) Timer *timer;
@property (nonatomic, weak) UIButton *middleButton;
@property (nonatomic, weak) UIButton *player1Button;
@property (nonatomic, weak) UIButton *player2Button;

@end

@implementation GTMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self addObserver:self forKeyPath:@"timer.player1Time" options:0 context:NULL];
        [self addObserver:self forKeyPath:@"timer.player2Time" options:0 context:NULL];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == self && [keyPath isEqualToString:@"timer.player1Time"]) {
        NSString *player1String = [NSString stringWithFormat:@"%0.1f", self.timer.player1Time];
        [self.player1Button setTitle:player1String forState:UIControlStateNormal];
    }
    
    if (object == self && [keyPath isEqualToString:@"timer.player2Time"]) {
        NSString *player2String = [NSString stringWithFormat:@"%0.1f", self.timer.player2Time];
        [self.player2Button setTitle:player2String forState:UIControlStateNormal];
    }
    
    if (self.timer.player1Time == 0 || self.timer.player2Time == 0) {
        [self updateUI];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.timer = [[Timer alloc] initWithTime:10.0f];
    
    self.middleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.middleButton.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
    self.middleButton.frame = CGRectMake(0, self.view.bounds.size.height/2 - 100, self.view.bounds.size.width, 200);
    [self.middleButton setTitle:@"Middle Button" forState:UIControlStateNormal];
//    [self.middleButton setTintColor:[UIColor greenColor]];
//    [self.middleButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.middleButton.tag = 3;
    [self.middleButton addTarget:self action:@selector(middleButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.player1Button = [UIButton buttonWithType:UIButtonTypeSystem];
    NSString *player1String = [NSString stringWithFormat:@"%0.1f", self.timer.player1Time];
    [self.player1Button setTitle:player1String forState:UIControlStateNormal];
    [self.player1Button.titleLabel setFont:[UIFont systemFontOfSize:100.0f]];
    self.player1Button.frame = CGRectMake(0, CGRectGetMaxY(self.middleButton.frame), self.view.bounds.size.width, CGRectGetMinY(self.middleButton.frame));
    self.player1Button.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin;
    self.player1Button.tag = 1;
    [self.player1Button addTarget:self action:@selector(playerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.player2Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSString *player2String = [NSString stringWithFormat:@"%0.1f", self.timer.player2Time];
    [self.player2Button setTitle:player2String forState:UIControlStateNormal];
    [self.player2Button.titleLabel setFont:[UIFont systemFontOfSize:100.0f]];
    self.player2Button.frame = CGRectMake(0, 0, self.view.bounds.size.width, CGRectGetMinY(self.middleButton.frame));
    self.player2Button.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
    self.player2Button.transform = CGAffineTransformMakeRotation(M_PI);
    self.player2Button.tag = 2;
    [self.player2Button addTarget:self action:@selector(playerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.middleButton];
    [self.view addSubview:self.player1Button];
    [self.view addSubview:self.player2Button];
}

- (void)playerButtonPressed:(id)button {
    if (button == self.player1Button) {
        if (self.timer.status == noPlayerRunning) {
            self.timer.status = player1Running;
        }
        else if (self.timer.status == player1Running) {
            self.timer.player1Time = self.timer.startTime;
            self.timer.status = player2Running;
        }
    }
    
    else if (button == self.player2Button) {
        if (self.timer.status == noPlayerRunning) {
            self.timer.status = player2Running;
        }
        else if (self.timer.status == player2Running) {
            self.timer.player2Time = self.timer.startTime;
            self.timer.status = player1Running;
        }
    }
    [self updateUI];
    [self.timer startTimer];
}

- (void)middleButtonPressed {
    NSLog(@"Middle button pressed");
    
    // shit goes here
}

- (void)updateUI {
    switch (self.timer.status) {
        case noPlayerRunning:
            self.player1Button.enabled = YES;
            self.player2Button.enabled = YES;
            break;
        
        case player1Running:
            self.player1Button.enabled = YES;
            self.player2Button.enabled = NO;
            break;
            
        case player2Running:
            self.player1Button.enabled = NO;
            self.player2Button.enabled = YES;
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

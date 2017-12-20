//
//  TransitionFromViewController.m
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import "TransitionFromViewController.h"
#import "BsaeViewController.h"
#import "AViewController.h"
#import "BViewController.h"

@interface TransitionFromViewController ()

@property (nonatomic, strong) BsaeViewController *currentVC;

@end

@implementation TransitionFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AViewController *a = [[AViewController alloc] init];
    [self addChildViewController:a];
    
    BViewController *b = [[BViewController alloc] init];
    [self addChildViewController:b];
    
    [self.view addSubview:a.view];
    
    _currentVC = a;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    AViewController *a = self.childViewControllers[0];
    BViewController *b = self.childViewControllers[1];
    BsaeViewController *toV;
    if ([self.currentVC isEqual:a]) {
        toV = b;
    } else {
        toV = a;
    }
    
    // Curl 翻页效果
    // UIViewAnimationOptionTransitionCurlUp, UIViewAnimationOptionTransitionCurlDown
    // Flip 翻转效果
    // UIViewAnimationOptionTransitionFlipFromLeft, UIViewAnimationOptionTransitionFlipFromRight
    // UIViewAnimationOptionTransitionFlipFromTop, UIViewAnimationOptionTransitionFlipFromDown
    [self transitionFromViewController:_currentVC toViewController:toV duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
    } completion:^(BOOL finished) {
        self.currentVC = toV;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

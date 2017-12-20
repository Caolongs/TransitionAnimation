//
//  ViewControllerTranstionPushVC.m
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import "ViewControllerTranstionPushVC.h"
#import "AnimatorPushPopTransition.h"
#import "ViewControllerTransitionToShowVC.h"

@interface ViewControllerTranstionPushVC () <UINavigationControllerDelegate>

@end

@implementation ViewControllerTranstionPushVC {
    
    UIButton *button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demo];
}

- (void)demo {
    [self prepareBubble];
}

- (void)prepareBubble {
    self.view.backgroundColor = [UIColor redColor];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width - 80) / 2,
                              self.view.frame.size.height - 80 - 64,
                              80,
                              80);
    [self.view addSubview:button];
    [button setTitle:@"+" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:60];
    
    button.layer.cornerRadius = 40;
    [button addTarget:self action:@selector(actionBubble:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionBubble:(UIButton *)sender {
    ViewControllerTransitionToShowVC *vc = [[ViewControllerTransitionToShowVC alloc] init];
    self.navigationController.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - <UINavigationControllerDelegate>

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    // Push/Pop
    AnimatorPushPopTransition *pushPopTransition = [[AnimatorPushPopTransition alloc] init];
    
    pushPopTransition.bubbleCenter = button.center;
    
    if (operation == UINavigationControllerOperationPush) {
        pushPopTransition.animatorTransitionType = kAnimatorTransitionTypePush;
    } else {
        pushPopTransition.animatorTransitionType = kAnimatorTransitionTypePop;
    }
    
    return pushPopTransition;
}

@end

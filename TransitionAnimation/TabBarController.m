//
//  TabBarController.m
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import "TabBarController.h"
#import "AnimatorBubbleTransition.h"

@interface TabBarController () <UITabBarControllerDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

#pragma mark - UITabBarControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC {
    
    AnimatorBubbleTransition *bubbleTransition = [[AnimatorBubbleTransition alloc] init];
    bubbleTransition.bubbleCenter = tabBarController.tabBar.center;
    bubbleTransition.animatorTransitionType = kAnimatorTransitionTypePresent;
    return bubbleTransition;
}

//- (id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
//                      interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController {
//    
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  ViewControllerTranstionPresentVC.m
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import "ViewControllerTranstionPresentVC.h"
#import "ViewControllerTransitionToShowVC.h"
#import "AnimatorPresentTransition.h"
#import "AnimatorPresentHalfTransition.h"
#import "AnimatorBubbleTransition.h"
#import "AnimatorDrawerTransition.h"

@interface ViewControllerTranstionPresentVC () < UIViewControllerTransitioningDelegate,AnimatorDrawerTransitionDelegate >

@end

@implementation ViewControllerTranstionPresentVC {
    
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
    ViewControllerTransitionToShowVC *presentedVC = [[ViewControllerTransitionToShowVC alloc] init];
    // 设置transitioningDelegate, 然后在其中实现协议方法即可.
    presentedVC.transitioningDelegate = self;
    [self presentViewController:presentedVC animated:YES completion:nil];
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    // 指定的继承UIViewControllerAnimatedTransitioning协议的对象.
    // 其中的协议方法即指定了转场动画.
    
    switch (_demoType) {
        case DemoViewControllerTransitionTypePresent:
        {
            // Present
            AnimatorPresentTransition *presentTransition = [[AnimatorPresentTransition alloc] init];
            presentTransition.animatorTransitionType = kAnimatorTransitionTypePresent;
            return presentTransition;
        }
        case DemoViewControllerTransitionTypePresentHalf:
        {
            // Present Half
            AnimatorPresentHalfTransition *presentHalfTransition = [[AnimatorPresentHalfTransition alloc] init];
            presentHalfTransition.animatorTransitionType = kAnimatorTransitionTypePresent;
            return presentHalfTransition;
        }
        case DemoViewControllerTransitionTypeBubble:
        {
            // Bubble
            AnimatorBubbleTransition *bubbleTransition = [[AnimatorBubbleTransition alloc] init];
            bubbleTransition.bubbleCenter = button.center;
            bubbleTransition.animatorTransitionType = kAnimatorTransitionTypePresent;
            return bubbleTransition;
        }
        case DemoViewControllerTransitionTypeDrawer:
        {
            // Drawer
            AnimatorDrawerTransition *drawerTransition = [[AnimatorDrawerTransition alloc] init];
            drawerTransition.animatorTransitionType = kAnimatorTransitionTypePresent;
            drawerTransition.offset = 50.f;
            drawerTransition.delegate = self;
            return drawerTransition;
        }
        default:
            break;
    }
    
    AnimatorPresentTransition *presentTransition = [[AnimatorPresentTransition alloc] init];
    presentTransition.animatorTransitionType = kAnimatorTransitionTypePresent;
    return presentTransition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    switch (_demoType) {
        case DemoViewControllerTransitionTypePresent:
        {
            // Present
            AnimatorPresentTransition *presentTransition = [[AnimatorPresentTransition alloc] init];
            presentTransition.animatorTransitionType = kAnimatorTransitionTypeDismiss;
            return presentTransition;
        }
        case DemoViewControllerTransitionTypePresentHalf:
        {
            // Present Half
            AnimatorPresentHalfTransition *presentHalfTransition = [[AnimatorPresentHalfTransition alloc] init];
            presentHalfTransition.animatorTransitionType = kAnimatorTransitionTypeDismiss;
            return presentHalfTransition;
        }
        case DemoViewControllerTransitionTypeBubble:
        {
            // Bubble
            AnimatorBubbleTransition *bubbleTransition = [[AnimatorBubbleTransition alloc] init];
            bubbleTransition.animatorTransitionType = kAnimatorTransitionTypeDismiss;
            bubbleTransition.bubbleCenter = button.center;
            return bubbleTransition;
        }
        case DemoViewControllerTransitionTypeDrawer:
        {
            // Drawer
            AnimatorDrawerTransition *drawerTransition = [[AnimatorDrawerTransition alloc] init];
            drawerTransition.animatorTransitionType = kAnimatorTransitionTypeDismiss;
            drawerTransition.offset = 50.f;
            drawerTransition.delegate = self;
            return drawerTransition;
        }
        default:
            break;
    }
    
    AnimatorPresentTransition *presentTransition = [[AnimatorPresentTransition alloc] init];
    presentTransition.animatorTransitionType = kAnimatorTransitionTypeDismiss;
    return presentTransition;
}

#pragma mark - <AnimatorDrawerTransitionDelegate>

- (void)AnimatorDrawerTransitionDismissViaTapGesture {
    
}

@end

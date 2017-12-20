//
//  AnimatedBaseTransition.m
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import "AnimatorPresentTransition.h"

@implementation AnimatorPresentTransition

- (instancetype)init {
    self = [super init];
    if (self) {
    
    }
    return self;
}

// 动画的持续时间
// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

// This method can only be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
}

- (void)animationPresent {    
    // fromView的起始frame
    self.fromView.frame = [self.transitionContext initialFrameForViewController:self.from];
    
    
    // 设置toView在转场开始时的位置和alpha.
    self.toView.frame = [self.transitionContext initialFrameForViewController:self.to]; // 全为0, 则toView从左上角扩散出来
//    self.toView.frame = CGRectMake(CGRectGetMinX(self.fromView.frame),
//                              CGRectGetHeight(self.fromView.frame),
////                              CGRectGetMaxY(self.fromView.frame) / 2, // 从中间往上弹出来
////                              CGRectGetMinY(self.fromView.frame), // 在fromView之上渐变出现
//                              CGRectGetWidth(self.fromView.frame),
//                              CGRectGetHeight(self.fromView.frame));
    self.toView.alpha = 0.0f;
    
    // containerView为transitionContext所包含的, 所有的动画都在该view中进行.
    [self.containerView addSubview:self.toView];

    NSTimeInterval duration = [self transitionDuration:self.transitionContext];
    typeof (&*self) __weak weakSelf = self;
    
    self.toView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        weakSelf.toView.transform = CGAffineTransformIdentity;
        
        // 指定位置
        weakSelf.toView.frame = [weakSelf.transitionContext finalFrameForViewController:weakSelf.to];
        weakSelf.toView.alpha = 1.0f;
        
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [weakSelf.transitionContext transitionWasCancelled];
        [weakSelf.transitionContext completeTransition:!wasCancelled];
    }];
    
}

- (void)animationDismiss {
    self.toView.frame = [self.transitionContext finalFrameForViewController:self.to];
    [self.containerView insertSubview:self.toView belowSubview:self.fromView];
    
    
    NSTimeInterval duration = [self transitionDuration:self.transitionContext];
    typeof (&*self) __weak weakSelf = self;
    
    [UIView animateWithDuration:duration animations:^{
        weakSelf.fromView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        weakSelf.fromView.frame = CGRectZero;
        weakSelf.fromView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [weakSelf.transitionContext transitionWasCancelled];
        [weakSelf.transitionContext completeTransition:!wasCancelled];
    }];
}

// @optional
// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
- (void)animationEnded:(BOOL) transitionCompleted {
    NSLog(@"%s", __func__);
} 

@end

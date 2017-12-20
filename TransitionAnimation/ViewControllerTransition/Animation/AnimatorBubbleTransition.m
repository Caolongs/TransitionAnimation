//
//  AnimatedBaseTransition.m
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import "AnimatorBubbleTransition.h"

@implementation AnimatorBubbleTransition

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

// 动画的持续时间
// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

// This method can only be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
}

- (void)animationPresent {
    // 实际上, 在toView的下边, 添加了一个bubbleView, 从最初的bubble的center位置开始, 通过scale动画呈现出来.
    // BubbleView与toView的背景色一致.
    UIView *bubbleView = [[UIView alloc] init];
    bubbleView.backgroundColor = self.toView.backgroundColor; // [UIColor purpleColor];
    CGSize toViewSize = self.toView.frame.size;
    CGFloat x = fmax(_bubbleCenter.x, toViewSize.width);
    CGFloat y = fmax(_bubbleCenter.y, toViewSize.height);
    CGFloat radius = sqrt(x * x + y * y);
    bubbleView.frame = CGRectMake(0, 0, radius * 2, radius * 2);
    bubbleView.layer.cornerRadius = CGRectGetHeight(bubbleView.frame) / 2;
    bubbleView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    bubbleView.center = _bubbleCenter;
    [self.containerView addSubview:bubbleView];
    
    // toView要跟随bubbleView一起做动画
    self.toView.frame = [self.transitionContext finalFrameForViewController:self.to];
    CGPoint toViewFinalCenter = self.toView.center;
    self.toView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    self.toView.center = _bubbleCenter;
    self.toView.alpha = 0.0;
    [self.containerView addSubview:self.toView];
    
    
    NSTimeInterval duration = [self transitionDuration:self.transitionContext];
    typeof (&*self) __weak weakSelf = self;
    
    [UIView animateWithDuration:duration animations:^{
        bubbleView.transform = CGAffineTransformIdentity;
        
        weakSelf.toView.transform = CGAffineTransformIdentity;
        weakSelf.toView.alpha = 1.0f;
        weakSelf.toView.center = toViewFinalCenter;
    } completion:^(BOOL finished) {
        [weakSelf.transitionContext completeTransition:![weakSelf.transitionContext transitionWasCancelled]];
    }];
    
//    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        bubbleView.transform = CGAffineTransformIdentity;
//        weakSelf.toView.transform = CGAffineTransformIdentity;
//        weakSelf.toView.alpha = 1.0f;
//        weakSelf.toView.center = toViewFinalCenter;
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//    }];
    
}

- (void)animationDismiss {
    self.toView.frame = [self.transitionContext finalFrameForViewController:self.to];
    [self.containerView insertSubview:self.toView belowSubview:self.fromView];
    
    // 与present bubble时的过程相反.
    UIView *bubbleView = [[UIView alloc] init];
    bubbleView.backgroundColor = self.fromView.backgroundColor;
    CGSize fromViewSize = self.fromView.frame.size;
    CGFloat x = fmax(_bubbleCenter.x, fromViewSize.width);
    CGFloat y = fmax(_bubbleCenter.y, fromViewSize.height);
    CGFloat radius = sqrt(x * x + y * y);
    bubbleView.frame = CGRectMake(0, 0, radius * 2, radius * 2);
    bubbleView.layer.cornerRadius = radius;
    bubbleView.transform = CGAffineTransformIdentity;
    bubbleView.center = _bubbleCenter;
    [self.containerView insertSubview:bubbleView belowSubview:self.fromView];
    
    
    NSTimeInterval duration = [self transitionDuration:self.transitionContext];
    typeof (&*self) __weak weakSelf = self;
    
    [UIView animateWithDuration:duration animations:^{
        bubbleView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        
        weakSelf.fromView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        weakSelf.fromView.center = weakSelf.bubbleCenter;
    } completion:^(BOOL finished) {
        [weakSelf.transitionContext completeTransition:![weakSelf.transitionContext transitionWasCancelled]];
    }];
}

// @optional
// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
- (void)animationEnded:(BOOL) transitionCompleted {
    NSLog(@"%s", __func__);
}

@end

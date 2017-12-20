//
//  AnimatedBaseTransition.m
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import "AnimatorDrawerTransition.h"

@interface AnimatorDrawerTransition () <

    UIGestureRecognizerDelegate
>

@end

@implementation AnimatorDrawerTransition {

    UITapGestureRecognizer *tapGestureDismiss;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
}

- (void)animationPresent {
    // fromView的截屏放在toView的上方，执行偏移。而toView不动即可。
    // 截屏要考虑到当前屏幕上的实际view。
    /*
    UIView *snapshotFromView = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:YES];
    snapshotFromView.frame = self.fromView.frame;
    snapshotFromView.tag = 1001;
    [self.containerView addSubview:snapshotFromView];
    */
    
    // 直接屏幕截屏，会有状态栏。
    UIGraphicsBeginImageContextWithOptions(self.fromView.frame.size, YES, 0.0);
    [self.fromView drawViewHierarchyInRect:self.fromView.frame afterScreenUpdates:YES];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *snapshotFromView = [[UIImageView alloc] initWithFrame:self.fromView.frame];
    snapshotFromView.image = snapshot;
    snapshotFromView.tag = 1001;
    snapshotFromView.userInteractionEnabled = YES;
    [self.containerView addSubview:snapshotFromView];
    
    tapGestureDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionDismiss:)];
    tapGestureDismiss.delegate = self;
    [snapshotFromView addGestureRecognizer:tapGestureDismiss];
    
    
    
    [self.containerView insertSubview:self.toView belowSubview:snapshotFromView];
    
    NSTimeInterval duration = [self transitionDuration:self.transitionContext];
    typeof (&*self) __weak weakSelf = self;
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        snapshotFromView.center = CGPointMake(self.fromView.center.x * 3 - self.offset, self.fromView.center.y);
        
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [weakSelf.transitionContext transitionWasCancelled];
        [weakSelf.transitionContext completeTransition:!wasCancelled];
    }];
    
}

- (void)animationDismiss {
    
    UIImageView *snapshotToView = (UIImageView *)[self.containerView viewWithTag:1001];
    if (tapGestureDismiss) {
        [snapshotToView removeGestureRecognizer:tapGestureDismiss];
    }
    
    [[self.containerView viewWithTag:1001] removeFromSuperview];
    
    [self.containerView addSubview:self.toView];
    
    CGPoint originalCenterOfToView = CGPointMake(self.toView.center.x * 3 - self.offset, self.toView.center.y);
    CGPoint destinationCenterOfToView = self.toView.center;
    
    self.toView.center = originalCenterOfToView;
    
    NSTimeInterval duration = [self transitionDuration:self.transitionContext];
    typeof (&*self) __weak weakSelf = self;
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        weakSelf.toView.center = destinationCenterOfToView;
        
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [weakSelf.transitionContext transitionWasCancelled];
        [weakSelf.transitionContext completeTransition:!wasCancelled];
    }];
}

- (void)actionDismiss:(UITapGestureRecognizer *)sender {
    NSLog(@"actionDismiss");
    if (_delegate && [_delegate respondsToSelector:@selector(AnimatorDrawerTransitionDismissViaTapGesture)]) {
        [_delegate AnimatorDrawerTransitionDismissViaTapGesture];
    }
}

#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press {
    return YES;
}

@end

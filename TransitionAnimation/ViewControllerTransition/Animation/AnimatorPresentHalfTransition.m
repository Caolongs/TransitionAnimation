//
//  AnimatedBaseTransition.m
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import "AnimatorPresentHalfTransition.h"

@implementation AnimatorPresentHalfTransition

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
}

- (void)animationPresent {
    // fromView的截屏放在toView的下方。
    UIView *snapshotFromView = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:YES];
    snapshotFromView.frame = self.fromView.frame;
    [self.containerView addSubview:snapshotFromView];
    
    // 此时的toView的frame已经与屏幕一致了。
    CGRect originalFrameOfToView = CGRectMake(
                                              0,
                                              CGRectGetHeight(self.toView.frame),
                                              CGRectGetWidth(self.toView.frame),
                                              CGRectGetHeight(self.toView.frame)
                                              );
    CGRect destinationFrameOfToView = CGRectMake(
                                                 0,
                                                 CGRectGetHeight(self.toView.frame) / 2,
                                                 CGRectGetWidth(self.toView.frame),
                                                 CGRectGetHeight(self.toView.frame)
                                                 );
    
    self.toView.frame = originalFrameOfToView;
    
    // containerView为transitionContext所包含的, 所有的动画都在该view中进行.
    [self.containerView addSubview:self.toView];
    
    NSTimeInterval duration = [self transitionDuration:self.transitionContext];
    typeof (&*self) __weak weakSelf = self;
    
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         weakSelf.toView.frame = destinationFrameOfToView;
                         
                         weakSelf.fromView.transform = CGAffineTransformMakeScale(0.9, 0.9);
                         snapshotFromView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        
    } completion:^(BOOL finished) {
        weakSelf.fromView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
        BOOL wasCancelled = [weakSelf.transitionContext transitionWasCancelled];
        [weakSelf.transitionContext completeTransition:!wasCancelled];
        
    }];
    
}

- (void)animationDismiss {
    CGRect destinationFrameOfFromView = CGRectMake(
                                                0,
                                                CGRectGetHeight(self.fromView.frame),
                                                CGRectGetWidth(self.fromView.frame),
                                                CGRectGetHeight(self.fromView.frame)
                                                );
    
    // toView的截屏放在fromView的下方。
    
    UIGraphicsBeginImageContextWithOptions(self.toView.frame.size, YES, 0.0); //第三个参数是scale
    // 将view中的内容渲染到image context中
    [self.toView drawViewHierarchyInRect:self.toView.frame afterScreenUpdates:YES];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *snapshotToView = [[UIImageView alloc] initWithFrame:self.toView.frame];
    snapshotToView.image = snapshot;
    [self.containerView addSubview:snapshotToView];
    
    snapshotToView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    
    self.toView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    
    [self.containerView addSubview:self.toView];
    
    [self.containerView addSubview:self.fromView];
    
    NSTimeInterval duration = [self transitionDuration:self.transitionContext];
    typeof (&*self) __weak weakSelf = self;
    
    [UIView animateWithDuration:duration animations:^{
        
        weakSelf.fromView.frame = destinationFrameOfFromView;
        
        snapshotToView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        weakSelf.toView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    } completion:^(BOOL finished) {
        
        BOOL wasCancelled = [weakSelf.transitionContext transitionWasCancelled];
        [weakSelf.transitionContext completeTransition:!wasCancelled];
    }];
}

@end

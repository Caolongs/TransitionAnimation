//
//  AnimatedBaseTransition.h
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimatorTransitionType) {
    kAnimatorTransitionTypePresent = 0,
    kAnimatorTransitionTypeDismiss,
    kAnimatorTransitionTypePush,
    kAnimatorTransitionTypePop,
};



@interface AnimatedBaseTransition : NSObject <UIViewControllerAnimatedTransitioning>


@property (nonatomic, assign) AnimatorTransitionType animatorTransitionType;

@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIViewController *from;
@property (nonatomic, strong) UIViewController *to;

@property (nonatomic, strong) UIView *fromView;
@property (nonatomic, strong) UIView *toView;

@end

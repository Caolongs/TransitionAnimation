//
//  AnimatedBaseTransition.m
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import "AnimatedBaseTransition.h"

@protocol AnimatorDrawerTransitionDelegate <NSObject>

- (void)AnimatorDrawerTransitionDismissViaTapGesture;

@end

@interface AnimatorDrawerTransition : AnimatedBaseTransition

@property (nonatomic, weak) id<AnimatorDrawerTransitionDelegate> delegate;

@property (nonatomic, assign) CGFloat offset;

@end

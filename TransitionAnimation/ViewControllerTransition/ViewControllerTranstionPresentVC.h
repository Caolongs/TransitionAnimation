//
//  ViewControllerTranstionPresentVC.h
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DemoViewControllerTransitionType) {
    DemoViewControllerTransitionTypePresent = 0,
    DemoViewControllerTransitionTypePresentHalf,
    DemoViewControllerTransitionTypeBubble,
    DemoViewControllerTransitionTypeDrawer,
};

@interface ViewControllerTranstionPresentVC : UIViewController

@property (nonatomic, assign) DemoViewControllerTransitionType demoType;

@end

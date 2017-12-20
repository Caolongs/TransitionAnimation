//
//  ViewControllerTransitionToShowVC.m
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import "ViewControllerTransitionToShowVC.h"

@interface ViewControllerTransitionToShowVC ()

@end

@implementation ViewControllerTransitionToShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    [self addLabel];
    
    [self addBtns];
    
    [self prepareBubble];
}

- (void)addLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
    label.text = [NSString stringWithFormat:@"%@", NSStringFromClass([self class])];
    [self.view addSubview:label];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
}

- (void)addBtns {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    [btn setTitle:@"Back" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(actionDismiss:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)prepareBubble {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width - 80) / 2,
                              self.view.frame.size.height - 80 - 64,
                              80,
                              80);
    [self.view addSubview:button];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    //    button.center = self.view.center;
    button.layer.cornerRadius = 40;
    [button addTarget:self action:@selector(actionDismiss:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionDismiss:(UIButton *)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.parentViewController.childViewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

@end

# TransitionAnimation
转场动画

## 1. transitionFromViewController
UIViewController自带的方法: 
`transitionFromViewController:toViewController:duration:options:animations:completion: `
通常的使用场景是 在多个Child ViewController之间切换.
```
AViewController *a = self.childViewControllers[0];
BViewController *b = self.childViewControllers[1];
CViewController *c = self.childViewControllers[2];

// Curl 翻页效果
// UIViewAnimationOptionTransitionCurlUp, UIViewAnimationOptionTransitionCurlDown
// Flip 翻转效果
// UIViewAnimationOptionTransitionFlipFromLeft, UIViewAnimationOptionTransitionFlipFromRight
// UIViewAnimationOptionTransitionFlipFromTop, UIViewAnimationOptionTransitionFlipFromDown

[self transitionFromViewController:_currentViewController
                  toViewController:b
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{

} completion:^(BOOL finished) {

}];
```

## 2. CATransition
CATransition继承自CALayer, 包含了一些场景的动画效果. 如Fade，Cube，Ripple，PageCurl，CameraIrilHollow等. 使用如下:
```
CATransition *animation = [CATransition animation];
animation.duration = 0.5;
animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
animation.type = kCATransitionFade;

// 在当前view上执行CATransition动画
// [self.view.layer addAnimation:animation forKey:@"animation"];

// 在window上执行CATransition, 即可在ViewController转场时执行动画。
[self.view.window.layer addAnimation:animation forKey:@"kTransitionAnimation"];

DemoCATransitionPresentedViewController *presentedVC = [[DemoCATransitionPresentedViewController alloc] init];
[self presentViewController:presentedVC animated:NO completion:nil];
```
```
[self.navigationController.view.layer addAnimation:animation forKey:@"kTransitionAnimation"];

DemoCATransitionPushedViewController *pushedVC = [[DemoCATransitionPushedViewController alloc] init];
[self.navigationController pushViewController:pushedVC animated:NO];
```

## 3. Transition Animation
自定义动画：转场动画实现细节须遵守UIViewControllerAnimatedTransitioning协议，实现该协议的对象中即包含了转场动画的细节实现代码
```
// 转场动画时间.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;
```
```
// 转场动画细节实现 该方法中则主要负责转场动画细节的实现.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;
```
```
//由实现了本协议的对象创建的转场如果是可被中断的，那么可实现此方法。
//例如，可返回一个UIViewPropertyAnimator的实例。
//此方法被期望返回与转场相同的实例对象
- (id <UIViewImplicitlyAnimating>) interruptibleAnimatorForTransition:(id <UIViewControllerContextTransitioning>)transitionContext
```
```
//动画结束回调方法
- (void)animationEnded:(BOOL) transitionCompleted
```

* ##### present/dismiss 动画
```
    ViewControllerTransitionToShowVC *presentedVC = [[ViewControllerTransitionToShowVC alloc] init];
    // 设置transitioningDelegate, 然后在其中实现协议方法即可.
    presentedVC.transitioningDelegate = self;
    [self presentViewController:presentedVC animated:YES completion:nil];
```
`<UIViewControllerTransitioningDelegate>`
```
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator;

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator;

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0);
```
* ##### push/pop动画
```
self.navigationController.delegate = self;
[self.navigationController pushViewController:itemVC animated:YES];
```
`<UINavigationControllerDelegate>`主要实现方法
```
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0);

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);
```

* ##### UITabBarController
`<UITabBarControllerDelegate>`主要实现方法
```
- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC;
```



//
//  CATransitionTableVCTableViewController.m
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//




#import "CATransitionTableVCTableViewController.h"
#import "CATransitionToVC.h"


@interface CATransitionTableVCTableViewController ()

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation CATransitionTableVCTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"DemoCATransition";
    [self addBtns];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _titleArr = @[
               // 常见四种
               @"Fade",
               @"Push",
               @"MoveIn",
               @"Reveal",
               
               @"Cube",
               @"Flip",
               @"SuckEffect",
               @"RippleEffect",
               @"PageCurl",
               @"PageUnCurl",
               @"CameraIrilHollowOpen",
               @"CameraIrisHollowClose",
               ];
}

- (void)addBtns{
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionBack:)];
    self.navigationItem.leftBarButtonItem = btnLeft;
}

- (void)actionBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = _titleArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     CATransition *animation = [self configTransitionIndexPath:indexPath];
    
    // 在当前view上执行CATransition动画
    // [self.view.layer addAnimation:animation forKey:@"animation"];
    
    // 在window上执行CATransition, 即可在ViewController转场时执行动画。
    [self.view.window.layer addAnimation:animation forKey:@"kTransitionAnimation"];

    CATransitionToVC *vc = [[CATransitionToVC alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self presentViewController:vc animated:NO completion:nil];
    //    [self.navigationController pushViewController:vc animated:YES];
}


/* 过渡效果
 fade           //交叉淡化过渡(不支持过渡方向)
 push           //新视图把旧视图推出去
 moveIn         //新视图移到旧视图上面
 reveal         //将旧视图移开,显示下面的新视图
 cube           //立方体翻滚效果
 oglFlip        //上下左右翻转效果
 suckEffect     //收缩效果，如一块布被抽走(不支持过渡方向)
 rippleEffect   //滴水效果(不支持过渡方向)
 pageCurl       //向上翻页效果
 pageUnCurl     //向下翻页效果
 cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
 cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
 */
- (CATransition *)configTransitionIndexPath:(NSIndexPath *)indexPath {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    NSString *name = self.titleArr[indexPath.row];
    
    
    if ([name isEqualToString:@"Fade"]) {
         animation.type = kCATransitionFade;
    } else if ([name isEqualToString:@"Push"]) {
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        
    } else if ([name isEqualToString:@"MoveIn"]) {
        animation.type = kCATransitionMoveIn;
        animation.subtype = kCATransitionFromRight;
        
    } else if ([name isEqualToString:@"Reveal"]) {
        animation.type = kCATransitionReveal;
        animation.subtype = kCATransitionFromRight;
        
    } else if ([name isEqualToString:@"Cube"]) {
        animation.type = @"cube";
        animation.subtype = kCATransitionFromRight;
        
    } else if ([name isEqualToString:@"Flip"]) {
        animation.type = kCATransitionReveal;
        animation.subtype = kCATransitionFromRight;
        
    } else if ([name isEqualToString:@"SuckEffect"]) {
         animation.type = @"suckEffect";
        
    } else if ([name isEqualToString:@"RippleEffect"]) {
        animation.type = @"rippleEffect";
        
    } else if ([name isEqualToString:@"PageCurl"]) {
        animation.type = @"pageCurl";
        animation.subtype = kCATransitionFromRight;
        
    } else if ([name isEqualToString:@"PageUnCurl"]) {
        animation.type = @"pageUnCurl";
        animation.subtype = kCATransitionFromRight;
        
    } else if ([name isEqualToString:@"CameraIrilHollowOpen"]) {
        animation.type = @"cameraIrisHollowOpen";
    } else if ([name isEqualToString:@"CameraIrisHollowClose"]) {
        animation.type = @"cameraIrisHollowClose";
    }
    
    return animation;
    
}


@end

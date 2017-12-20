//
//  ViewControllerTransitionTableVC.m
//  TransitionAnimation
//
//  Created by cao longjian on 2017/12/20.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

#import "ViewControllerTransitionTableVC.h"
#import "ViewControllerTranstionPresentVC.h"
#import "ViewControllerTranstionPushVC.h"

@interface ViewControllerTransitionTableVC ()

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation ViewControllerTransitionTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"DemoViewControllerTransition";
    
    [self addBtns];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _titleArr = @[
               @"Present",
               @"Present Half",
               @"Bubble",
               @"Drawer",
               @"Push/Pop",
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
    if (indexPath.row != _titleArr.count - 1) {
        ViewControllerTranstionPresentVC *demoVC = [[ViewControllerTranstionPresentVC alloc] init];
        demoVC.demoType = indexPath.row;
        demoVC.navigationItem.title = _titleArr[indexPath.row];
        [self.navigationController pushViewController:demoVC animated:YES];
    } else {
        ViewControllerTranstionPushVC *collectionVC = [[ViewControllerTranstionPushVC alloc] init];
        collectionVC.navigationItem.title = _titleArr[indexPath.row];
        [self.navigationController pushViewController:collectionVC animated:YES];
    }
}

@end

//
//  CHControllerContainerView.m
//  balance
//
//  Created by ZhangTino on 2018/7/20.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHControllerContainerView.h"

@interface CHControllerContainerView () {
    __weak UIViewController *_parentController;
}

@end

@implementation CHControllerContainerView

- (instancetype)initWithController:(UIViewController *)parentController
{
    if (self = [super init]) {
        _parentController = parentController;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (self.parentController) {
        if (newSuperview) {
            for (UIViewController *contentController in _contentControllers) {
                [self.parentController addChildViewController:contentController];
            }
        } else {
            for (UIViewController *contentController in _contentControllers) {
                [contentController willMoveToParentViewController:nil];
            }
        }
    }
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if (self.parentController) {
        if (self.superview) {
            for (UIViewController *contentController in _contentControllers) {
                [contentController didMoveToParentViewController:self.parentController];
            }
        } else {
            for (UIViewController *contentController in _contentControllers) {
                [contentController removeFromParentViewController];
            }
        }
    }
}

#pragma mark - Properties
- (void)setContentControllers:(NSArray *)contentControllers
{
    NSMutableArray *views = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    for (UIViewController *contentController in contentControllers) {
        if (!contentController) {
            return;
        }
        [views addObject:contentController.view];
        [titles addObject:contentController.title ?: @"??"];
    }
    
    if (self.parentController && self.superview) {
        for (UIViewController *contentController in _contentControllers) {
            [contentController willMoveToParentViewController:nil];
        }
        for (UIViewController *contentController in contentControllers) {
            [self.parentController addChildViewController:contentController];
        }
    }
    self.contentViews = views;
    if (self.parentController && self.superview) {
        for (UIViewController *contentController in _contentControllers) {
            [contentController removeFromParentViewController];
        }
        for (UIViewController *contentController in contentControllers) {
            [contentController didMoveToParentViewController:self.parentController];
        }
    }
    self.topBar.titles = titles;
    
    _contentControllers = contentControllers;
}

- (UIViewController *)parentController
{
    return _parentController;
}

@end

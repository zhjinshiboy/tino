//
//  CHControllerContainerView.h
//  balance
//
//  Created by ZhangTino on 2018/7/20.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHViewContainerView.h"

@interface CHControllerContainerView : CHViewContainerView

// 可以为nil，但子VC就没法收到appear和disappear等事件
@property (nonatomic, readonly) UIViewController *parentController;

// 设置后不会layoutSubviews，需要手动调用
@property (nonatomic, strong) NSArray *contentControllers;

- (instancetype)initWithController:(UIViewController *)parentController;

@end

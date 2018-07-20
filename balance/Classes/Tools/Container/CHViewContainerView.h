//
//  CHViewContainerView.h
//  balance
//
//  Created by ZhangTino on 2018/7/20.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHContainerTopBar.h"
#import <UIKit/UIKit.h>

@class CHViewContainerView;

@protocol CHContainerViewDelegate <NSObject>

- (void)biliContainerViewBeginDrag:(CHViewContainerView *)containerView;

@end

@interface CHViewContainerView : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) id<CHContainerViewDelegate> delegate;

// 设置后不会layoutSubviews，需要手动调用
@property (nonatomic, strong) NSArray *contentViews;

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) CHContainerTopBar *topBar;

@property (nonatomic, assign) CGFloat topBarHeight;

- (void)preloadData;

@end

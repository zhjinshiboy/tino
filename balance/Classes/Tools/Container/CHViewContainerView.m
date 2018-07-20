//
//  CHViewContainerView.m
//  balance
//
//  Created by ZhangTino on 2018/7/20.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHViewContainerView.h"

@interface CHViewContainerView () <CHContainerTopBarDelegate> {
    UIScrollView *_scrollView;
    CHContainerTopBar *_topBar;
}

@end

@implementation CHViewContainerView

- (instancetype)init
{
    if (self = [super init]) {
        _topBarHeight = 64;
        [self addSubview:self.scrollView];
        [self addSubview:self.topBar];
        self.topBar.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    self.scrollView.delegate = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    self.topBar.frame = CGRectMake(0, 0, viewWidth, self.topBarHeight);
    
    CGFloat scrollViewHeight = CGRectGetHeight(self.bounds) - self.topBarHeight;
    self.scrollView.frame = CGRectMake(0, self.topBarHeight, viewWidth, scrollViewHeight);
    self.scrollView.contentSize = CGSizeMake(viewWidth * [_contentViews count], scrollViewHeight);
    self.scrollView.contentOffset = CGPointMake(self.topBar.selectedIndex * viewWidth, 0);
    for (NSUInteger index = 0; index < [_contentViews count]; index++) {
        UIView *contentView = _contentViews[index];
        contentView.frame = CGRectMake(viewWidth * index, 0, viewWidth, scrollViewHeight);
    }
}

- (void)preloadData
{
    
}

#pragma mark Properties
- (void)setContentViews:(NSArray *)contentViews
{
    for (UIView *contentView in contentViews) {
        if (!contentView) {
            return;
        }
    }
    
    for (UIView *contentView in _contentViews) {
        [contentView removeFromSuperview];
    }
    for (UIView *contentView in contentViews) {
        [self.scrollView addSubview:contentView];
    }
    
    _contentViews = contentViews;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}

- (CHContainerTopBar *)topBar
{
    if (!_topBar) {
        _topBar = [CHContainerTopBar new];
    }
    return _topBar;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.delegate) {
        [self.delegate biliContainerViewBeginDrag:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.topBar updateIndicator:scrollView.contentOffset.x / scrollView.contentSize.width];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.topBar.selectedIndex = (NSUInteger)(scrollView.contentOffset.x / CGRectGetWidth(scrollView.bounds));
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewDidEndDecelerating:scrollView];
    }
}

#pragma mark - Observer
- (void)didChangeSelectIndex:(NSUInteger)selectedIndex animated:(BOOL)animated
{
    if (animated) {
        self.userInteractionEnabled = NO;
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            self.userInteractionEnabled = YES;
        });
    }
    [self.scrollView setContentOffset:CGPointMake(selectedIndex * CGRectGetWidth(self.scrollView.bounds), 0) animated:animated];
}

@end

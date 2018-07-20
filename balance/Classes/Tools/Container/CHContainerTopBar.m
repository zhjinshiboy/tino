//
//  CHContainerTopBar.m
//  balance
//
//  Created by ZhangTino on 2018/7/20.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHContainerTopBar.h"

const CGFloat CHFeelingsScale = 0;

@interface CHContainerTopBar () {
    UIView *_selectionIndicator;
    UIScrollView *_scrollView;
    UIView *_bottomLine;
    CGFloat expectedItemWidth;
}

@end

@implementation CHContainerTopBar
@synthesize selectedIndex = _selectedIndex;

- (instancetype)init
{
    if (self = [super init]) {
        _titleFont = [UIFont fontWithNumber:0];
        _topPadding = 20;
        _itemPadding = 28;
        _itemButtons = [NSMutableArray array];
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.selectionIndicator];
        [self addSubview:self.bottomLine];
        self.backgroundColor = [UIColor colorWithNumber:3];
        self.selectionIndicator.backgroundColor = [UIColor colorWithNumber:1];
        [self setTitles:_titles];
    }
    return self;
}

- (void)setSelectionIndicatorColor:(UIColor *)color {
    self.selectionIndicator.backgroundColor = color;
}

- (UIColor *)mainColor
{
    if (self.selectedColor) {
        return self.selectedColor;
    }
    return [UIColor colorWithNumber:1];
}

- (UIColor *)grayColor
{
    if (self.unSelectedColor) {
        return self.unSelectedColor;
    }
    return [UIColor colorWithNumber:6];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat barWidth = CGRectGetWidth(self.bounds);
    CGFloat barHeight = CGRectGetHeight(self.bounds);
    CGFloat scrollViewWidth = barWidth - self.leftPadding - self.rightPadding;
    CGFloat scrollViewHeight = barHeight - self.topPadding;
    
    [self layoutItems:CGSizeMake(scrollViewWidth, scrollViewHeight)];
    
    if (self.scrollView.contentSize.width <= scrollViewWidth) {
        if (self.scrollView.contentSize.width < scrollViewWidth) {
            CGPoint center = self.scrollView.center;
            self.scrollView.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, scrollViewHeight);
            self.scrollView.center = center;
        }
        self.scrollView.scrollEnabled = NO;
    } else {
        self.scrollView.scrollEnabled = YES;
    }
    self.scrollView.contentOffset = CGPointZero;
    
    CGFloat lineWidth = 1.0 / [UIScreen mainScreen].scale;
    self.bottomLine.frame = CGRectMake(0, barHeight - lineWidth, barWidth, lineWidth);
}

- (void)layoutItems:(CGSize)size
{
    self.scrollView.frame = CGRectMake(self.leftPadding, self.topPadding, size.width, size.height);
    expectedItemWidth = CHScreenWidth / MAX(1.0f,[_itemButtons count]);
    
    self.scrollView.contentSize = CGSizeMake(expectedItemWidth * [_itemButtons count], size.height);
    for (NSUInteger index = 0; index < [_itemButtons count]; index++) {
        UIButton *button = (UIButton *)[_itemButtons objectAtIndex:index];
        button.frame = CGRectMake(expectedItemWidth * index, 0, expectedItemWidth, size.height);
    }
    self.selectionIndicator.frame = CGRectMake(expectedItemWidth * _selectedIndex, size.height - 3, expectedItemWidth, 3);
}

#pragma mark - Properties
- (void)setTitles:(NSArray *)titles
{
    for (NSString *title in titles) {
        if (!title) {
            return;
        }
    }
    
    for (UIButton *button in _itemButtons) {
        button.hidden = YES;
    }
    for (NSInteger index = 0; index < [titles count]; index++) {
        UIButton *button = nil;
        if (index < [_itemButtons count]) {
            button = (UIButton *)[_itemButtons objectAtIndex:index];
            button.hidden = NO;
        } else {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setAdjustsImageWhenHighlighted:NO];
            [button setTitleColor:[self mainColor] forState:UIControlStateHighlighted];
            button.titleLabel.font = self.titleFont;
            button.tag = index;
            [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:button];
            [_itemButtons addObject:button];
        }
        if (index != _selectedIndex) {
            [button setTitleColor:self.unSelectedColor?self.unSelectedColor:[self grayColor] forState:UIControlStateNormal];
#ifndef CH_DISABLE_BILI_FEELINGS_SCALE
            button.transform = CGAffineTransformIdentity;
#endif
        } else {
            [button setTitleColor:[self mainColor] forState:UIControlStateNormal];
#ifndef DISABLE_BILI_FEELINGS_SCALE
            CGFloat scale = 1 + CHFeelingsScale;
            button.transform = CGAffineTransformMakeScale(scale, scale);
#endif
        }
        [button setTitle:titles[index] forState:UIControlStateNormal];
    }
    [self.scrollView bringSubviewToFront:self.selectionIndicator];
    _titles = titles;
}

- (void)relpaceButtonWithButton:(UIButton *)button index:(NSInteger)index
{
    if (button && index < self.itemButtons.count) {
        for (int i = 0 ; i < self.itemButtons.count; i++) {
            if (i == index) {
                UIButton * btn = self.itemButtons[i];
                button.tag = btn.tag;
                [btn removeFromSuperview];
            }
        }
        button.titleLabel.font = self.titleFont;
        [button setTitleColor:[self mainColor] forState:UIControlStateHighlighted];
        [self.itemButtons replaceObjectAtIndex:index withObject:button];
        [self.scrollView addSubview:button];
        [self setTitles:_titles];
    }
}


- (void)replaceTitleWithString:(NSString *)text index:(NSInteger)index
{
    if (text && index < _titles.count) {
        NSMutableArray *tempTitles = [[NSMutableArray alloc]initWithArray:_titles];
        [tempTitles replaceObjectAtIndex:index withObject:text];
        [self setTitles:tempTitles];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [self setSelectedIndex:selectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated
{
    if (selectedIndex < [_itemButtons count] && selectedIndex != _selectedIndex) {
        UIButton *button = (UIButton *)[_itemButtons objectAtIndex:_selectedIndex];
        // fix the bug of unselected button color
        [button setTitleColor:self.unSelectedColor?self.unSelectedColor:[self grayColor] forState:UIControlStateNormal];
        
        button = (UIButton *)[_itemButtons objectAtIndex:selectedIndex];
        [button setTitleColor:self.selectedColor?self.selectedColor:[UIColor colorWithNumber:1] forState:UIControlStateNormal];
#ifndef DISABLE_BILI_FEELINGS_SCALE
        CGFloat scale = 1 + CHFeelingsScale;
        button.transform = CGAffineTransformMakeScale(scale, scale);
#endif
        
        [self willChangeValueForKey:@"selectedIndex"];
        _selectedIndex = selectedIndex;
        [self didChangeValueForKey:@"selectedIndex"];
        if (self.delegate) {
            [self.delegate didChangeSelectIndex:selectedIndex animated:animated];
        }
    }
}

- (UIView *)selectionIndicator
{
    if (!_selectionIndicator) {
        _selectionIndicator = [UIView new];
    }
    return _selectionIndicator;
}

- (UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = [UIColor colorWithNumber:1];
    }
    return _bottomLine;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}

- (NSArray *)items
{
    return _itemButtons;
}

#pragma mark - Events
- (void)updateIndicator:(CGFloat)progress
{
    if (progress != progress) {
        // Check NaN
        return;
    }
    if (self.scrollView.contentSize.width == 0 || expectedItemWidth == 0) {
        // Avoid NaN
        return;
    }
    [self updateIndicatorWithProgress:progress];
    
    if (self.scrollView.scrollEnabled) {
        NSUInteger itemCount = [_itemButtons count];
        CGFloat offsetProgress = progress * itemCount / (itemCount - 1);
        CGPoint newOffset = CGPointMake((self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.bounds)) * offsetProgress, 0);
        [self.scrollView setContentOffset:newOffset];
    }
    
    // 情怀
    for (UIButton *button in _itemButtons) {
        CGFloat feelingsPower = 1 - MIN(1, ABS(self.selectionIndicator.center.x - button.center.x) / expectedItemWidth);
        if (feelingsPower == 0) {
            [button setTitleColor:self.unSelectedColor?self.unSelectedColor:[UIColor colorWithNumber:6]  forState:UIControlStateNormal];
#ifndef CH_DISABLE_BILI_FEELINGS_SCALE
            button.transform = CGAffineTransformIdentity;
#endif
        } else {
            UIColor *targetColor = [CHContainerTopBar mixedColorWithColor1:[self grayColor] color2:[self mainColor] alpha:feelingsPower];
            [button setTitleColor:targetColor forState:UIControlStateNormal];
#ifndef DISABLE_BILI_FEELINGS_SCALE
            CGFloat scale = 1 + CHFeelingsScale * feelingsPower;
            button.transform = CGAffineTransformMakeScale(scale, scale);
#endif
        }
    }
}

- (void)updateIndicatorWithProgress:(CGFloat)progress {
    CGRect frame = self.selectionIndicator.frame;
    frame.origin.x = self.scrollView.contentSize.width * progress;
    self.selectionIndicator.frame = frame;
}

- (void)selectAction:(UIButton *)button
{
    [self setSelectedIndex:button.tag animated:YES];
}

#pragma mark - Helper
+ (UIColor *)mixedColorWithColor1:(UIColor *)color1 color2:(UIColor *)color2 alpha:(CGFloat)alpha
{
    alpha = MIN(1, MAX(0, alpha));
    CGFloat beta = 1 - alpha;
    CGFloat r1, g1, b1, a1, r2, g2, b2, a2;
    [color1 getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [color2 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    CGFloat red = r1 * beta + r2 * alpha;
    CGFloat green = g1 * beta + g2 * alpha;
    CGFloat bule = b1 * beta + b2 * alpha;
    CGFloat ralpha = a1 * beta + a2 * alpha;
    return [UIColor colorWithRed:red green:green blue:bule alpha:ralpha];
}

@end

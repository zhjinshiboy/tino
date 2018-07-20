//
//  CHContainerTopBar.h
//  balance
//
//  Created by ZhangTino on 2018/7/20.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CH_DISABLE_BILI_FEELINGS_SCALE 1

extern const CGFloat CHFeelingsScale;

@protocol CHContainerTopBarDelegate <NSObject>

- (void)didChangeSelectIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;

@end

@interface CHContainerTopBar : UIView
{
    NSUInteger _selectedIndex;
}

// 设置后不会layoutSubviews，需要手动调用
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UIFont *titleFont;

// 当前选中的index
@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, weak) id<CHContainerTopBarDelegate> delegate;

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) UIView *selectionIndicator;
@property (nonatomic, readonly) UIView *bottomLine;
@property (nonatomic, readonly) NSArray *items;

@property (nonatomic, assign) CGFloat leftPadding;
@property (nonatomic, assign) CGFloat rightPadding;
@property (nonatomic, assign) CGFloat topPadding;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemPadding; // 仅在itemWidth无效时使用

@property (nonatomic, strong) UIColor *buttonColor;
@property (nonatomic, strong) UIColor *buttonUnColor;

@property (nonatomic , strong) UIColor *selectedColor;
@property (nonatomic , strong) UIColor *unSelectedColor;

@property (nonatomic, strong) NSMutableArray *itemButtons;

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;
- (void)updateIndicator:(CGFloat)progress;

- (UIColor *)mainColor;
- (UIColor *)grayColor;

+ (UIColor *)mixedColorWithColor1:(UIColor *)color1 color2:(UIColor *)color2 alpha:(CGFloat)alpha;

- (void)relpaceButtonWithButton:(UIButton *)button index:(NSInteger)index;

- (void)replaceTitleWithString:(NSString *)text index:(NSInteger)index;

- (void)setSelectionIndicatorColor:(UIColor *)color;

@end

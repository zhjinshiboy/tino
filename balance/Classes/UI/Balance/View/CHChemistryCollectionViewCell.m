//
//  CHChemistryCollectionViewCell.m
//  balance
//
//  Created by ZhangTino on 2018/5/20.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHChemistryCollectionViewCell.h"
#import "UIImage+CHColors.h"

@interface CHChemistryCollectionViewCell()
@property (nonatomic , strong) UIButton *btn;
@end

@implementation CHChemistryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView.layer setBorderWidth:1];
        [self.contentView.layer setBorderColor:[UIColor colorWithNumber:8].CGColor];
        [self.contentView addSubview:self.btn];
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setData:(CHClickableElement *)element {
    [self.btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithNumber:element.colorNumber]] forState:UIControlStateNormal];
    [self.btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithNumber:element.colorNumber]] forState:UIControlStateDisabled];
    [self.btn setTitle:element.title forState:UIControlStateNormal];
    if ([element.title isEqualToString:@"Balance"]) {
        [self.btn.titleLabel setFont:[UIFont fontWithNumber:2]];
    }else {
        [self.btn.titleLabel setFont:[UIFont fontWithNumber:0]];
    }
    @weakify(self);
    [[[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:[self rac_prepareForReuseSignal]] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if ([element.title isEqualToString:@"Shift"]) {
            [self.btn setSelected:!self.btn.selected];
            [[CHEquationManager defaultManager] setUnderShift:self.btn.selected];
        }
        [[CHEquationManager defaultManager] clickElement:element];
    }];
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithNumber:9]] forState:UIControlStateHighlighted];
        [_btn setTitleColor:[UIColor colorWithNumber:0] forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor colorWithNumber:6] forState:UIControlStateDisabled];
        [_btn setTitleColor:[UIColor colorWithNumber:1] forState:UIControlStateSelected];
        [_btn.titleLabel setFont:[UIFont fontWithNumber:0]];
    }
    return _btn;
}

@end

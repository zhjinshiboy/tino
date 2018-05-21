//
//  CHBalanceViewController.m
//  kfptb
//
//  Created by ZhangTino on 2018/5/16.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHBalanceViewController.h"
#import "CHBalanceViewModel.h"
#import "CHEquationInputView.h"

@interface CHBalanceViewController ()
@property (nonatomic , strong) CHBalanceViewModel *viewModel;
@property (nonatomic , strong) UILabel *consoleLabel;     //方程式控制台
@property (nonatomic , strong) CHEquationInputView *equInputView;       //方程式键盘
@end

@implementation CHBalanceViewController
@dynamic viewModel;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //install subviews
    [self.view addSubview:self.consoleLabel];
    [self.view addSubview:self.equInputView];
    
    [self.consoleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.view.mas_height).multipliedBy(1/3.5f);
        make.left.right.top.equalTo(self.view);
    }];
    [self.equInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.consoleLabel.mas_bottom);
        make.left.bottom.equalTo(self.view);
        make.right.equalTo(self.view.mas_right).offset(-30);
    }];
}

#pragma mark - synthesize
- (UILabel *)consoleLabel {
    if (!_consoleLabel) {
        _consoleLabel = [UILabel new];
        [_consoleLabel setBackgroundColor:[UIColor colorWithNumber:0]];
    }
    return _consoleLabel;
}

- (CHEquationInputView *)equInputView {
    if (!_equInputView) {
        _equInputView = [[CHEquationInputView alloc] initWithViewModel:self.viewModel.inputViewModel];
    }
    return _equInputView;
}

@end

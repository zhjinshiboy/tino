//
//  CHBalanceViewController.m
//  kfptb
//
//  Created by ZhangTino on 2018/5/16.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHBalanceViewController.h"
#import "CHEquationInputView.h"

@interface CHBalanceViewController ()
@property (nonatomic , strong) UILabel *consoleLabel;     //方程式控制台
@property (nonatomic , strong) CHEquationInputView *equInputView;       //方程式键盘
@end

@implementation CHBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //install subviews
    [self.view addSubview:self.consoleLabel];
}

#pragma mark - synthesize
- (UILabel *)consoleLabel {
    if (!_consoleLabel) {
        _consoleLabel = [UILabel new];
    }
    return _consoleLabel;
}

- (CHEquationInputView *)equInputView {
    if (!_equInputView) {
        _equInputView = [CHEquationInputView new];
    }
    return _equInputView;
}

@end

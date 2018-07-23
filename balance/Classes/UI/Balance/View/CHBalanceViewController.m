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
#import "AppDelegate.h"

@interface CHBalanceViewController ()
@property (nonatomic , strong) CHBalanceViewModel *viewModel;
@property (nonatomic , strong) UITextView *console;   //方程式控制台
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
    [self.view addSubview:self.console];
    [self.view addSubview:self.equInputView];

    [self.console mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.right.equalTo(self.view);
    }];
    [self.equInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.console.mas_bottom);
        make.height.equalTo(@(CHKeyboardHeight));
        make.left.right.bottom.equalTo(self.view);
    }];
    @weakify(self);
    [[RACObserve([CHEquationManager defaultManager], currentConsole) takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(NSString *console) {
        @strongify(self);
        [self.console setText:console];
    }];
    [self.console becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [[CHEquationManager defaultManager] setState:CHEquationStateClear];
}

#pragma mark - synthesize

- (UITextView *)console {
    if (!_console) {
        _console = [UITextView new];
        [_console setBackgroundColor:[UIColor colorWithNumber:4]];
        [_console setFont:[UIFont fontWithNumber:1]];
        _console.inputView = [[UIView alloc] initWithFrame:CGRectZero];
        _console.inputAccessoryView = [[UIView alloc] initWithFrame:CGRectZero];
        if (@available (iOS 9.0,*)) {
            UITextInputAssistantItem *item = [_console inputAssistantItem];
            item.leadingBarButtonGroups = @[];
            item.trailingBarButtonGroups = @[];
        }
    }
    return _console;
}

- (CHEquationInputView *)equInputView {
    if (!_equInputView) {
        _equInputView = [[CHEquationInputView alloc] initWithViewModel:self.viewModel.inputViewModel];
    }
    return _equInputView;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

@end

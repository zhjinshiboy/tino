//
//  CHHelpContainerViewController.m
//  balance
//
//  Created by ZhangTino on 2018/7/20.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHHelpContainerViewController.h"
#import "CHControllerContainerView.h"
#import "CHHelpViewController.h"
#import "UIImage+CHColors.h"

@interface CHHelpContainerViewController ()
@property (nonatomic , strong) CHControllerContainerView *pagesContainer;
@property (nonatomic , strong) UIButton *closeBtn;
@end

@implementation CHHelpContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.pagesContainer];
    [self.pagesContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.pagesContainer.topBar.leftPadding = 50;
    self.pagesContainer.topBar.topPadding = 20;
    self.pagesContainer.topBarHeight = 60;
//    self.pagesContainer.topBar.titleFont = [BFCFont fontWithSize:16];
//    [self.pagesContainer.topBar addSubview:[self createBackBtn:26+([UIDevice bfc_isIPhoneX]?24:0)]];
//    if ([UIDevice bfc_isIPhoneX]) {
//        self.pagesContainer.topBar.topPadding = 50;
//    }
//    self.pagesContainer.topBar.itemPadding = 80;
    
    CHHelpViewController *vc1 = [CHHelpViewController new];
    [vc1 setTitle:CHString(@"Software user guide")];
    [vc1 installFile:@"help1"];
    CHHelpViewController *vc2 = [CHHelpViewController new];
    [vc2 setTitle:CHString(@"高中阶段化学方程式大全")];
    [vc2 installFile:@"help2"];
    CHHelpViewController *vc3 = [CHHelpViewController new];
    [vc3 setTitle:CHString(@"化学方程式配平常用方法")];
    [vc3 installFile:@"help3"];
    
    NSMutableArray *vcArr = [NSMutableArray arrayWithObjects:vc1,vc2,vc3, nil];
    self.pagesContainer.contentControllers = vcArr;
    [self.pagesContainer.topBar setSelectedIndex:0];
    
//    UIButton *btn1 = [UIButton new];
//    [btn1 setFrame:CGRectMake(50, 0, 100, 40)];
//    [btn1 setTitle:CHString(@"Software user guide") forState:UIControlStateNormal];
//    [self.pagesContainer.topBar relpaceButtonWithButton:btn1 index:0];
    
    [self.pagesContainer.topBar addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@30);
        make.left.equalTo(self.pagesContainer.topBar.mas_left).offset(12);
        make.bottom.equalTo(self.pagesContainer.topBar.mas_bottom).offset(-5);
    }];
    @weakify(self);
    [[self.closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (CHControllerContainerView *)pagesContainer {
    if (!_pagesContainer) {
        _pagesContainer = [[CHControllerContainerView alloc] initWithController:self];
    }
    return _pagesContainer;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[[UIImage imageNamed:@"icon_close"] imageWithTintColor:[UIColor redColor]] forState:UIControlStateNormal];
    }
    return _closeBtn;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

@end

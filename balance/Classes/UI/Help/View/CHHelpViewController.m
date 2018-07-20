//
//  CHHelpViewController.m
//  balance
//
//  Created by ZhangTino on 2018/7/20.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHHelpViewController.h"

@interface CHHelpViewController ()
@property (nonatomic , strong) UIWebView *webView;
@end

@implementation CHHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)installFile:(NSString *)fileName {
    NSURL *filePath = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:fileName ofType:@"pdf"]];
    NSURLRequest *request = [NSURLRequest requestWithURL: filePath];
    [self.webView loadRequest:request];
    //使文档的显示范围适合UIWebView的bounds
    [self.webView setScalesPageToFit:YES];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [UIWebView new];
        [_webView setBackgroundColor:[UIColor colorWithNumber:4]];
    }
    return _webView;
}

@end

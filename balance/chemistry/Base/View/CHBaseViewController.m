//
//  CHBaseViewController.m
//  kfptb
//
//  Created by ZhangTino on 2018/5/16.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHBaseViewController.h"

@interface CHBaseViewController ()

@end

@implementation CHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
}

@end

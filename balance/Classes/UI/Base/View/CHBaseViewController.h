//
//  CHBaseViewController.h
//  kfptb
//
//  Created by ZhangTino on 2018/5/16.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHBaseViewModel.h"

@interface CHBaseViewController : UIViewController
@property (nonatomic , strong) CHBaseViewModel *viewModel;
- (instancetype)initWithViewModel:(CHBaseViewModel *)viewModel;
@end

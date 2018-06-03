//
//  CHBaseView.m
//  balance
//
//  Created by ZhangTino on 2018/5/21.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHBaseView.h"

@implementation CHBaseView

- (instancetype)initWithViewModel:(CHBaseViewModel *)viewModel
{
    self = [self init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

@end

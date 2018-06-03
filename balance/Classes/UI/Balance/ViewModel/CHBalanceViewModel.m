//
//  CHBalanceViewModel.m
//  balance
//
//  Created by ZhangTino on 2018/5/21.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHBalanceViewModel.h"

@interface CHBalanceViewModel()

@end

@implementation CHBalanceViewModel

- (CHEquationInputViewModel *)inputViewModel {
    if (!_inputViewModel) {
        _inputViewModel = [CHEquationInputViewModel new];
    }
    return _inputViewModel;
}

@end

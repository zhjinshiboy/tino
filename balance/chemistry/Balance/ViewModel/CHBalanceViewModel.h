//
//  CHBalanceViewModel.h
//  balance
//
//  Created by ZhangTino on 2018/5/21.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHBaseViewModel.h"
#import "CHEquationInputViewModel.h"

@interface CHBalanceViewModel : CHBaseViewModel
@property (nonatomic , strong) CHEquationInputViewModel *inputViewModel;
@end

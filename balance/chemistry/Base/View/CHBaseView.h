//
//  CHBaseView.h
//  balance
//
//  Created by ZhangTino on 2018/5/21.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHBaseViewModel;

@interface CHBaseView : UIView
@property (nonatomic , strong) CHBaseViewModel *viewModel;
- (instancetype)initWithViewModel:(CHBaseViewModel *)viewModel;
@end

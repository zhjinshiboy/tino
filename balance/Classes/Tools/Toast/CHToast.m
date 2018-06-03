//
//  CHToast.m
//  balance
//
//  Created by ZhangTino on 2018/5/30.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHToast.h"
#import "TopmostView.h"
#import <Toast.h>

@implementation CHToast

+ (void)showCenterToast:(NSString *)message
{
    NSAssert([NSThread isMainThread], @"toast has been called on main thread");
    [[TopmostView viewForApplicationWindow] makeToast:message duration:[CSToastManager defaultDuration] position:CSToastPositionCenter];
}

@end

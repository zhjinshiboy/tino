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
    if ([NSThread isMainThread]) {
        [[TopmostView viewForApplicationWindow] makeToast:@"Oh，the input is incorrect~" duration:[CSToastManager defaultDuration] position:CSToastPositionCenter];
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[TopmostView viewForApplicationWindow] makeToast:@"Oh，the input is incorrect~" duration:[CSToastManager defaultDuration] position:CSToastPositionCenter];
        });
    }
//    NSAssert([NSThread isMainThread], @"toast has been called on main thread");
}

+ (void)showLoading
{
    NSAssert([NSThread isMainThread], @"toast has been called on main thread");
    TopmostView *topmostView = [TopmostView viewForApplicationWindow];
    topmostView.userInteractionEnabled = YES;
    topmostView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [topmostView makeToastActivity:CSToastPositionCenter];
}

+ (void)hideLoading
{
    NSAssert([NSThread isMainThread], @"toast has been called on main thread");
    TopmostView *topmostView = [TopmostView viewForApplicationWindow];
    [topmostView hideToastActivity];
    topmostView.backgroundColor = [UIColor clearColor];
    topmostView.userInteractionEnabled = NO;
}

@end

//
//  CHToast.h
//  balance
//
//  Created by ZhangTino on 2018/5/30.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHToast : NSObject

+ (void)showCenterToast:(NSString *)message;
+ (void)showLoading;
+ (void)hideLoading;

@end

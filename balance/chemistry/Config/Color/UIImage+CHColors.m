//
//  UIImage+CHColors.m
//  balance
//
//  Created by ZhangTino on 2018/5/22.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "UIImage+CHColors.h"

@implementation UIImage (CHColors)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGSize size = CGSizeMake(1.f, 1.f);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

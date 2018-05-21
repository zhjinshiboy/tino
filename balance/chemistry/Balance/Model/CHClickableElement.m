//
//  CHClickableElement.m
//  balance
//
//  Created by ZhangTino on 2018/5/21.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHClickableElement.h"

@implementation CHClickableElement

- (instancetype)initWithTitle:(NSString *)title size:(CGSize)size type:(CHClickableElementType)type colorNumber:(NSInteger)colorNumber
{
    self = [super init];
    if (self) {
        self.size = size;
        self.title = title;
        self.type = type;
        self.colorNumber = colorNumber;
    }
    return self;
}

@end

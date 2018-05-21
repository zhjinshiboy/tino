//
//  CHChemistryCollectionViewCellItem.m
//  balance
//
//  Created by ZhangTino on 2018/5/21.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHChemistryCollectionViewCellItem.h"

@interface CHChemistryCollectionViewCellItem()
@property (nonatomic , strong) CHClickableElement *model;
@end

@implementation CHChemistryCollectionViewCellItem

- (instancetype)initWithModel:(CHClickableElement *)model;
{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (NSString *)getDisplayString {
    return self.model.title;
}

- (CGSize)getContentSize {
    return self.model.size;
}

@end

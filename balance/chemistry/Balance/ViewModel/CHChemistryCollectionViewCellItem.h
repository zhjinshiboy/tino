//
//  CHChemistryCollectionViewCellItem.h
//  balance
//
//  Created by ZhangTino on 2018/5/21.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHBaseViewModel.h"
#import "CHClickableElement.h"

@interface CHChemistryCollectionViewCellItem : CHBaseViewModel
- (instancetype)initWithModel:(CHClickableElement *)model;
- (NSString *)getDisplayString;
- (CGSize)getContentSize;
@end

//
//  CHChemistryCollectionViewCell.m
//  balance
//
//  Created by ZhangTino on 2018/5/20.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHChemistryCollectionViewCell.h"
#import "CHChemistryCollectionViewCellItem.h"

@interface CHChemistryCollectionViewCell()
@property (nonatomic , strong) CHChemistryCollectionViewCellItem *cellItem;
@property (nonatomic , strong) UILabel *chemistryLabel;
@end

@implementation CHChemistryCollectionViewCell
@synthesize cellItem = _cellItem;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor blueColor]];
        [self.contentView addSubview:self.chemistryLabel];
        [self.chemistryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

- (UILabel *)chemistryLabel {
    if (!_chemistryLabel) {
        _chemistryLabel = [UILabel new];
    }
    return _chemistryLabel;
}

- (void)setCellItem:(CHChemistryCollectionViewCellItem *)cellItem {
    _cellItem = cellItem;
    [self.chemistryLabel setText:[self.cellItem getDisplayString]];
}

@end

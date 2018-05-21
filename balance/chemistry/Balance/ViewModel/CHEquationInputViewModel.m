//
//  CHEquationInputViewModel.m
//  balance
//
//  Created by ZhangTino on 2018/5/21.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHEquationInputViewModel.h"
#import "CHChemistryCollectionViewCell.h"
#import "CHClickableElement.h"
#import "CHChemistryCollectionViewCellItem.h"

@implementation CHEquationInputViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDataArr:[self inputBtnObjs]];
    }
    return self;
}

- (RACSubject *)clickSignal {
    if (!_clickSignal) {
        _clickSignal = [RACSubject subject];
    }
    return _clickSignal;
}

- (CGSize)getCellSizeAtIndexPath:(NSIndexPath *)indexPath {
    CHChemistryCollectionViewCellItem *cellItem = self.dataArr[indexPath.row];
    return [cellItem getContentSize];
}

#pragma mark - uicollectionview datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CHChemistryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CHEquationCollectioCellIdentifier forIndexPath:indexPath];
//    [cell setData:self.dataArr[indexPath.row]];
    [cell setCellItem:self.dataArr[indexPath.row]];
    return cell;
}

#pragma mark - install data
- (NSArray *)inputBtnObjs {
    CHClickableElement *ele1 = [CHClickableElement new];
    ele1.title = CHString(@"1");
    [ele1 setSize:CGSizeMake(620, 80)];
    CHClickableElement *ele2 = [CHClickableElement new];
    ele2.title = CHString(@"2");
    [ele1 setSize:CGSizeMake(80, 100)];
    CHClickableElement *ele3 = [CHClickableElement new];
    ele3.title = CHString(@"3");
    [ele3 setSize:CGSizeMake(620, 50)];
    CHClickableElement *ele4 = [CHClickableElement new];
    ele4.title = CHString(@"4");
//    forin
    NSArray *arr = @[ele1,ele2,ele3,ele4];
    NSMutableArray *result = [NSMutableArray array];
    for (CHClickableElement *ele in arr) {
        CHChemistryCollectionViewCellItem *cellItem = [[CHChemistryCollectionViewCellItem alloc] initWithModel:ele];
        [result addObject:cellItem];
    }
    return result;
}


@end

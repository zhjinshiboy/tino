//
//  CHCollectionViewFlowLayout.m
//  balance
//
//  Created by ZhangTino on 2018/5/20.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHCollectionViewFlowLayout.h"
#import "CHChemistryCollectionViewCellItem.h"

@interface CHCollectionViewFlowLayout()
@property (nonatomic , weak) id<CHCollectionViewDelegate> delegate;
@property (nonatomic , strong) NSMutableArray *attributesArray;
@end

@implementation CHCollectionViewFlowLayout {
    CGFloat _currentX;
    CGFloat _currentY;
}

- (instancetype)initWithDelegate:(id<CHCollectionViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        _currentX = [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout sectionInset].left;
        _currentY = [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout sectionInset].top;
    }
    return self;
}

//- (void)prepareLayout {
//    [super prepareLayout];
//    [self.attributesArray removeAllObjects];
//    for (NSInteger i = 0; i < self.delegate.dataArr.count; i ++) {
//        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
//        [self.attributesArray addObject:attributes];
//    }
//}
//
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    return self.attributesArray;
//}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
////    UICollectionViewLayoutAttributes *temp = [super layoutAttributesForItemAtIndexPath:indexPath];
//    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    CHChemistryCollectionViewCellItem *cellItem = self.delegate.dataArr[indexPath.row];
//    CGSize currentSize = [cellItem getContentSize];
//    if (_currentX) {
//        <#statements#>
//    }
//    return attributes;
//}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
////    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    UICollectionViewLayoutAttributes *currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
////    attributes.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//    UIEdgeInsets sectionInset = [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout sectionInset];
//
//    if (indexPath.item == 0) { // first item of section
//        CGRect frame = currentItemAttributes.frame;
//        frame.origin.x = sectionInset.left; // first item of the section should always be left aligned
//        currentItemAttributes.frame = CGRectMake(0, 0, 100, 100);
//
//        return currentItemAttributes;
//    }
//
////    UICollectionViewLayoutAttributes *previousAttributes = self.attributesArray[indexPath.row - 1]
//    NSIndexPath* previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
//    CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
//    CGFloat previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width;
//
//    CGRect currentFrame = currentItemAttributes.frame;
//    CGRect strecthedCurrentFrame = CGRectMake(0,
//                                              currentFrame.origin.y,
//                                              self.collectionView.frame.size.width,
//                                              currentFrame.size.height);
//
//    if (!CGRectIntersectsRect(previousFrame, strecthedCurrentFrame)) {
//        //不重叠
//        CGRect frame = currentItemAttributes.frame;
//        frame.origin.x = sectionInset.left;
//        currentItemAttributes.frame = frame;
//        return currentItemAttributes;
//
//    }
//    //重叠
//    CGRect frame = currentItemAttributes.frame;
//    frame.origin.x = previousFrameRightPoint;
//    currentItemAttributes.frame = frame;
//    return currentItemAttributes;
//    return attributes;
//}

#pragma mark- 懒加载

- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

@end

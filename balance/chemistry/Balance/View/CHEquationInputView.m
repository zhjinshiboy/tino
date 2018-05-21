//
//  CHEquationInputView.m
//  kfptb
//
//  Created by ZhangTino on 2018/5/16.
//  Copyright © 2018年 ZhangTino. All rights reserved.
//

#import "CHEquationInputView.h"
#import "CHEquationInputViewModel.h"
#import "CHCollectionViewFlowLayout.h"
#import "CHChemistryCollectionViewCell.h"

@interface CHEquationInputView()<UICollectionViewDelegate>
@property (nonatomic , strong) CHEquationInputViewModel *viewModel;
@property (nonatomic , strong) UICollectionView *collectionView;
@end

@implementation CHEquationInputView
@dynamic viewModel;

- (instancetype)initWithViewModel:(CHBaseViewModel *)viewModel {
    self = [super initWithViewModel:viewModel];
    if (self) {
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setMinimumInteritemSpacing:0];
        [layout setMinimumLineSpacing:0];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self.viewModel;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView setScrollEnabled:NO];
        [_collectionView registerClass:[CHChemistryCollectionViewCell class] forCellWithReuseIdentifier:CHEquationCollectioCellIdentifier];
        [_collectionView setBackgroundColor:[UIColor yellowColor]];
    }
    return _collectionView;
}

#pragma mark - collectionView delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.viewModel getCellSizeAtIndexPath:indexPath];
}

//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 8;
//}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
//{
//    return UIEdgeInsetsMake(0,0,11,0);
//}

@end

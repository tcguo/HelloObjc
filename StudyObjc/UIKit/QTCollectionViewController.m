//
//  QTCollectionViewController.m
//  StudyObjc
//
//  Created by gtc on 2020/9/9.
//  Copyright © 2020 gtc. All rights reserved.
//

#import "QTCollectionViewController.h"
#import "YTMakeupItemCell.h"
#import "YTExpandableCollectionView.h"

@interface QTCollectionViewController()<YTExpandableCollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) YTExpandableCollectionView *collectView;
@property (nonatomic, strong) NSMutableArray *isExpandArray;
@end

@implementation QTCollectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url = @"https://www.baidu.com/aa/bb?&a=12&b=22";
    NSURL *nsurl = [NSURL URLWithString:url];
    NSLog(@"host== %@", nsurl.host);
    NSLog(@"schme == %@", nsurl.scheme);
    NSLog(@"path = %@", nsurl.path);
    NSLog(@"query = %@", nsurl.query);
    
    
    self.isExpandArray = [NSMutableArray array];
    [self.isExpandArray addObjectsFromArray:@[@"0", @"0", @"0"]];
    
    [self.view addSubview:self.collectView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 7;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section < 2) {
        return 1;
    }
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YTMakeupItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YTMakeupItemCell" forIndexPath:indexPath];
    if (indexPath.section == 0 || indexPath.section == 3 || indexPath.section == 6) {
        cell.iconView.layer.borderColor = [UIColor redColor].CGColor;
    }
    if (indexPath.section == 1 || indexPath.section == 4) {
        cell.iconView.layer.borderColor = [UIColor yellowColor].CGColor;
    }
    if (indexPath.section == 2 || indexPath.section == 5 ) {
        cell.iconView.layer.borderColor = [UIColor greenColor].CGColor;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
}

- (void)collectionView:(UICollectionView *)collectionView didCollapseItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
}

- (void)collectionView:(UICollectionView *)collectionView didExpandItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 40;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}


/*
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView11" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        reusableview.backgroundColor = [UIColor redColor];
    } else if (indexPath.section == 1) {
        reusableview.backgroundColor = [UIColor greenColor];
    } else {
        reusableview.backgroundColor = [UIColor clearColor];
    }
    if ([_isExpandArray[indexPath.section] isEqualToString:@"0"]) {
        //未展开
//        headerView.selectImageView.image = [UIImage imageNamed:@"off"];
    }else{
        //展开
//        headerView.selectImageView.image = [UIImage imageNamed:@"open"];
    }
//    headerView.label.text = @"聚合";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//    tap.delegate = self;
    reusableview.tag = indexPath.section;
    [reusableview addGestureRecognizer:tap];
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return CGSizeMake(12.f,  70.f);
    } else {
        return CGSizeMake(48, 70.f);
    }
}

*/

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if ([_isExpandArray[tap.view.tag] isEqualToString:@"0"]) {
        //关闭 => 展开
        [_isExpandArray removeObjectAtIndex:tap.view.tag];
        [_isExpandArray insertObject:@"1" atIndex:tap.view.tag];
    }else{
        //展开 => 关闭
        [_isExpandArray removeObjectAtIndex:tap.view.tag];
        [_isExpandArray insertObject:@"0" atIndex:tap.view.tag];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:tap.view.tag];
    NSRange rang = NSMakeRange(indexPath.section, 1);
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:rang];
//    [UIView animateWithDuration:0.f delay:0.f options:UIViewAnimationOptionCurveLinear animations:^{
//        [self.collectView performBatchUpdates:^{
//            [self.collectView reloadSections:set];
//        } completion:nil];
//    } completion:nil];
    

//    [UIView transitionWithView:self.collectView duration:0.75f options:UIViewAnimationOptionTransitionNone animations:^(void) {
//            [self.collectView reloadSections:set];
//    } completion:nil];
    
//    [UIView animateWithDuration:0.45 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.collectView reloadSections:set];
//    } completion:nil];
}


- (UICollectionView *)collectView {
    if (!_collectView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumLineSpacing = 12.f;
        layout.minimumInteritemSpacing = 12.f;
        layout.itemSize = CGSizeMake(48, 70);
        CGFloat sectionInsetX =  12.;
        CGFloat sectionInsetTop = 12.;
        layout.sectionInset = UIEdgeInsetsMake(sectionInsetTop, sectionInsetX, 0., 0.f);
//        layout.headerReferenceSize = CGSizeMake(48, 70.f);
        
        _collectView = [[YTExpandableCollectionView alloc] initWithFrame:CGRectMake(15, 150, self.view.bounds.size.width - 30, 100) collectionViewLayout:layout];
        _collectView.bounces = YES;
        _collectView.backgroundColor = [UIColor grayColor];
        [_collectView registerClass:[YTMakeupItemCell class] forCellWithReuseIdentifier:@"YTMakeupItemCell"];
        [_collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView11"];
        _collectView.dataSource = self;
        _collectView.delegate = self;
        _collectView.showsVerticalScrollIndicator = NO;
        _collectView.showsHorizontalScrollIndicator = NO;
        _collectView.allowsMultipleExpandedSections = NO;
    }
    return _collectView;
}

@end

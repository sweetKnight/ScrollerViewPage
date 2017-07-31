//
//  ViewController.m
//  CollenViewPageChange
//
//  Created by 冯剑锋 on 2017/7/31.
//  Copyright © 2017年 冯剑锋. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, assign) CGFloat offer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.view.bounds.size.width - 40, self.view.bounds.size.height);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.decelerationRate = 10;//我改的是10
    [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MyCollectionViewCell class])];
    [self.view addSubview:_collectionView];
    
    _dataArray = @[[UIColor redColor], [UIColor yellowColor], [UIColor blueColor], [UIColor greenColor], [UIColor blackColor]];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyCollectionViewCell class]) forIndexPath:indexPath];
    cell.contensColor = _dataArray[indexPath.row];
    cell.backgroundColor = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

//系统动画停止是刷新当前偏移量_offer是我定义的全局变量

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    _offer = scrollView.contentOffset.x;
    NSLog(@"end========%f",_offer);
    
}

//滑动减速是触发的代理，当用户用力滑动或者清扫时触发

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (fabs(scrollView.contentOffset.x -_offer) > 10) {
        [self scrollToNextPage:scrollView];
    }
}

//用户拖拽是调用

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (fabs(scrollView.contentOffset.x -_offer) > 20) {
        [self scrollToNextPage:scrollView];
    }
}

-(void)scrollToNextPage:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > _offer) {
        int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - 30)+1;
        if (i >= _dataArray.count) {
            return;
        }
        NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
        [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }else{
        int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - 30)+1;
        if (i < 1) {
            return;
        }
        NSIndexPath * index =  [NSIndexPath indexPathForRow:i-1 inSection:0];
        [_collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}


@end

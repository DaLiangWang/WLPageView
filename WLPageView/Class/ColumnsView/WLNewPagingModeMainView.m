//
//  WLNewPagingModeMainView.m
//  SeaWorld
//
//  Created by 王亮 on 2017/11/22.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "WLNewPagingModeMainView.h"
#import "WLNewColumnsView.h"
#import "WL_Macros.h"
#import "WLNewPagingModeModel.h"
#import "WLNewPagingModeMainCollectionViewCell.h"

@interface WLNewPagingModeMainView ()<UICollectionViewDelegate,UICollectionViewDataSource,WLNewColumnsViewWLDelegate>{
    
}
@property(nonatomic,strong) WLNewColumnsView *newColumnsView;
@property(nonatomic,strong) UIView *lineView;

@end
@implementation WLNewPagingModeMainView
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
    }
    return _lineView;
}

-(WLNewColumnsView *)newColumnsView{
    if (!_newColumnsView) {
        _newColumnsView = [[WLNewColumnsView alloc]init];
        _newColumnsView.WLDelegate = self;
    }
    return _newColumnsView;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *Layout = [UICollectionViewFlowLayout new];
        [Layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        //        Layout.headerReferenceSize=CGSizeMake(self.width, 40); //设置collectionView头视图的大小
        //        Layout.footerReferenceSize=CGSizeMake(self.width, 0); //设置collectionView头视图的大小
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:Layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.pagingEnabled = YES;
        
        _collectionView.tag = 999;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _collectionView.showsHorizontalScrollIndicator = NO;

    }
    return _collectionView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView{
    
    self.clipsToBounds = YES;
    
    self.backgroundColor = HexColor(0xF2F5FA);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.collectionView];
    [self addSubview:self.newColumnsView];
    
    
    [self.newColumnsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_offset(44);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.newColumnsView.mas_bottom);
    }];
    
    [self addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.newColumnsView.mas_bottom);
        make.height.mas_offset(0.5f);
    }];
    
    
}
-(void)setModel:(WLNewPagingModeModel *)model{
    _model = model;
    //告诉约束需要更新,但是不会立即更新
    [self setNeedsUpdateConstraints];
    //检测当前试图以及姿势图是否需要更新约
    [self updateConstraintsIfNeeded];
    [self.newColumnsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(_model.properties.topHight);
    }];
    ////立即更新约束
    [self layoutIfNeeded];
    
    [self.collectionView reloadData];
    
    
    self.newColumnsView.model = _model;
    self.lineView.backgroundColor = _model.properties.lineColor;
}

#pragma mark - scrollView 的代理
// 滚动就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.newColumnsView col_scrollViewDidScroll:scrollView];
}
// 开始拖拽时触发
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.newColumnsView col_scrollViewWillBeginDragging:scrollView];
}
// 结束拖拽时触发
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView  willDecelerate:(BOOL)decelerate{
    [self.newColumnsView col_scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}
// 开始减速时触发
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.newColumnsView col_scrollViewWillBeginDecelerating:scrollView];
}
// 结束减速时触发（停止）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.newColumnsView col_scrollViewDidEndDecelerating:scrollView];
}

/**
 点击标签
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath mdoel:(WLNewPagingModeView *)model{
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}
/**
 位置归零
 */
- (void)positionZeroingIndexPath:(NSIndexPath *)indexPath mdoel:(WLNewPagingModeView *)model{
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}


#pragma mark -CollectionView代理-
//返回4个section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//每个section的数量由数据源的count值确定
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_model.views count];
}
//创建 cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WLNewPagingModeView *data = _model.views[indexPath.row];
    NSString *cellId = cellId_WL;
    if (data.unique) {
        cellId = data.unique;
    }
    NSLog(@"缓存标示--------%@-----------",cellId);
    [collectionView registerClass:[WLNewPagingModeMainCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    
    WLNewPagingModeMainCollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell.topic) {
        cell.topic = data;
    }
    return cell;
}

//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.wl_width, self.collectionView.wl_height);
}
//section的边距(上，左，下，右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//section内，cell的间距 纵向
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//section内，cell的间距 横向
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//点击cell的响应
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)executionSanView{
    if ([self.collectionView visibleCells].count == 1) {
        WLNewPagingModeMainCollectionViewCell *view = (WLNewPagingModeMainCollectionViewCell *)[[self.collectionView visibleCells] firstObject];
        [view executionSanView];
    }
}
@end

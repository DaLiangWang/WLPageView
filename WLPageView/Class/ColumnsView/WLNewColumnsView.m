//
//  WLNewColumnsView.m
//  SeaWorld
//
//  Created by 王亮 on 2017/11/22.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "WLNewColumnsView.h"
#import "WLNewColumnsViewCollectionViewCell.h"
#import "WLNewColumusMoreItemView.h"
#import "WL_Macros.h"
@interface WLNewColumnsView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>{
    UIView *_lineView;
    
}
@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) UIButton *moreButton;

//@property(nonatomic,strong) WLNewColumusMoreItemView *newColumusMoreItemView;
@end
@implementation WLNewColumnsView

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *Layout = [UICollectionViewFlowLayout new];
        [Layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:Layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        _collectionView.tag = 999;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

-(UIButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [[UIButton alloc]init];
        [_moreButton setImage:[UIImage imageNamed:@"public_button"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"public_top"] forState:UIControlStateSelected];
        
//        _moreButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _moreButton.backgroundColor = [UIColor whiteColor];
        _moreButton.hidden = YES;
        [_moreButton addTarget:self action:@selector(click_more_button:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *liftLine = [[UIView alloc]init];
        liftLine.backgroundColor = HexColor(0xDDDDDD);
        [self.moreButton addSubview:liftLine];
        [liftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.moreButton);
            make.top.mas_equalTo(self.moreButton).mas_offset(8);
            make.bottom.mas_equalTo(self.moreButton).mas_offset(-8);
            make.width.mas_offset(0.5f);
        }];
    }
    return _moreButton;
}
-(void)click_more_button:(UIButton *)sender{
    if ([self.WLDelegate respondsToSelector:@selector(clickMoreButtonMdoel:moreButton:)]) {
        [self.WLDelegate clickMoreButtonMdoel:_model moreButton:sender];
    }
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.collectionView.clipsToBounds = NO;
        
        self.backgroundColor = HexColor(0xFFFFFF);
        
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        [self addSubview:self.moreButton];
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(self);
            make.width.mas_equalTo(self.moreButton.mas_height);
        }];
        
//        页面整体分界线
        _lineView = [[UIView alloc]init];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self);
            make.height.mas_offset(0.5f);
        }];

    }
    return self;
}

-(void)setModel:(WLNewPagingModeModel *)model{
    _model = model;
//    是否打开更多按钮  先判断是否开启更多的按钮。在判断item是否大于5 如果大于五则开启
    self.moreButton.hidden = _model.isShowMoreButton?((_model.views.count>5)?NO:YES):YES;
//    分界线颜色
    _lineView.backgroundColor = model.properties.buttonLineColor;
//    分界线位置
    
    if (!UIEdgeInsetsEqualToEdgeInsets(_model.properties.lineViewEdge, UIEdgeInsetsZero)) {
        [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(_model.properties.lineViewEdge.left);
            make.right.mas_equalTo(self).mas_offset(-_model.properties.lineViewEdge.right);
        }];
    }
//    判断绘制后是否选择默认
    if (model.properties.isZero) {
        [self positionZeroing:_model.seleteNum];
    }
    else{
        [self.collectionView reloadData];
        [self.collectionView layoutIfNeeded];
    }
}
-(void)setSeleteItem:(NSInteger)seleteItem{
    _seleteItem = seleteItem;
    [self positionZeroing:_seleteItem];
}
-(void)positionZeroing:(NSInteger)num{
    if ([self.WLDelegate respondsToSelector:@selector(positionZeroingIndexPath:mdoel:)]) {
        [self.WLDelegate positionZeroingIndexPath:[NSIndexPath indexPathForRow:num inSection:0]
                                            mdoel:[_model.views objectAtIndex:num]];
    }
    [self change_page_view:num];
}
// 滚动就会触发
- (void)col_scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
// 开始拖拽时触发
- (void)col_scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}
// 结束拖拽时触发
- (void)col_scrollViewDidEndDragging:(UIScrollView *)scrollView  willDecelerate:(BOOL)decelerate{
    
}
// 开始减速时触发
- (void)col_scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}
// 结束减速时触发（停止）
- (void)col_scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //滑动时当前第几页
    NSInteger pageNum = scrollView.contentOffset.x/scrollView.wl_width;
    [self change_page_view:pageNum];
}
-(void)change_page_view:(NSInteger)pageNum{
    if (!_model) {
        [self.collectionView reloadData];
        [self.collectionView layoutIfNeeded];
        return;
    }
    for (WLNewPagingModeView *cell in _model.views) {
        cell.isSelete = NO;
    }
    _model.views[pageNum].isSelete = YES;
    
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];

    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:pageNum inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}


#pragma mark - scrollView 的代理
// 滚动就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

}
// 开始拖拽时触发
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

}
// 结束拖拽时触发
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView  willDecelerate:(BOOL)decelerate{

}
// 开始减速时触发
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{

}
// 结束减速时触发（停止）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

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
    
    [collectionView registerNib:[UINib nibWithNibName:@"WLNewColumnsViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellId_WL];
    
    WLNewColumnsViewCollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId_WL forIndexPath:indexPath];
    
    cell.topic = _model.views[indexPath.row];
    
    return cell;
}

//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_model.isSharingTitle) {
        return CGSizeMake(self.wl_width/_model.views.count, self.wl_height);
    }
    else{
        NSString * string = _model.views[indexPath.row].title;
        CGRect rect = [string boundingRectWithSize:CGSizeMake(Main_Screen_Width_WL - 20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        return CGSizeMake(rect.size.width + 15, self.wl_height);
    }
}
//section的边距(上，左，下，右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (!self.moreButton.hidden) {
        return UIEdgeInsetsMake(0, _model.properties.lineViewEdge.left, 0, self.frame.size.height);
    }
    return UIEdgeInsetsMake(0, _model.properties.lineViewEdge.left, 0, _model.properties.lineViewEdge.right);
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
    
    for (WLNewPagingModeView *cell in _model.views) {
        cell.isSelete = NO;
    }
    _model.views[indexPath.row].isSelete = YES;
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];

    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    
    if ([self.WLDelegate respondsToSelector:@selector(didSelectItemAtIndexPath:mdoel:)]) {
        [self.WLDelegate didSelectItemAtIndexPath:indexPath mdoel:_model.views[indexPath.row]];
    }
    
}

@end

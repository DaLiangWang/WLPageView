//
//  WLNewColumnsView.h
//  SeaWorld
//
//  Created by 王亮 on 2017/11/22.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLNewPagingModeModel.h"
@protocol WLNewColumnsViewWLDelegate <NSObject>

@optional


/**
 点击标签
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath mdoel:(WLNewPagingModeView *)model;

/**
 位置归零
 */
- (void)positionZeroingIndexPath:(NSIndexPath *)indexPath mdoel:(WLNewPagingModeView *)model;


/**
 点击更多
 */
- (void)clickMoreButtonMdoel:(WLNewPagingModeModel *)model moreButton:(UIButton *)sender;

@end

@interface WLNewColumnsView : UIView
@property(nonatomic,weak) id<WLNewColumnsViewWLDelegate> WLDelegate;


@property(nonatomic,strong) WLNewPagingModeModel *model;

@property(nonatomic,assign) NSInteger seleteItem;

// 滚动就会触发
- (void)col_scrollViewDidScroll:(UIScrollView *)scrollView;
// 开始拖拽时触发
- (void)col_scrollViewWillBeginDragging:(UIScrollView *)scrollView;
// 结束拖拽时触发
- (void)col_scrollViewDidEndDragging:(UIScrollView *)scrollView  willDecelerate:(BOOL)decelerate;
// 开始减速时触发
- (void)col_scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
// 结束减速时触发（停止）
- (void)col_scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end

//
//  WLNewColumusMoreItemView.h
//  SeaWorld
//
//  Created by 王亮 on 2017/12/12.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLNewPagingModeModel.h"
@class WLNewColumusMoreItemView;

typedef void(^changeViewSize)(WLNewColumusMoreItemView *view,CGFloat viewHeight);
typedef void(^clickItemButton)(WLNewColumusMoreItemView *view,WLNewPagingModeView *viewModel,NSInteger seleteItem);
typedef void(^clossViewBlock)(WLNewColumusMoreItemView *view);

@interface WLNewColumusMoreItemView : UIView
@property(nonatomic,copy) changeViewSize changeViewSize;
@property(nonatomic,copy) clickItemButton clickItemButton;
@property(nonatomic,copy) clossViewBlock clossViewBlock;


/**
 弹出二级类目选择框

 @param constraintView 相对约束的视图
 @param addView 需要添加到的父视图
 @param itemModel 按钮模型
 @param seleteItemModel 选中的按钮模型
 @param clickItemButton 点击回掉
 @return self
 */
+(instancetype)showConstraintView:(UIView *)constraintView
                          addView:(UIView *)addView
                        itemModel:(WLNewPagingModeModel *)itemModel
                  seleteItemModel:(WLNewPagingModeView *)seleteItemModel
                  clickItemButton:(clickItemButton)clickItemButton
                   clossViewBlock:(clossViewBlock)clossViewBlock;



-(void)clossView;



-(void)setViewItemModel:(WLNewPagingModeModel *)itemModel
        seleteItemModel:(WLNewPagingModeView *)seleteItemModel
         changeViewSize:(changeViewSize)changeViewSize
        clickItemButton:(clickItemButton)clickItemButton
clossViewBlock:(clossViewBlock)clossViewBlock;
@end

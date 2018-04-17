//
//  WLNewPagingModeMainView.h
//  SeaWorld
//
//  Created by 王亮 on 2017/11/22.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLNewPagingModeModel;
@interface WLNewPagingModeMainView : UIView
@property(nonatomic,strong) WLNewPagingModeModel *model;
@property(nonatomic,strong) UICollectionView *collectionView;


-(void)executionSanView;

@end

//
//  WLNewPagingModeMainCollectionViewCell.m
//  SeaWorld
//
//  Created by 王亮 on 2017/11/22.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "WLNewPagingModeMainCollectionViewCell.h"
#import "WLNewBaseView.h"
#import "WL_Macros.h"

@implementation WLNewPagingModeMainCollectionViewCell{
    id _viewSan;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setTopic:(WLNewPagingModeView *)topic{
    _topic = topic;
    if (!_viewSan) {
        _viewSan = (WLNewBaseView *)[[NSClassFromString(_topic.viewClassName) alloc]initPar:_topic];
        [self addSubview:_viewSan];
        [_viewSan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(self);
        }];
    }
}
-(void)executionSanView{
    if ([_viewSan respondsToSelector:@selector(executionSanView)]) {
        [_viewSan executionSanView];
    }
}
@end

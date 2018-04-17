//
//  WLShowView.m
//  WLPageView
//
//  Created by 王亮 on 2018/4/17.
//  Copyright © 2018年 王亮. All rights reserved.
//

#import "WLShowView.h"

@implementation WLShowView

-(instancetype)initPar:(WLNewPagingModeView *)par
{
    self = [super init];
    if (self) {
        NSLog(@"%@",par);
    }
    return self;
}

@end

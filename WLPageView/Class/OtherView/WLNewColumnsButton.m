//
//  WLNewColumnsButton.m
//  SeaWorld
//
//  Created by 王亮 on 2017/12/12.
//  Copyright © 2017年 Rice. All rights reserved.
//

#import "WLNewColumnsButton.h"

@implementation WLNewColumnsButton
-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.imageView.image) {
        CGFloat maxW = self.frame.size.width;
        CGFloat maxH = self.frame.size.height;
        
        CGFloat midX = maxW / 2;
        CGFloat midY = maxH / 2;
        
        self.titleLabel.center = CGPointMake( midX - (self.imageView.frame.size.width/2), midY );
        self.imageView.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + (self.imageView.frame.size.width/2), midY);
    }
}
@end

//
//  TranstionView.h
//  TranstionFromView
//
//  Created by 赚发2 on 16/7/14.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TranstionView : UIView


/**
 *  实例方法
 *
 *  @param frame           frame
 *  @param containerView   容器 view(VC)
 *  @param showImageView   显示的 imageView
 *  @param imageSuperView  显示 imageView 的父视图
 *  @param showImage      显示的 image
 *
 *  @return TranstionView
 */
- (instancetype)initWithFrame:(CGRect)frame
                containerView:(UIView *)containerView
                showImageView:(UIImageView *)showImageView
               imageSuperView:(UIView *)imageSuperView
                    showImage:(UIImage *)showImage;


@end

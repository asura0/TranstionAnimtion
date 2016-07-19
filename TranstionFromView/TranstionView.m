//
//  TranstionView.m
//  TranstionFromView
//
//  Created by 赚发2 on 16/7/14.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import "TranstionView.h"

@interface TranstionView ()

/** 容器 View */
@property (nonatomic, strong) UIView *containerView;
/** 显示的 imageView */
@property (nonatomic, strong) UIImageView *showImageView;
/** imageView 的父视图 */
@property (nonatomic, strong) UIView *imageSuperView;
 /** image */
@property (nonatomic, strong) UIImage *showImage;
/** 容器里的 imageView */
@property (nonatomic, strong) UIImageView *containerImageView;
/** 截屏的 view */
@property (nonatomic, strong) UIView *snapshotView;
/** 视图本身显示imageView */
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TranstionView

- (instancetype)initWithFrame:(CGRect)frame
                containerView:(UIView *)containerView
                showImageView:(UIImageView *)showImageView
               imageSuperView:(UIView *)imageSuperView
                    showImage:(UIImage *)showImage{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _containerView = containerView;
        _showImageView = showImageView;
        _imageSuperView = imageSuperView;
        _showImage = showImage;
        [self confguireSubViews];
        [self transtionAnimation];
    }
    return self;
}

- (void)confguireSubViews{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 160)];
    _imageView.center = self.center;
    _imageView.image = _showImage;
    _imageView.alpha = 0;
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:_imageView];
    self.alpha = 0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissView:)];
    [self addGestureRecognizer:tap];
}

- (void)transtionAnimation{
    
    //截 VC 的 view
    _snapshotView = [_containerView snapshotViewAfterScreenUpdates:NO];
    UIImageView *snapshotImageView = [[UIImageView alloc] initWithFrame:_snapshotView.frame];
    //截图片
    snapshotImageView.image = [self getImage];
    [_snapshotView addSubview:snapshotImageView];
    [_containerView addSubview:_snapshotView];
    
    _containerImageView = [[UIImageView alloc] init];
    
    _containerImageView.frame = [_imageSuperView convertRect:_showImageView.bounds toView:_snapshotView];
    _containerImageView.image = _showImage;
    _imageView.frame = _containerImageView.frame;
    
    [_snapshotView addSubview:_containerImageView];
    
    [UIView animateWithDuration:0.5 animations:^{
        _containerImageView.frame = CGRectMake(0, self.center.y - 80, self.frame.size.width, 160);
        _imageView.frame = CGRectMake(0, self.center.y - 80, self.frame.size.width, 160);

        self.alpha = 1;
        _imageView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dissmissView:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.5 animations:^{
        _containerImageView.frame = [_imageSuperView convertRect:_showImageView.bounds toView:_snapshotView];
        _imageView.frame = [_imageSuperView convertRect:_showImageView.bounds toView:_snapshotView];
        self.alpha = 0;
        _imageView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [_snapshotView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (UIImage *)getImage {
    //NO，YES 控制是否透明
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.frame.size.width, self.frame.size.height), NO, 1.0);
    [_containerView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 生成后的image
    
    return image;
}
- (void)dealloc{
    
}
@end

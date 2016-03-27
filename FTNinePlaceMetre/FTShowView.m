
//
//  FTShowView.m
//  FTNinePlaceMetre
//
//  Created by leo on 16/3/27.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "FTShowView.h"
#import "ViewController.h"
@interface FTShowView ()

@end
@implementation FTShowView
{
    CGRect _originFrame;
    BOOL _isShowing;
    CGRect _showingRect;
    UIView *_maskView;
}
- (instancetype)init {

    if (self = [super init]) {
        _showingRect.origin.y = [UIScreen mainScreen].bounds.size.height/3;
        _showingRect.origin.x = 0;
        _showingRect.size.height = [UIScreen mainScreen].bounds.size.height/3;
        _showingRect.size.width = [UIScreen mainScreen].bounds.size.width;
        self.frame = _showingRect;
        [self addTarget:self action:@selector(didClickShowButton) forControlEvents:UIControlEventTouchUpInside];
        _isShowing = NO;
    }
    return self;
}
- (void)showAnimationWithSender:(UIButton *)sender andSuperView:(UIView *)view {
    if (!_isShowing) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            _maskView.backgroundColor = [UIColor blackColor];
            _maskView.alpha = 0.7;
        });
        _maskView.hidden = NO;
        [view addSubview:_maskView];
        
        _originFrame = sender.frame;
        self.frame = sender.frame;
        [view addSubview:self];
        self.hidden = NO;
        
        [self setBackgroundImage:sender.currentBackgroundImage forState:UIControlStateNormal];
         [UIView animateWithDuration:1 animations:^{
            self.frame = _showingRect;
        }];
        _isShowing = YES;
        
    } else {
        [UIView animateWithDuration:1 animations:^{
            self.frame = _originFrame;
        }];
        _isShowing = NO;
        _maskView.hidden = YES;
        self.hidden = YES;
    }
}
- (void)didClickShowButton {
    [UIView animateWithDuration:1 animations:^{
        self.frame = _originFrame;
    }];
    [self performSelector:@selector(endShow) withObject:nil afterDelay:1];
}
- (void)endShow {
    _isShowing = NO;
    _maskView.hidden = YES;
    self.hidden = YES;
}
@end

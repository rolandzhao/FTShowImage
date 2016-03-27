//
//  ViewController.m
//  FTNinePlaceMetre
//
//  Created by leo on 16/3/27.
//  Copyright © 2016年 taofang. All rights reserved.
//

#import "ViewController.h"
#import "FTShowView.h"
@interface ViewController ()
@property (weak, nonatomic)UIImageView *pictureView;
@property (weak, nonatomic)FTShowView *showView;
@property (strong, nonatomic)NSArray *plist;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatButtonWithFormat:3 andButtonCount:8];
 
    FTShowView *showView = [[FTShowView alloc]init];
    _showView = showView;
    [self.view addSubview:self.showView];
    self.showView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  格式化创建按钮
 *
 *  @param num 每行几个按钮
 *  @param num 要创建几个按钮
 */
- (void)creatButtonWithFormat:(int)num andButtonCount:(int)count {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _plist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"images_ani" ofType:@"plist"]];
    });

    NSMutableArray *buttonList = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        button.frame = [self makeFrame:button.tag andNum:num andCount:count];

        NSString *imagePath = [NSString stringWithFormat:@"%@%03d", self.plist[i][@"icon"],1];

        UIImage *image = [UIImage imageNamed:imagePath];
        [self.view addSubview:button];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
        button.contentMode = UIViewContentModeScaleToFill;
        [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [buttonList addObject:button];
    }
}
- (CGRect)makeFrame:(NSInteger)tag andNum:(int)num andCount:(int)count {
    CGFloat marginX = 20;
    CGFloat marginY = 20;
    CGFloat width = 70;
    CGFloat height = 70;
    CGFloat marginLeft = ([UIScreen mainScreen].bounds.size.width - width*num -marginX*(num - 1))/2;
    CGFloat marginTop = ([UIScreen mainScreen].bounds.size.height -height*(count/num) - marginY*((count/num)-1))/2;
    long h = tag/num;
    long l = tag%num;
    CGFloat x = marginLeft + (width + marginX)*l;
    CGFloat y = marginTop + (height + marginY)*h;
    CGRect frame;
    frame = CGRectMake(x, y, width, height);
    return frame;
    
}




- (void)didClickButton:(UIButton *)sender {
    NSLog(@"点击了");
    [self.showView showAnimationWithSender:sender andSuperView:self.view];
}
@end

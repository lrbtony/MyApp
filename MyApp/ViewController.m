//
//  ViewController.m
//  MyApp
//
//  Created by lrb on 18/07/20.
//  Copyright © 2018年 liangruibin. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "GJPlayController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化第一个开始界面
    [self setupView];
   
   //右下角做分享,facebook,twitter,微信,微博....
    [self setupShareBtns];
    
    self.view.backgroundColor = [UIColor orangeColor];
}

#pragma mark - 开始设置按钮
-(void)setupView
{
    UIView *superview = self.view;
    //start
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setTitle:@"start" forState:UIControlStateNormal];
    [startBtn setBackgroundColor:[UIColor redColor]];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).offset(150 + 20);
        make.centerX.equalTo(superview.mas_centerX).offset(0);
        make.height.equalTo(100);
        make.width.equalTo(200);
    }];
    
    //setting
    UIButton *settingBtn = [[UIButton alloc]init];
    [settingBtn setTitle:@"setting" forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:settingBtn];
    [settingBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(startBtn.mas_bottom).offset( 100);
        make.centerX.equalTo(superview.mas_centerX).offset(0);
        make.height.equalTo(80);
        make.width.equalTo(150);
    }];
    
    
}


-(void)startBtnClick
{
    GJPlayController *playVC = [[GJPlayController alloc]init];
    playVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:playVC animated:YES completion:nil];
    
}

-(void)settingBtnClick
{
    
}

#pragma mark - 分享按钮
-(void)setupShareBtns
{
    UIView *superview = self.view;
    //使用shareSdk做分享功能
    //先做微信,微博的分享,后面才补facebook,twitter
    UIButton *wechatShareBtn = [[UIButton alloc]init];
    [wechatShareBtn setBackgroundColor:[UIColor greenColor]];
    [wechatShareBtn setTitle:@"W" forState:UIControlStateNormal ];
    [wechatShareBtn addTarget:self action:@selector(wechatShareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wechatShareBtn];
    [wechatShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_bottom).offset(-55);
        make.bottom.equalTo(superview.mas_bottom).offset( -5);
        make.right.equalTo(superview.mas_right).offset( - 60);
        make.height.equalTo(50);
        make.width.equalTo(50);
    }];
    
    //微博分享
    UIButton *weiboShareBtn = [[UIButton alloc]init];
    [weiboShareBtn setBackgroundColor: [UIColor yellowColor]];
    [weiboShareBtn setTitle:@"S" forState:UIControlStateNormal];
    [weiboShareBtn addTarget:self action:@selector(weiboShareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weiboShareBtn];
    [weiboShareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_bottom).offset(-55);
        make.bottom.equalTo(superview.mas_bottom).offset(-5);
        make.right.equalTo(superview.mas_right).offset( - 5);
        make.height.equalTo(50);
        make.width.equalTo(50);
    }];
    
}

-(void)wechatShareBtnClick
{
    GJLog(@"点击了微信朋友圈分享");
}

-(void)weiboShareBtnClick
{
    GJLog(@"点击了微博分享");
}




@end

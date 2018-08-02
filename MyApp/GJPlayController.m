//
//  GJPlayController.m
//  MyApp
//
//  Created by lrb on 18/07/20.
//  Copyright © 2018年 liangruibin. All rights reserved.
//

#import "GJPlayController.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>
#define degree2angle(angle)     ((angle) * M_PI / 180)
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)		( (180.0 * (rad)) / M_PI )
#define SQR(x)			( (x) * (x) )

@interface GJPlayController ()<AVAudioPlayerDelegate>
@property (nonatomic, assign) BOOL isSingle;
@property(nonatomic,weak)UIView *coverView;
@property(nonatomic,strong)CADisplayLink *link;
@property (nonatomic, assign) BOOL isAnimation;
@property(nonatomic,strong)AVAudioPlayer *player;
@property(nonatomic,weak)UIView *tapView;
@property (nonatomic, assign) CGFloat singleViewAngle;
@property(nonatomic,weak)UIView *tapBtn;
@property(nonatomic,weak)UILabel *tipLabel;
@property(nonatomic,weak)UILongPressGestureRecognizer *longPress;
@property (nonatomic,strong) NSArray *features;
@end

@implementation GJPlayController

#pragma mark - 懒加载
-(CADisplayLink *)link
{
    if (_link == nil) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateView)];
//        _link.frameInterval = 2;
    }
    return _link;
}

//-(UIView *)tapBtn
//{
//    if (_tapBtn == nil) {
//        UIView *tapBtn = [[UIView alloc]init];
//        tapBtn.layer.masksToBounds = YES;
//        tapBtn.layer.cornerRadius = 25;
//        [tapBtn setBackgroundColor:[UIColor yellowColor]];
//        _tapBtn = tapBtn;
//    }
//    return _tapBtn;
//}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    [self setupSingleOrDouble];
#warning 记得要让多点触控yes
    self.view.multipleTouchEnabled = YES;
    self.coverView.multipleTouchEnabled = YES;
}

-(void)setupSingleOrDouble
{
    //用一层半透明的window覆盖,然后添加单双手选项按钮
    //换个思路,只在透明遮罩层上面写上说明文字,然后根据用户一个手指点击或者两个手指点击事件,来决定下面的设计
    UIView *coverView = [[UIView alloc]init];
    self.coverView = coverView;
    coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:coverView];
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    //添加说明文字
    UILabel *detailLabel = [[UILabel alloc]init];
    [coverView addSubview:detailLabel];
    detailLabel.text = @"One or two hands do you need in your job which will do next ? \n If one , please tap in one finger . \n else tap in two fingers";
    detailLabel.textColor = [UIColor colorWithWhite:1 alpha:0.7];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.font = [UIFont systemFontOfSize:40];
    detailLabel.numberOfLines = 0;
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(coverView);
    }];
   

    //然后根据选项,给isSingle赋值
    
    //给出操作的提示语,闭眼,手指头放按钮上面
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    if ( [[event touchesForView:self.coverView] count] > 0) {
        
        if (touches.count == 1) {
            //一直手指单击的
            GJLog(@"一个手指单击");
            self.isSingle = YES;
        }else if (touches.count == 2) {
            GJLog(@"两个手指单击");
            self.isSingle = NO;
        }else{
            //大于两只手指,无效操作
            return;
        }
        //清理遮罩层
        [self.coverView removeFromSuperview];
        //加载后面的按钮
        [self setupDetailViewWith:self.isSingle];
        
    }
    [super touchesBegan:touches withEvent:event];
}

-(void)setupDetailViewWith:(BOOL)isSingle
{
    //初始化界面
    //返回按钮
    UIButton *backBtn = [[UIButton alloc]init];
    [backBtn setTitle:@"back" forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.size.equalTo(CGSizeMake(75, 75));
    }];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //单双手按钮
    if (self.isSingle) {
        //先做单手
        //先做一个view,里面有一个按钮
        UIView *tapView = [[UIView alloc]init];
        self.tapView = tapView;
        tapView.backgroundColor = [UIColor greenColor];
         [self.view addSubview:tapView];
        tapView.layer.masksToBounds = NO;
        tapView.layer.cornerRadius = 150;
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view.centerY).offset(0);
            //            make.center.equalTo(CGPointMake(100, 150)).offset(50);
            make.centerX.equalTo(self.view.centerX).offset(0);
            make.size.equalTo(CGSizeMake(300, 300));
        }];
        
        
        
       //写个背景
        UIImageView *bgImage = [[UIImageView alloc]init];
        [tapView addSubview:bgImage];
        bgImage.image = [UIImage imageNamed:@"椭圆-1"];
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(tapView);
        }];
        
        
        //写提示语
        UILabel *tipLabel = [[UILabel alloc]init];
        tipLabel.layer.masksToBounds = YES;
        tipLabel.layer.cornerRadius = 80;
        [tipLabel setBackgroundColor:[UIColor redColor]];
        tipLabel.numberOfLines = 0;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = [UIFont boldSystemFontOfSize:14];
        tipLabel.text = @"Long press the ring \n and close your eyes .  Follow the background \n music and move your finger clockwise.";
        self.tipLabel = tipLabel;
        tipLabel.userInteractionEnabled = NO;
        [self.view addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.tapView.center);
            make.size.equalTo(CGSizeMake(160, 160));
        }];
        //添加手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(startAct:)];
        self.longPress = longPress;
        longPress.minimumPressDuration = 1;
        [tapView addGestureRecognizer:longPress];
        
        
    }else{
        //双手
        
    }
    
    
    
}


-(void)startAct:(UIGestureRecognizer *)gesture
{
//    GJLog(@"移动开始");
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        //手指离开了屏幕
        self.isAnimation = NO;
        [self.player stop];
        [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        [self.tapBtn removeFromSuperview];
        self.link = nil;
//        self.tipLabel.text = @"";
        return;
    }
    
    //播放音乐,并且小圆圈移动
    if (self.isAnimation == NO) {
//        self.tapBtn.center = gesture.view.center;

        //写按钮
        UIView *tapBtn = [[UIView alloc]init];
        tapBtn.layer.masksToBounds = YES;
        tapBtn.layer.cornerRadius = 25;
        [tapBtn setBackgroundColor:[UIColor yellowColor]];
//        tapBtn.alpha = 0.4;
        self.tapBtn = tapBtn;
        [self.tapView addSubview:self.tapBtn];
        CGPoint touchPoint = [gesture locationInView:self.tapView];
        self.tapBtn.frame = CGRectMake(touchPoint.x - 25, touchPoint.y -25, 50, 50);
        
        [self startMusicAndAnimation];
    }
    
}

//实现思路.双手同时放在两个按钮的位置,闭眼(如果能实现就调用前置摄像头,检测到有人脸,但是没有眼睛,很难,要用到c++库OpenCV).然后等三秒后才开始播放音乐,然后小圆开始移动,手指跟着小圆移动而移动,(这里有检测功能,如果点击的位置离得太远的话,音乐播放的速率会改变)
-(void)startMusicAndAnimation
{
    //播放音乐
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Final Fantasy XIV Heavensward-Original Sound Track 06" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.player = player;
    // 设置循环次数，-1为一直循环
    player.numberOfLoops = -1;
    //允许调整速率
    player.enableRate = YES;
    
    // 准备播放
    [player prepareToPlay];
    // 设置播放音量
    player.volume = 1;
    // 当前播放位置，即从currentTime处开始播放，相关于android里面的seekTo方法
//    player.currentTime = 6;
    // 设置代理
    player.delegate = self;
    
    [player play];
    
    //小圆圈动起来
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    self.isAnimation = YES;
    
    
    
    
    
}


-(void)changeRateOfMusic:(float)angle
{
#warning 这里更改一下改变速率的条件.改变了判断的条件,变成了根据两个之间的角度差判断,区间在0.5~1.5之间
    
    int r = (int)angle / 10.0;
    double ra = r / 10.0;
    if (ra >= 0.5) {
        ra = 0.5;
    }else if (ra <= - 0.5){
        ra = - 0.5;
    }
    self.player.rate = 1 + ra;
    //改变提示语的显示,变成速率
    self.tipLabel.text = [NSString stringWithFormat:@"%.2f",self.player.rate];
}

-(void)updateView
{
    CGFloat angle = degree2angle(6 / self.player.duration);
//    GJLog(@"%f",angle);
    self.singleViewAngle += angle ;
    self.tapView.transform = CGAffineTransformMakeRotation(self.singleViewAngle);
//    self.tapView.transform = CGAffineTransformRotate(self.tapView.transform, angle);
    
    CGPoint touchPoint = [self.longPress locationInView:self.tapView];
    CGPoint btnPoint = self.tapBtn.center;
    CGPoint centerPoint = CGPointMake(150, 150);
    float touchAngle = AngleFromNorth(centerPoint, touchPoint, NO);
    float btnAngle = AngleFromNorth(centerPoint, btnPoint, NO);
    //    GJLog(@"touchAngle = %.2f, btnAngle = %.2f",touchAngle,btnAngle);
    [self changeRateOfMusic:(touchAngle - btnAngle)];
}

-(float)distanceFromPointX:(CGPoint)start distanceToPointY:(CGPoint)end{
    float distance;
    //下面就是高中的数学，不详细解释了
    CGFloat xDist = (end.x - start.x);
    CGFloat yDist = (end.y - start.y);
    distance = sqrt((xDist * xDist) + (yDist * yDist));
    return distance;
}

-(void)backBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//Sourcecode from Apple example clockControl
//Calculate the direction in degrees from a center point to an arbitrary position.
static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped) {
    CGPoint v = CGPointMake(p2.x-p1.x,p2.y-p1.y);
    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
    v.x /= vmag;
    v.y /= vmag;
    double radians = atan2(v.y,v.x);
    result = ToDeg(radians);
//    GJLog(@"%f",result);
//    return (result >=0  ? result : result + 360.0);
    return result;
}

@end

//
//  CdView.m
//  jwTextFiled
//
//  Created by Mac_NJW on 16/9/20.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CdView.h"

@interface CdView ()<UIGestureRecognizerDelegate>
{
    NSTimer *_timer;
    UITapGestureRecognizer *_tap;
    UILabel *_getSmsCoed_Lab;
    UIImageView *_smscode_img;
    NSString *_runImg,*_stopImg;
    UIColor *_runColor,*_stopColor;
    int _cd_count_stag;
}
@end

@implementation CdView

#pragma mark———————— 提供给 纯代码的初始化方法

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        
        // 创建imageView
        [self create_SmsCoed_Img];
        // 创建lable
        [self create_getSmsCoed_Lab];
        // 初始化手势
        [self createTapOnCdView];
        
    }
    return self;
}


#pragma mark—————————— 提供给 XIB 使用的初始化方法

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self create_SmsCoed_Img];
    [self create_getSmsCoed_Lab];
    [self createTapOnCdView];
    
}

// 创建 ImageView
- (void)create_SmsCoed_Img{
    
    if (!_smscode_img) {
        
        _smscode_img = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self setRunCdColor];
        
        [_smscode_img setBackgroundColor:[UIColor orangeColor]];
        
        [self addSubview:_smscode_img];
    }
}

// 创建 label
- (void)create_getSmsCoed_Lab{
    
    if (!_getSmsCoed_Lab) {
        
        _getSmsCoed_Lab = [[UILabel alloc] initWithFrame:self.bounds];
        _getSmsCoed_Lab.backgroundColor = [UIColor clearColor];
        [_getSmsCoed_Lab setFont:[UIFont fontWithName:@"Heiti SC" size:14]];// 可定制
        [_getSmsCoed_Lab setText:@"获取验证码"];
        [_getSmsCoed_Lab setTextAlignment:NSTextAlignmentCenter];
        [_getSmsCoed_Lab setTextColor:[UIColor whiteColor]];
        
        [self addSubview:_getSmsCoed_Lab];
    }
}

// 创建手势
- (void)createTapOnCdView{
    
    if (self) {
        
        // 初始化手势
        _tap = [[UITapGestureRecognizer alloc] init];
        _tap.delegate = self;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:_tap];
    }
}

/* cd 创建 */
- (void)createCd{
    
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(runFire:) userInfo:nil repeats:YES];
    }
    
}

// 计时器开始跑
- (void)runFire:(NSTimer*)timer{
    
    _cd_count_stag -- ;
    if (0 > _cd_count_stag) {
        [_timer invalidate];
        _timer  = nil;
        [self the_CdIsRunning:NO];
        [_getSmsCoed_Lab setText:@"获取验证码"];
        
        self.userInteractionEnabled = YES;
        
    }else{
        [self the_CdIsRunning:YES];
        [_getSmsCoed_Lab setText:[NSString stringWithFormat:@"%d 秒后重发",_cd_count_stag]];
        
        self.userInteractionEnabled = NO;
    }
    
}

// 重发 Lab 的两态
- (void)the_CdIsRunning:(BOOL)is_cd{
    
    if (is_cd) {
        
        // 要 cd
        [self setRunCdColor];
        
    }else{
        
        [self setStopCdColor];
        
    }
}

// 要 cd 时候的 Color
- (void)setRunCdColor{
    
    if (_stopImg && !_stopColor) {
        
        [_smscode_img setImage:[UIImage imageNamed:_stopImg]];
        
    }else if (_stopColor && !_stopImg){
        
        [_smscode_img setBackgroundColor:_stopColor];
        
    }else if (_runColor && _stopImg){
        
        [_smscode_img setBackgroundColor:_stopColor];
        
    }else{
        
        [_smscode_img setBackgroundColor:[UIColor grayColor]];
    }
    
}

// 非要 cd 时候的 Color
- (void)setStopCdColor{
    
    if (_runImg && !_runColor) {
        
        [_smscode_img setImage:[UIImage imageNamed:_runImg]];
        
    }else if (_runColor && !_runImg){
        
        [_smscode_img setBackgroundColor:_runColor];
        
    }else if (_runColor && _runImg){
        
        [_smscode_img setBackgroundColor:_runColor];
        
    }else{
        
        [_smscode_img setBackgroundColor:[UIColor orangeColor]];
    }
    
}

/* cd 销毁并停止 */
- (void)stopCd{
    
    if (_timer) {
        
        [_timer invalidate];
        _timer = nil;
        _cd_count_stag = 0;
        
    }
}

/* cd 开🏃 */
- (void)runCd{
    
    if (0!= self.cd_count) {
        _cd_count_stag = self.cd_count;
        
    }else{
        _cd_count_stag = 0;
    }
    
    [self createCd];
    
}


/* cd 的点击事件传递（纯代码） */
-(instancetype)initWithFrame:(CGRect)frame addTarget:(id)target action:(SEL)action{
    if ((self = [self initWithFrame:frame])) {
        [self createTapOnCdView];
        
        [_tap addTarget:target action:action];
        
    }
    return self;
}

/* cd 的点击事件传递（xib） */
-(void)addTarget:(id)target action:(SEL)action{
    
    [_tap addTarget:target action:action];
    
}


/* 配置 runCd 与 stopCd 的组件背景色 01（可以是图片，可以是颜色,二者选其一）*/
- (void)setRunCd_bgImg:(NSString*)runImgName andStopCd_bgImg:(NSString*)stopImgName{
    
}

/* 配置 runCd 与 stopCd 的组件背景色 02（可以是图片，可以是颜色,二者选其一）*/
- (void)setRunCd_bgColor:(UIColor*)runColor andStopCd_bgColor:(UIColor*)stopColor{
    
}


/* 配置 layer 的圆角 */
- (void)setCdLayer_cornerRadius:(CGFloat)cornerRadiu{
    
    for (UIView *obj in @[self,_smscode_img]) {
        
        if (obj) {
            if ( 0 != cornerRadiu && cornerRadiu > 0) {
                
                obj.layer.cornerRadius = cornerRadiu;
                obj.layer.masksToBounds = YES;
            }
        }
    }
}


/* 配置 border 的值 */
- (void)setCdLayer_borderColor:(UIColor*)color borderWidth:(CGFloat)width {
    
    for (UIView *obj in @[self,_smscode_img]) {
        
        if (obj) {
            if ( 0 != width ) {
                
                obj.layer.borderWidth = width;
            }
            if ( nil != color ) {
                
                obj.layer.borderColor = color.CGColor;
                
            }
        }
    }
    
}


/* 配置 Cd 的定制字体定制样式 */
- (void)setCdFont:(NSString*)str andCustomLableAttribute:(NSDictionary*)customDic keepar:(NSString*)keepar{
    
    // 定制可扩展的方法(这里设定非特定样式的 Lab 属性)
    //....
    
    if ([keepar isEqualToString:@"FORE"]) {
        
        [_getSmsCoed_Lab jw_makeLableRichText:@"获取验证码" attributeDic:customDic];
        
    }
    
    if ([keepar isEqualToString:@"AFTER"]) {
        
        //这里可以设定特殊字体的样式
        [_getSmsCoed_Lab jw_makeLableRichText:@"秒后重发" attributeDic:customDic];
        
    }
}

@end

/*
 
 *********************************************************************
 *
 * 🌟🌟🌟 新建交流QQ群：215901818 🌟🌟🌟
 *
 * 在您使用此组件的过程中如果出现bug请及时告知QQ群主，我会及时修复bug并
 * 帮您解决问题。
 * 博客地址:http://www.jianshu.com/p/80ef2d47729d
 * Email : 2795041895@qq.com
 * GitHub:https://github.com/NIUXINGJIAN/OC_PLAYGROUND.git
 *
 *  做简单的封装，麻烦自己，方便别人
 *********************************************************************
 
 */

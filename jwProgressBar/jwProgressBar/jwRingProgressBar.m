//
//  jwRingProgressBar.m
//  jwRingProgressBar
//
//  Created by JW_N on 16/9/17.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "jwRingProgressBar.h"


// 中间Lab 字体大小
#define K_MID_LAB_FONT 16
// 进度条宽度
#define K_PRO_WIDTH     2
// 进度条的颜色
#define K_PRO_LINE_BGC  @""
// 进度条背景色
#define K_PRO_CONT_BGC  @""

// 容器样式
typedef NS_ENUM(NSInteger,CIR_CONTAIN_TYPE) {
    CIR_CONTAIN_TYPE_0,//无缝隙
    CIR_CONTAIN_TYPE_1,//有缝隙
    
};

// 进度条样式
typedef NS_ENUM(NSInteger,CIR_PROGRESS_TYPE) {
    CIR_PROGRESS_TYPE_0,//两端（无圆弧、无空格）
    CIR_PROGRESS_TYPE_1,//无圆弧，有空格
    CIR_PROGRESS_TYPE_2 //有圆弧，无空格
};



@interface jwRingProgressBar()
{
    CAShapeLayer *_bottomShapeLayer;
    CAShapeLayer *_upperShapeLayer;
    CGFloat _percent;
    UILabel *_percentLabel;
    int temp;
    NSTimer *_timer;
}

@end

@implementation jwRingProgressBar

#pragma mark———————— 提供给 纯代码的初始化方法

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self drawBottomLayer];
        [self drawUpperLayer];
        [self.layer addSublayer:_bottomShapeLayer ];
        
        [_bottomShapeLayer addSublayer:_upperShapeLayer];
        
        // 文本框
        [self drawTextLabel];
        [self addSubview:_percentLabel];
        
    }
    return self;
}


#pragma mark—————————— 提供给 XIB 使用的初始化方法

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self drawBottomLayer];
    [self drawUpperLayer];
    [self.layer addSublayer:_bottomShapeLayer ];
    
    [_bottomShapeLayer addSublayer:_upperShapeLayer];
    
    // 文本框
    [self drawTextLabel];
    [self addSubview:_percentLabel];
    
}

- (UILabel *)drawTextLabel
{
    _percentLabel = [[UILabel alloc] init];
    CGFloat width = self.frame.size.width / 1.25;
    CGFloat height = self.frame.size.height / 1.25;
    _percentLabel.center = [self getDrawCGPoint];
    _percentLabel.bounds = CGRectMake(0, 0, width, height);
    
    _percentLabel.font = [UIFont boldSystemFontOfSize:K_MID_LAB_FONT];
    _percentLabel.textAlignment = NSTextAlignmentCenter;
    _percentLabel.textColor = [UIColor redColor];
    
    if (!_timer) {
        temp = 0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(percentChange) userInfo:nil repeats:YES];
    }
    return _percentLabel;
}


- (void)percentChange
{
    temp++;
    if (temp <= _percent *100) {
        
        _percentLabel.text = [NSString stringWithFormat:@"%d%%",temp ];
        
    }else{
        
        // 保证正确百分比
        _percentLabel.text = [NSString stringWithFormat:@"%d%%",(int)(_percent*100)];
        
        [_timer invalidate];
        _timer = nil;
        
        // 为百分比的 Lab 设计缩放动画
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.5;
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        animation.values = values;
        [_percentLabel.layer addAnimation:animation forKey:nil];
        
    }
}

// 得到位置point
- (CGPoint)getDrawCGPoint{
    
    CGFloat x = (CGRectGetMaxX(self.frame) - CGRectGetMinX(self.frame)) / 2;
    CGFloat y = (CGRectGetMaxY(self.frame) - CGRectGetMinY(self.frame)) / 2;
    CGPoint point = CGPointMake(x, y);
    
    return point;
}


// 底部的容器
- (CAShapeLayer *)drawBottomLayer
{
    _bottomShapeLayer = [[CAShapeLayer alloc] init];
    _bottomShapeLayer.frame = self.bounds;
    CGFloat width  = self.bounds.size.width;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:[self getDrawCGPoint]  radius:width / 2 startAngle:0 endAngle:6.28 clockwise:YES];
    _bottomShapeLayer.path = path.CGPath;
    _bottomShapeLayer.lineWidth = K_PRO_WIDTH;
    
    // 设置样式
    [self setContainType:CIR_CONTAIN_TYPE_0 ProgressType:CIR_PROGRESS_TYPE_0];
    
    _bottomShapeLayer.strokeColor = [UIColor blackColor].CGColor;
    _bottomShapeLayer.fillColor  = [UIColor clearColor].CGColor;
    return _bottomShapeLayer;
}

// 进度条
- (CAShapeLayer *)drawUpperLayer
{
    _upperShapeLayer = [[CAShapeLayer alloc] init];
    _upperShapeLayer.frame = self.bounds;
    CGFloat width  = self.bounds.size.width;
    
    /* // 从 (- M_PI) 开始绘制
     UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:[self getDrawCGPoint]radius:width / 2 startAngle:-3.14 endAngle:-3.141 clockwise:YES];
     */
    
    // 按照时钟，从 0 点开始绘制
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:[self getDrawCGPoint]radius:width / 2 startAngle:-1.57 endAngle:4.71 clockwise:YES];
    
    // 设置样式
    [self setContainType:CIR_CONTAIN_TYPE_0 ProgressType:CIR_PROGRESS_TYPE_0];
    
    _upperShapeLayer.path = path.CGPath;
    _upperShapeLayer.lineWidth = K_PRO_WIDTH;
    _upperShapeLayer.strokeStart = 0;
    _upperShapeLayer.strokeEnd = _percent;
    
    // 进度条的动画
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=_percent;//动画时间
    bas.delegate=self;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    [_upperShapeLayer addAnimation:bas forKey:@"key"];
    
    
    _upperShapeLayer.strokeColor     = [UIColor redColor].CGColor;
    _upperShapeLayer.fillColor       = [UIColor clearColor].CGColor;
    
    
    return _upperShapeLayer;
}



// 设置进度条的样式
- (void)setContainType:(CIR_CONTAIN_TYPE)ctype ProgressType:(CIR_PROGRESS_TYPE)type {
    
    switch (ctype) {
            
        case CIR_CONTAIN_TYPE_0:
            
            /**
             *  设置进度条父视图（无间隔）
             */
            _bottomShapeLayer.lineCap = kCALineCapSquare;
            
            /**
             *  设置进度条视图
             */
            [self setProgressType:type];
            
            break;
            
            
        case CIR_CONTAIN_TYPE_1:
            
            /**
             *  设置进度条父视图 （有间隔）
             */
            _bottomShapeLayer.lineCap = kCALineCapButt;
            _bottomShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:5], nil];
            
            /**
             *  设置进度条视图
             */
            [self setProgressType:type];
            
            break;
            
        default:
            break;
    }
    
}

// 设置进度条
-(void)setProgressType:(CIR_PROGRESS_TYPE)type{
    
    switch (type) {
        case CIR_PROGRESS_TYPE_0:
            
            // （两端无圆弧，中间无空格）
            _upperShapeLayer.lineCap = kCALineCapButt;
            _upperShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:0], nil];
            
            break;
        case CIR_PROGRESS_TYPE_1:
            
            // （两端无圆弧，中间有空格）
            _upperShapeLayer.lineCap = kCALineCapButt;
            _upperShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:5], nil];
            
            break;
        case CIR_PROGRESS_TYPE_2:
            
            // 两端有圆弧的 中间无空格
            _upperShapeLayer.lineCap = kCALineCapRound;
            
            break;
        default:
            break;
    }
    
}

@synthesize percent = _percent;
- (CGFloat )percent
{
    return _percent;
}

- (void)setPercent:(CGFloat)percent
{
    _percent = percent;
    
    if (_upperShapeLayer) {
        
        // 移除
        [_upperShapeLayer removeFromSuperlayer];
        _upperShapeLayer = nil;
        
        //创建
        [self drawUpperLayer];
        [_bottomShapeLayer addSublayer:_upperShapeLayer];
        
    }
    
    if (_percentLabel) {
        
        //移除
        [_timer invalidate];
        _timer = nil;
        [_percentLabel removeFromSuperview];
        _percentLabel = nil;
        
        // 创建
        [self drawTextLabel];
        [self addSubview:_percentLabel];
        
    }
    
    if (percent > 1) {
        percent = 1;
    }else if (percent < 0){
        percent = 0;
    }
    
}

@end


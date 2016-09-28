//
//  CdView.h
//  jwTextFiled
//
//  Created by Mac_NJW on 16/9/20.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+jwExten.h"

typedef void(^FeasibleBlock)(BOOL isFeasible);
@interface CdView : UIView

/* cd 走的时间 */
@property (nonatomic,assign)int cd_count;

/* cd 开🏃 */
- (void)runCd;


/* cd 销毁 */
- (void)stopCd;


/* cd 的点击事件传递（纯代码） */
-(instancetype)initWithFrame:(CGRect)frame addTarget:(id)target action:(SEL)action;


/* cd 的点击事件传递（xib） */
-(void)addTarget:(id)target action:(SEL)action;


/* 配置 runCd 与 stopCd 的组件背景色（可以是图片，可以是颜色,二者选其一）*/
- (void)setRunCd_bgImg:(NSString*)runImgName andStopCd_bgImg:(NSString*)stopImgName;
- (void)setRunCd_bgColor:(UIColor*)runColor andStopCd_bgColor:(UIColor*)stopColor;

/* 配置 Cd 的定制字体定制样式 */
- (void)setCdFont:(NSString*)str andCustomLableAttribute:(NSDictionary*)customDic keepar:(NSString*)keepar;

/* 配置 layer 的圆角 */
- (void)setCdLayer_cornerRadius:(CGFloat)cornerRadiu;

/* 配置 border 的值 */
- (void)setCdLayer_borderColor:(UIColor*)color borderWidth:(CGFloat)width;

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

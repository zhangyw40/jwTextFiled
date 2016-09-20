//
//  UILabel+jwExten.h
//  jwTextFiled
//
//  Created by Mac_NJW on 16/9/20.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (jwExten)


/**
 *  本次封装，仅仅是方便 UIlabe 的富文本的格式支持
 *
 *  @param richText 要设置的文字
 *  @param dic        要传入的字体格式的字典
 */
- (void)jw_makeLableRichText:(NSString*)richText attributeDic:(NSDictionary*)dic;


/**
 *  本次封装，根据 Labe 的文字自己计算出高度,并设置 Lab 的位置
 *
 *  @param orignSize 原来的 size ；如要自适应高度，一般传入 CGSizeMake(控件的宽度, 1000)
 *  @param dic       Labe 文字的一些属性
 */
- (void)jw_setLableCGsize:(CGSize)orignSize attributes:(NSDictionary*)dic;


/**
 *  本次封装，仅仅是方便，根据 Labe 的文字自己计算出高度
 *
 *  @param orignSize 原来的 size ；如要自适应高度，一般传入 CGSizeMake(控件的宽度, 1000)
 *  @param dic       Labe 文字的一些属性
 */
- (CGSize)jw_getLableCGsize:(CGSize)orignSize attributes:(NSDictionary*)dic;


// 检测是否是 @"" 或 nil 的情况
- (BOOL)isFull_AllPramaMethod:(NSArray*)pramAry;



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

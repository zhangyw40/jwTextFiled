//
//  jwMacro.h
//  jwTextFiled
//
//  Created by JW_N on 16/9/16.
//  Copyright © 2016年 Mac. All rights reserved.
//

#ifndef jwMacro_h
#define jwMacro_h

#import "AppDelegate.h"

// 判断设备的宏
/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define K_IS_IPHONE_4  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define K_IS_IPHONE_5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define K_IS_IPHONE_6   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define K_IS_IPHONE_6P  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


// 定义一个弹框
#define ALT_SHOW(a,b,c) UIAlertView *altview = [[UIAlertView alloc] initWithTitle:(a) message:(b) delegate:nil cancelButtonTitle:(c) otherButtonTitles:nil, nil];[altview show];



//  拿到霸屏
#define AX_KEY_WINDOW ((AppDelegate*)[UIApplication sharedApplication].delegate).window
//  拿到 AppDelegate 实例
#define AX_APP_DELEGATE (AppDelegate*)[UIApplication sharedApplication].delegate



#endif /* jwMacro_h */



/*
 
 *********************************************************************
 *
 * 🌟🌟🌟 新建交流QQ群：215901818 🌟🌟🌟
 *
 * 在您使用此组件的过程中如果出现bug请及时告知QQ群主，我会及时修复bug并
 * 帮您解决问题。
 * 博客地址:
 * Email : 2795041895@qq.com
 * GitHub:
 *
 *  做简单的封装，麻烦自己，方便别人
 *********************************************************************
 
 */



//
//  jwUiMacro.h
//  jwMacro
//
//  Created by JW_N on 16/9/17.
//  Copyright © 2016年 Mac. All rights reserved.
//
/* 放入所有继承自 UI层 的一些控件相关的宏 */


//  拿到霸屏
#define AX_KEY_WINDOW ((AppDelegate*)[UIApplication sharedApplication].delegate).window

//  拿到 AppDelegate 实例
#define AX_APP_DELEGATE (AppDelegate*)[UIApplication sharedApplication].delegate
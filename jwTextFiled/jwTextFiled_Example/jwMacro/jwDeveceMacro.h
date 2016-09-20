//
//  jwDeveceMacro.h
//  jwMacro
//
//  Created by JW_N on 16/9/17.
//  Copyright © 2016年 Mac. All rights reserved.
//
/* 所有关于 IOS 设备相关的宏文件 */


// 判断是否大于某一个系统版本
#define IS_GREATER_IOS(x) ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>x)

// 获取系统版本
/** 是否为iOS6 */
#define iOS6 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) ? YES : NO)
/** 是否为iOS7 */
#define iOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)
/** 是否为iOS8 */
#define iOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)
/** 是否为iOS9 */
#define iOS9 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO)
/** 是否为iOS10*/
#define iOS10 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) ? YES : NO)

// 判断设备的宏
/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define K_IS_IPHONE_4  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define K_IS_IPHONE_5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define K_IS_IPHONE_6   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define K_IS_IPHONE_6P  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)





// 设备的高度
// 设计尺寸，iphone6
#define K_IPHONE_6_WIDTH  375
#define K_IPHONE_6_HEIGHT 667

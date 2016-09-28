
//
//  jwUnitilsMacro.h
//  jwMacro
//
//  Created by JW_N on 16/9/17.
//  Copyright © 2016年 Mac. All rights reserved.
//
/*  本文件是一些方法的宏定义  */


#pragma mark—————————— 弹框提示
// 定义一个弹框
#define ALT_SHOW(a,b,c) UIAlertView *altview = [[UIAlertView alloc] initWithTitle:(a) message:(b) delegate:nil cancelButtonTitle:(c) otherButtonTitles:nil, nil];[altview show];


#pragma mark—————————— 图片
// 读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

// 快速的定义UIImage对象
// eg: imgView.image = IMAGE(@"Default.png");
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]


#pragma mark—————————— 字符串处理
// 将 CFFloat 格式的数据转化为字符串
#define intToStr(S)    [NSString stringWithFormat:@"%.2f",S]

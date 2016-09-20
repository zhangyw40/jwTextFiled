//
//  FrameMacro.h
//  jwMacro
//
//  Created by JW_N on 16/9/17.
//  Copyright © 2016年 Mac. All rights reserved.
//

#ifndef FrameMacro_h
#define FrameMacro_h


#define PAY_NAVI_BAR_HEIGHT  64  // navigationBar 高度
#define PAY_TAB_BAR_HEIGHT   49   // tabbar 高度

// App 宽高
#define K_WIDTH  [UIScreen mainScreen].bounds.size.width 
#define K_HEIGHT [UIScreen mainScreen].bounds.size.height

// 支付密码输入控件 FRAME
#define K_PAY_PWSBOX_FRAME CGRectMake((K_WIDTH-240)/2, (K_HEIGHT-134)/2, 240, 134)






#pragma mark————————> 支持在 Masonry 框架中传入UI工程师原始像素值，自动转化为物理像素值，并且在不同设备上能够去按照UI效果图等比缩放
// 做UI效果标示，设备标示(支持 4、5、6、6+ )使用字串标示
#define K_BENCHMARK @"6+"
// 转化比例(** VALUE 是UI像素尺寸，返回适配后+不同设备等比UI缩放 适配 **)
#define K_CHANGE(VALUE)  [AppDelegate changeUitoDevecePixel:(VALUE)]
/*
 辅助 Masnory 库制作所有的设备参照UI效果图等比缩放适配，VALUE 是UI尺寸，使用前先配置 K_BENCHMARK 参数
 并在 APPDelegate 中添加方法；
 
 + (CGFloat)changeUitoDevecePixel:(CGFloat)value;
 并实现：
 + (CGFloat)changeUitoDevecePixel:(CGFloat)orignUiValue{
 
 CGFloat resultvalue = 0;
 NSString * temp = K_BENCHMARK;
 
 BOOL is_pixe_4 = [temp isEqualToString:@"4"]?YES:NO;
 BOOL is_pixe_5 = [temp isEqualToString:@"5"]?YES:NO;
 BOOL is_pixe_6 = [temp isEqualToString:@"6"]?YES:NO;
 BOOL is_pixe_6p = [temp isEqualToString:@"6+"]?YES:NO;
 
 if (is_pixe_4) {
 
 CGSize pixelSize = CGSizeMake(640, 960);
 
 resultvalue = [AppDelegate get_scaleUiPixel:orignUiValue deveceUiPixel:pixelSize];
 
 }
 
 if (is_pixe_5) {
 
 CGSize pixelSize = CGSizeMake(640, 1136);
 
 resultvalue = [AppDelegate get_scaleUiPixel:orignUiValue deveceUiPixel:pixelSize];
 
 }
 
 if (is_pixe_6) {
 
 CGSize pixelSize = CGSizeMake(640, 1134);
 
 resultvalue = [AppDelegate get_scaleUiPixel:orignUiValue deveceUiPixel:pixelSize];
 
 }
 
 if (is_pixe_6p) {
 
 CGSize pixelSize = CGSizeMake(1080, 1920);
 
 resultvalue = [AppDelegate get_scaleUiPixel:orignUiValue deveceUiPixel:pixelSize];
 
 }
 
 return resultvalue;
 
 }
 
 // 返回不同设备的Ui效果缩放比
 + (CGFloat)get_scaleUiPixel:(CGFloat)orignUiValue deveceUiPixel:(CGSize)pixelSize {
 
 CGFloat newPixel = 0.0f;
 
 if (K_IS_IPHONE_4 ) {
 
 CGFloat w = 640;
 CGFloat h = 960;
 
 CGFloat s_w = pixelSize.width;
 CGFloat s_H = pixelSize.height;
 
 CGFloat scale = ( ( w / s_w ) + ( h / s_H ) ) * 0.5;
 
 CGFloat base = ((640/320) + (960/480))*0.5;
 
 newPixel = orignUiValue * scale / base;
 
 }
 
 if (K_IS_IPHONE_5 ) {
 
 CGFloat w = 640;
 CGFloat h = 1136;
 
 CGFloat s_w = pixelSize.width;
 CGFloat s_H = pixelSize.height;
 
 CGFloat scale = ( ( w / s_w ) + ( h / s_H ) ) * 0.5;
 
 CGFloat base = ((640/320) + (1136/568))*0.5;
 
 newPixel = orignUiValue * scale / base;
 
 }
 
 if (K_IS_IPHONE_6 ) {
 
 CGFloat w = 750;
 CGFloat h = 1334;
 
 CGFloat s_w = pixelSize.width;
 CGFloat s_H = pixelSize.height;
 
 CGFloat scale = ( ( w / s_w ) + ( h / s_H ) ) * 0.5;
 
 CGFloat base = ((750/375) + (1334/667))*0.5;
 
 newPixel = orignUiValue * scale / base;
 
 }
 
 if (K_IS_IPHONE_6P ) {
 
 CGFloat w = 1080;
 CGFloat h = 1920;
 
 CGFloat s_w = pixelSize.width;
 CGFloat s_H = pixelSize.height;
 
 CGFloat scale = ( ( w / s_w ) + ( h / s_H ) ) * 0.5;
 
 CGFloat base = ((1080/414) + (1920/736))*0.5;
 
 newPixel = orignUiValue * scale / base;
 
 }
 
 return orignUiValue;
 
 }
 
 */



#endif /* FrameMacro_h */

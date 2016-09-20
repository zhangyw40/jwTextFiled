//
//  jwColorMacro.h
//  jwMulitiButton
//
//  Created by JW_N on 16/9/17.
//  Copyright © 2016年 Mac. All rights reserved.
//

#ifndef jwColorMacro_h
#define jwColorMacro_h
#import "UIColor+jwHex.h"

// 颜色的方法，传入（#xxxxx）格式，返回颜色设置
#define K_SET_COLOR_VALUE(a)   [UIColor colorWithHexString:(a)]
#define K_SET_COLOR_VALUE_AlPHA(a,b)   [UIColor colorWithHexString:(a) alpha:(b)]

#define K_COLOR_A(a,b,c,d) [UIColor colorWithRed:(a)/255.0 green:(b)/255.0 blue:(c)/255.0 alpha:(d)]
#define K_H_COLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 页面的统一底色
#define K_ROOT_BGC   @"#f9f9f9"
// 页面中线的描边颜色
#define K_LINE_BGC @"#e4e4e4"

#endif /* jwColorMacro_h */

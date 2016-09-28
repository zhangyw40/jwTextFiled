//
//  UILabel+jwExten.m
//  jwTextFiled
//
//  Created by Mac_NJW on 16/9/20.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "UILabel+jwExten.h"

@implementation UILabel (jwExten)

// 设置富文本
- (void)jw_makeLableRichText:(NSString*)richText attributeDic:(NSDictionary*)dic{
    
    if ([self isFull_AllPramaMethod:@[richText]]) {
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSRange range = [self.text rangeOfString:richText];
        [attributeString addAttributes:dic range:range];
        self.attributedText = attributeString;
        
    }else{
        
        NSLog(@"仅仅是方便 UIlabe 的富文本的格式支持判断: 你没有输入要设置富文本的文字，不能为nil");
    }
    
}

// 设置规格
- (void)jw_setLableCGsize:(CGSize)orignSize attributes:(NSDictionary*)dic{
    
    [self setLineBreakMode:NSLineBreakByCharWrapping];
    [self setNumberOfLines:0];
    CGSize size = [self.text boundingRectWithSize:orignSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height);
    
}


- (CGSize)jw_getLableCGsize:(CGSize)orignSize attributes:(NSDictionary*)dic{
    
    [self setLineBreakMode:NSLineBreakByCharWrapping];
    [self setNumberOfLines:0];
    
    return [self.text boundingRectWithSize:orignSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
}


// 检测是否是 @"" 或 nil 的情况
- (BOOL)isFull_AllPramaMethod:(NSArray*)pramAry{
    BOOL isOk = NO;
    //判断是否所有的自动登录字段是否为nil
    for (int j = 0 ; j < pramAry.count; j++) {
        NSString *tt = pramAry[j];
        if (nil != tt) {
            isOk = YES;
            
        }else{
            isOk = NO;
            return isOk;//强制跳出循环
        }
    }
    //走到这里，所有字符串都取出来，不为nil
    //判断是否所有的自动登录字段是否全不为空值（@""）
    for (int i = 0 ; i < pramAry.count; i++) {
        NSString *tt = pramAry[i];
        NSString *nn = @"";
        if (![tt isEqualToString:nn]) {
            isOk = YES;
        }else{
            isOk = isOk;
            return NO;//强制跳出循环
        }
    }
    return isOk;
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


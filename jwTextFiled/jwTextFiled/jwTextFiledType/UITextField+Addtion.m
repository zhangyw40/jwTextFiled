//
//  UITextField+Addtion.m
//  HuJIn
//
//  Created by Mac_NJW on 16/9/13.
//  Copyright © 2016年 Mac_NJW. All rights reserved.
//


#import "UITextField+Addtion.h"
#import <objc/runtime.h>


@implementation UITextField (Addtion)

// 内部实现对不同输入框的长度的限制初始化方法
 void  *key;
-(void)setTextFiled_Type:(TEXTFIELD_TYPE)textFiled_Type{
    objc_setAssociatedObject(self, key, [NSString stringWithFormat:@"%ld",(long)textFiled_Type], OBJC_ASSOCIATION_ASSIGN);
}
- (TEXTFIELD_TYPE)textFiled_Type {
    id type = objc_getAssociatedObject(self, key);
    return (TEXTFIELD_TYPE)[type integerValue];
}
-(void)setTempBlock:(AfterEnterBlock)tempBlock{
    
    objc_setAssociatedObject(self, @selector(tempBlock), tempBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(AfterEnterBlock)tempBlock{
    
    id type = objc_getAssociatedObject(self, @selector(tempBlock));
    return (AfterEnterBlock)type;
}


// 外部实现调用
-(void)setTextFiledType:(TEXTFIELD_TYPE)type{
    
    // 设置动态属性
    [self setTextFiled_Type:type];
    
    // 设置输入框类型
    [self setJW_KeyboardType:type];
    
}

- (void)setJW_KeyboardType:(TEXTFIELD_TYPE)textType{
    
    switch (self.textFiled_Type) {
            
            // 用户名
        case TEXTFIELD_TYPE_LOGIN_U:
            
            [self setKeyboardType:UIKeyboardTypeDefault];
            //...
            break;
            
            
            // 用户登录密码
        case TEXTFIELD_TYPE_LOGIN_P:
            
            [self setKeyboardType:UIKeyboardTypeASCIICapable];//ASIICA 类型键盘（自己可修改）
            [self setSecureTextEntry:YES];
            //...
            break;
            
            
            // 验证码
        case TEXTFIELD_TYPE_SMCODE:
            
            [self setKeyboardType:UIKeyboardTypeNumberPad];
            //...
            break;
            
            
            // 金额
        case TEXTFIELD_TYPE_PAYBOX:
            
            [self setKeyboardType:UIKeyboardTypeDecimalPad];
            //...
            break;
            
            
            // 身份证
        case TEXTFIELD_TYPE_IDCARD:
            
            [self setKeyboardType:UIKeyboardTypeNamePhonePad];//身份证键盘
            //...
            break;
            
            
            // 银行卡
        case TEXTFIELD_TYPE_BANKRD:
            
            [self setKeyboardType:UIKeyboardTypeNumberPad];
            //...
            break;
            
            
            // 手机号
        case TEXTFIELD_TYPE_PHONE:
            
            [self setKeyboardType:UIKeyboardTypeNumberPad];
            //...
            break;
            
            
            // 邮箱
        case TEXTFIELD_TYPE_EMAIL:
            
            [self setKeyboardType:UIKeyboardTypeEmailAddress];
            //...
            break;
            
            
            // 信用卡有效期
        case TEXTFIELD_TYPE_CREDIT:
            
            [self setKeyboardType:UIKeyboardTypeNumberPad];
            //...
            break;
            
            
            // 信用卡安全码
        case TEXTFIELD_TYPE_CRED_S:
            
            [self setKeyboardType:UIKeyboardTypeNumberPad];
            //...
            break;
            
            
        default:
            break;
    }
}


// 重写父类的输入长度限制方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    // 监听每一个输入框
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    BOOL bChange = YES;
    NSString *txt = textField.text;
    NSInteger length = txt.length;
    
    // 限制长度的临时值
    NSInteger num = 0;

    switch (self.textFiled_Type) {
            
            // 用户名输入框 的限制
        case TEXTFIELD_TYPE_LOGIN_U:
            
            num = K_LOGIN_U_LENGTH;
 
            //...
            break;
            
            
            // 用户登录密码框 的限制
        case TEXTFIELD_TYPE_LOGIN_P:
            
            num = K_LOGIN_P_LENGTH;
            //...
            break;
            
            
            // 验证码 输入框的限制
        case TEXTFIELD_TYPE_SMCODE:
            
            num = K_SMCODE_LENGTH;
     
            //...
            break;
            
            
            // 金额 输入框的限制
        case TEXTFIELD_TYPE_PAYBOX:
            
            num = K_PAYBOX_LENGTH;
            
            //...
            break;
            
            
            // 身份证 输入框的限制
        case TEXTFIELD_TYPE_IDCARD:
            
            num = K_IDCARD_LENGTH;

            //...
            break;
            
            
            // 银行卡 输入框的限制
        case TEXTFIELD_TYPE_BANKRD:
            
            num = K_BANKRD_LENGTH;
            //...
            break;
            
            
            // 手机号 输入框的限制
        case TEXTFIELD_TYPE_PHONE:
            
            num = K_PHONE_LENGTH;
            //...
            break;
            
            
            // 邮箱 输入框的限制
        case TEXTFIELD_TYPE_EMAIL:
            
            num = K_EMAIL_LENGTH;
            //...
            break;
            
            
            // 信用卡有效期 输入框的限制
        case TEXTFIELD_TYPE_CREDIT:
            
            num = K_CREDIT_LENGTH;
            //...
            break;
            
            
            // 信用卡安全码 输入框的限制
        case TEXTFIELD_TYPE_CRED_S:
            
            num = K_CREDIT_S_LENGTH;
            //...
            break;
            
            
        default:
            break;
    }
    
    // 开始限制长度
    if (length >= num) {
        bChange = NO;
    }
    if (range.length == 1) {
        bChange = YES;
    }
    return bChange;

}


// 对输入框输入一位的监听 (内部实现)
-(void)textFieldDidChange :(UITextField *)textFiled {

    // 禁止输入空格
    NSString *txt = textFiled.text;
    txt =  [txt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    textFiled.text = txt;
    NSInteger length = txt.length;
    
    // 为回调赋值
    if (!self.tempBlock) {
        
        self.tempBlock = ^(UITextField *TF,NSString * TF_STR){
            
            TF = textFiled;
            TF_STR = textFiled.text;
        };
    }

    self.tempBlock(textFiled,textFiled.text);
    
    
    // 实现定制方法
    switch (textFiled.textFiled_Type) {

            // 金额 输入框的限制
        case TEXTFIELD_TYPE_PAYBOX:
            
            // 金额输入框定制约束
            [self isBoxCanInputNumberBoolMethod];
            
            //...
            break;
            
            
            // 身份证 输入框的限制
        case TEXTFIELD_TYPE_IDCARD:
            
            // 转化大写X
            if (length == K_IDCARD_LENGTH) {
                NSString *temp = [txt substringFromIndex:length-1];
                if ([temp isEqualToString:@"x"]) {
                    txt = [txt stringByReplacingOccurrencesOfString:@"x" withString:@"X"];
                    textFiled.text = txt;
                }
            }
            //...
            break;
            
        default:
            break;
    }

}


#pragma amrk—————————————— 提醒框轮询校验

// 按照次序对输入框做轮询校验
- (BOOL)pollingCheckTextFiled:(NSArray*)tf_Ary isHaveBox:(ISHAVE_BOX_TYPE) ishave_box_Type haveBoxTitles:(NSArray*)wars_Ary nullWarTitles:(NSArray*)null_Ary withBoxType:(WARING_BOX_TYPE)war_Type keepara:(NSString*) keepar{
    
    
    if ( 0 == [tf_Ary count]) {
        
        // 既然无 TF，就禁止下一步操作
        return NO;
    }
    
    // 挨个轮询
    for (int i = 0; i < [tf_Ary count]; i++) {
        
        UITextField *textFiled = tf_Ary[i];
        
        // 注意：这类一定要是 textFiled 对象去调用，否则空输入的提示可能错乱（空输入提示一律使用黑框提示）
        BOOL is_ok = [textFiled CheckOneTextFiled:textFiled isHaveBox:ishave_box_Type haveBoxTitle:wars_Ary[i] nullWarTitle:null_Ary[i] withWarBoxType:war_Type keepara:keepar];
        
        if (!is_ok) {
            
            return NO;
        }
        
    }
    
    // 轮询结束，可以继续
    return YES;
    
}


// 轮询函数 (轮询入口)
- (BOOL)CheckOneTextFiled:(UITextField *)textFiled isHaveBox:(ISHAVE_BOX_TYPE) ishave_box_Type haveBoxTitle:(NSString*)warStr nullWarTitle:(NSString*)nilWarStr withWarBoxType:(WARING_BOX_TYPE)war_Type keepara:(NSString*) keepar{
    
    // 设置是否有提示框
    if ( ISHAVE_BOX_TYPE_YES != ishave_box_Type) {
        
        ishave_box_Type = ISHAVE_BOX_TYPE_NO;
    }
    
    // 设置
    
    BOOL isTrue = NO;
    
    switch (textFiled.textFiled_Type) {

            // 用户名输入框
        case TEXTFIELD_TYPE_LOGIN_U:
            
            // 校验 + 选择提示方法，并选择是否提示，如何提示
            isTrue = [textFiled regularUserNameLegal:textFiled isHaveBox:ishave_box_Type keepara:keepar];
            return [textFiled checkedValue:isTrue ishaveboxType:ishave_box_Type warType:war_Type title:warStr nullWarTitle:nilWarStr keepara:keepar];
            
            //...
            break;
            
            
            // 用户登录密码框
        case TEXTFIELD_TYPE_LOGIN_P:
            
            isTrue = [textFiled regularLoginPsword:textFiled isHaveBox:ishave_box_Type keepara:keepar];
            return [textFiled checkedValue:isTrue ishaveboxType:ishave_box_Type warType:war_Type title:warStr nullWarTitle:nilWarStr keepara:keepar];
            //...
            break;
            
            
            // 验证码
        case TEXTFIELD_TYPE_SMCODE:
            
            isTrue = [textFiled regularSmsCode:textFiled isHaveBox:ishave_box_Type keepara:keepar];
            return [textFiled checkedValue:isTrue ishaveboxType:ishave_box_Type warType:war_Type title:warStr nullWarTitle:nilWarStr keepara:keepar];
            //...
            break;
            
            
            // 金额
        case TEXTFIELD_TYPE_PAYBOX:
            
            
            isTrue = [textFiled regularMoneyLegal:textFiled isHaveBox:ishave_box_Type keepara:keepar];
            return [textFiled checkedValue:isTrue ishaveboxType:ishave_box_Type warType:war_Type title:warStr nullWarTitle:nilWarStr keepara:keepar];
     
            //...
            break;
            
            
            // 身份证
        case TEXTFIELD_TYPE_IDCARD:
            
            isTrue = [textFiled regularIdCardNum:textFiled isHaveBox:ishave_box_Type keepara:keepar];
            return [textFiled checkedValue:isTrue ishaveboxType:ishave_box_Type warType:war_Type title:warStr nullWarTitle:nilWarStr keepara:keepar];
            //...
            break;
            
            
            // 银行卡
        case TEXTFIELD_TYPE_BANKRD:
            
            isTrue = [textFiled checkCardNo:textFiled isHaveBox:ishave_box_Type keepara:keepar];
            return [textFiled checkedValue:isTrue ishaveboxType:ishave_box_Type warType:war_Type title:warStr nullWarTitle:nilWarStr keepara:keepar];
            //...
            break;
            
            
            // 手机号
        case TEXTFIELD_TYPE_PHONE:
            
            isTrue = [textFiled regularPhoneNoLegal:textFiled isHaveBox:ishave_box_Type keepara:keepar];
            return [textFiled checkedValue:isTrue ishaveboxType:ishave_box_Type warType:war_Type title:warStr nullWarTitle:nilWarStr keepara:keepar];
            //...
            break;
            
            
            // 邮箱
        case TEXTFIELD_TYPE_EMAIL:
            
            isTrue = [textFiled regularE_Mail:textFiled isHaveBox:ishave_box_Type keepara:keepar];
            return [textFiled checkedValue:isTrue ishaveboxType:ishave_box_Type warType:war_Type title:warStr nullWarTitle:nilWarStr keepara:keepar];
            //...
            break;
            
            
            // 信用卡有效期
        case TEXTFIELD_TYPE_CREDIT:
            
            isTrue = [textFiled regularInTimeLegal:textFiled isHaveBox:ishave_box_Type keepara:keepar];
            return [textFiled checkedValue:isTrue ishaveboxType:ishave_box_Type warType:war_Type title:warStr nullWarTitle:nilWarStr keepara:keepar];
            //...
            break;
            
            
            // 信用卡安全码
        case TEXTFIELD_TYPE_CRED_S:
            
            isTrue = [textFiled regularSafeCodeNum:textFiled isHaveBox:ishave_box_Type keepara:keepar];
            return [textFiled checkedValue:isTrue ishaveboxType:ishave_box_Type warType:war_Type title:warStr nullWarTitle:nilWarStr keepara:keepar];
            //...
            break;
            
            
        default:
            break;
    }
    
    return YES;
}



// 选择提示框的复用函数 01（确定分流，自动选择）
- (BOOL)checkedValue:(BOOL)isTrue  ishaveboxType:(ISHAVE_BOX_TYPE) ishavebox_Type warType:(WARING_BOX_TYPE)war_Type title:(NSString*)warStr nullWarTitle:(NSString*)nilWarStr keepara:(NSString*) keepar{
    
    
    if ( ISHAVE_BOX_TYPE_NO == ishavebox_Type) {
        
        // 不提示 + 已经默默校验
        
        
        return [self checkedValue:isTrue title:warStr keepara:keepar];
    }
    
    if ( ISHAVE_BOX_TYPE_YES == ishavebox_Type ) {
        
        // 提示 + 已经校验
        
        return [self checkedTF_alseWarBox:isTrue warType:war_Type title:warStr nullWarTitle:nilWarStr keepara:keepar];
    }
    
    return isTrue;
}



// 选择提示框的复用函数 01.1（ 确定：已经默默校验 ）
- (BOOL)checkedValue:(BOOL)isTrue title:(NSString*)warStr  keepara:(NSString*) keepar{
    
    //... other (可定制仅仅对空输入进行提示)
    
    return isTrue;
    
}


// 选择提示框的复用函数 01.2（ 确定：已经校验 + 提示校验的结果 ）
- (BOOL)checkedTF_alseWarBox:(BOOL)isTrue  warType:(WARING_BOX_TYPE)war_Type title:(NSString*)warStr nullWarTitle:(NSString*)nilWarStr keepara:(NSString*) keepar{
    
    //...other
    
    // 如果合法不要提示
    if ( YES == isTrue ) {
        
        return isTrue;
    }
    
    // 如果不合法，就提示
    if ( NO == isTrue ) {
        
        // 如果输入为空
        if (0 == [self.text length]) {
            
            warStr = @"";
            warStr = nilWarStr;
        }
        
        [self selectWarType:war_Type title:warStr keepara:keepar];
        
        return isTrue;
    }
    
    return isTrue;
}



// 选择提示框的复用函数 01.2.1 （ 基于 01.2 的基础上 选择：提示效果 ）
- (void)selectWarType:(WARING_BOX_TYPE)war_Type title:(NSString*)warStr  keepara:(NSString*) keepar{
    
    // 强制转化提示框类型（优化黑框提示可能被键盘遮挡的问题）
    if (K_IS_IPHONE_4) {
        
         [self selectSystemWarBoxWithTitle:warStr keepara:keepar];
        
    }else{
        
        //..... 非iPhone4S 使用定制提示
        
        // 系统提示
        if ( WARING_BOX_TYPE_DEFAULT == war_Type ) {
            
            [self selectSystemWarBoxWithTitle:warStr keepara:keepar];
        }
        
        // 黑框提示
        if ( WARING_BOX_TYPE_BLACKBX == war_Type ) {
            
            [self selectBlackWarBoxWithTitle:warStr keepara:keepar];
        }
        
        // 多按钮实现定制提示
        if ( WARING_BOX_TYPE_JWDGBOX == war_Type ) {
            
            [self selectMulityUserBtonWarBoxWithTitle:warStr keepara:keepar];
        }
    }
    
}

#define K_TILTLE  @"提示"
#define K_MESSAG  @"不能输入为空"
#define K_CANCLE  @"取消"
#define K_YES     @"好"
#define K_SURE    @"确定"
#define K_CLOSE   @"关闭"

// 选择提示框的复用函数 01.2.1.1 （ 基于 01.2.1 的基础上 选择：系统 提示效果 ）
- (void)selectSystemWarBoxWithTitle:(NSString*)warStr  keepara:(NSString*) keepar{
    
    ALT_SHOW(K_TILTLE, warStr, K_CLOSE);

}

// 选择提示框的复用函数 01.2.1.2 （ 基于 01.2.1 的基础上 选择：黑框 提示效果 ）
- (void)selectBlackWarBoxWithTitle:(NSString*)warStr  keepara:(NSString*) keepar{
  
    // 使用霸屏
    [[AutoAttentionView sharedInstance] autoShowAttentionWith:warStr andWith:AX_KEY_WINDOW];

}

// 选择提示框的复用函数 01.2.1.3 （ 基于 01.2.1 的基础上 选择：自定义多按钮按钮事件 提示效果 ）<16-09-14 暂时不实现，略微复杂>
- (void)selectMulityUserBtonWarBoxWithTitle:(NSString*)warStr  keepara:(NSString*) keepar{
    
    ZLAlertDialog *alter = [[ZLAlertDialog alloc] initWithTitle:K_TILTLE message:warStr];
    [alter addButton:Button_OTHER withTitle:@"清除" handler:^(ZLAlertDialogItem *item) {
        
        self.text = @"";
    }];
    [alter addButton:Button_OK withTitle:K_CLOSE handler:nil];
    [alter show];
    
}







#pragma amrk—————————————— 输入框的正则校验 ——————————————

#pragma mark——————   判断银行卡卡号输入的合法性

- (BOOL) checkCardNo:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) type keepara:(NSString*) keepar{
    
    NSString *cardNo = textFiled.text;
    
    int oddsum = 0;
    int evensum = 0;
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}


#pragma mark———————— (正则)检查电话号码是否可用

- (BOOL)regularPhoneNoLegal:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) type keepara:(NSString*) keepar{
    
    NSString *phoneNo = textFiled.text;
    
    if (nil == phoneNo) {
        return NO;
    }
    
    // 说明：为什么不用下面的实现呢？因为客户端不能跟上通讯运营商的更新号段的步伐，导致可能的客户流失（除非使用了热更新代码后，可以考虑使用下面的方法）
    //    /* 手机号码
    //     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
    //     * 联通：130,131,132,152,155,156,185,186
    //     * 电信：133,1349,153,180,189
    //     */
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";//增加了一个3
    //    /**
    //     10         * 中国移动：China Mobile
    //     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
    //     12         */
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //    /**
    //     15         * 中国联通：China Unicom
    //     16         * 130,131,132,152,155,156,185,186
    //     17         */
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //    /**
    //     20         * 中国电信：China Telecom
    //     21         * 133,1349,153,180,189
    //     22         */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    //    /**
    //     25         * 大陆地区固话及小灵通
    //     26         * 区号：010,020,021,022,023,024,025,027,028,029
    //     27         * 号码：七位或八位
    //     28         */
    //    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //
    //    if (([regextestmobile evaluateWithObject:phoneNo] == YES)
    //        || ([regextestcm evaluateWithObject:phoneNo] == YES)
    //        || ([regextestct evaluateWithObject:phoneNo] == YES)
    //        || ([regextestcu evaluateWithObject:phoneNo] == YES))
    //    {
    //        return YES;
    //    }
    //    else
    //    {
    //        //2016年06月30日，修正功能，对手机号不做号段判定、仅作手机号位数是11位的判定
    //        //这里强制将原来对手机号进行格式判断，舍弃
    ////        return NO;
    //        return YES;
    //    }
    
    //2016年06月30日，修正功能，对手机号不做号段判定、仅作手机号首位是1、其余位数是数字的判定
    NSString *newRegular = @"^1\\d{10}$";
    NSPredicate *regularMobile =  [NSPredicate predicateWithFormat:@"SELF MATCHES %@", newRegular];
    if ([regularMobile evaluateWithObject:phoneNo] == YES) {
        
        return  YES;
        
    }else{
        
        return NO;
    }
}


#pragma mark————————（正则）邮箱的验证

- (BOOL) regularE_Mail:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) type keepara:(NSString*) keepar{
    
    NSString *e_mail = textFiled.text;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:e_mail];
    
}


#pragma mark———————— (正则)用户密码验证

- (BOOL)regularLoginPsword:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) type keepara:(NSString*) keepar{
   
    NSString* passWord = textFiled.text;
    
    BOOL result = false;
    if ([passWord length] >= 6){
        //下面是按照标准的ASCII符号特殊字符集（保证任何手机都有）
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,24}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:passWord];
        
        // 此处暂不返回提示信息
        return result;
    }
    
    NSMutableArray *unSafeStr = [NSMutableArray array];
    if (!result) {
        //如果某一个不存在的话，单独调处来
        for(int i =0; i < [passWord length]; i++)
        {
            NSString *temp = [passWord substringWithRange:NSMakeRange(i, 1)];
            BOOL isOk;
            NSString * regex = @"^(?![0-9]+$)|(?![a-zA-Z]+$)|[0-9A-Za-z-\\[\\]~`!@#$%^&*()_+=|}{:;'/?<>,.\"\\\\]{1,16}$";
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            isOk = [pred evaluateWithObject:temp];
            if (!isOk) {
                if ([temp isEqualToString:@" "]) {
                    temp = @"空格";
                }
                [unSafeStr addObject:temp];
                //NSLog(@"——找到的错误是%@",unSafeStr);
            }
        }
    }
    if (0!=unSafeStr.count) {
        NSSet *set = [NSSet setWithArray:unSafeStr];
        [unSafeStr removeAllObjects];
        for (NSString *obj in set) {
            [unSafeStr addObject:obj];
        }
        // NSLog(@"数组是 %@",unSafeStr);
        NSString *tishi = @"检测密码不能包含非法字符：";
        for (int i = 0; i<unSafeStr.count; i++) {
            NSString *temp = unSafeStr[i];
            temp =  [temp stringByAppendingString:@"、"];
            tishi = [tishi stringByAppendingString:temp];
        }
        tishi = [tishi substringWithRange:NSMakeRange(0, tishi.length - 1)];
        //全局的提示框提示内容...这里可是显示一下
        NSLog(@"————————————%@",tishi);
    }
    
    return result;

}

#pragma mark———————— (正则)用户账号验证

- (BOOL)regularUserNameLegal:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) type keepara:(NSString*) keepar{

    NSString *userName = textFiled.text;

    BOOL result = false;
    if ([userName length] >= 6){
        // 判断长度不小于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)|(?![a-zA-Z]+$)|[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:userName];
    }
    return result;
}


#pragma mark———————— (正则)用户验证码验证

- (BOOL)regularSmsCode:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) type keepara:(NSString*) keepar{
    
    NSString *smsCodeStr  = textFiled.text;
    
    BOOL result = false;
    if ( 6 == [smsCodeStr length]){
        //判断是不是6位数的验证码（0-9数字）
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(\\d){6}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:smsCodeStr];
    }
    return result;
}


#pragma mark———————— (正则)身份证号15位18位验证

//判断身份证号是否位数够 （YES 位数够  18 或 15 位）
- (BOOL)regularIdCardNum:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) type keepara:(NSString*) keepar{
    
    NSString*idCardNum = textFiled.text;
    
    BOOL result = false;
    NSString *regex = @"^(\\d){14}[0-9z-zA-Z]|(\\d){17}[0-9a-zA-Z]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    result = [pred evaluateWithObject:idCardNum];
    //如果是18位身份证号，就要验证其合法性
    if (idCardNum.length == 18) {
        result = [self idCard_18_method:idCardNum];
    }
    if (idCardNum.length == 15) {
        //暂无算法
    }
    return result;
}

//idCard_18 校验算法
- (BOOL)idCard_18_method:(NSString*)idcardStr{
    BOOL isYes;
    isYes = NO;
    //分别得到身份证的各个位数，存入数组中
    int s = 0;//加权求和值
    int y = 0;//计算模值
    int wi[17] = {7 ,9 ,10 ,5 ,8 ,4 ,2 ,1 ,6 ,3 ,7 ,9 ,10 ,5 ,8 ,4 ,2 };//加权因子
    NSString *l = [idcardStr substringWithRange:NSMakeRange(idcardStr.length - 1, 1)];
    //加权和
    for (int i = 0; i < idcardStr.length - 1; i++) {
        NSString *num = [idcardStr substringWithRange:NSMakeRange(i, 1)];
        //转化为数字
        int b = [num intValue];
        s += b*wi[i];
    }
    //计算模
    y = s%11;
    //匹配校验码数组
    int Y[11] = {0 ,1 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10 };
    char YY[11] = {'1','0', 'X', '9','8', '7', '6', '5', '4', '3', '2'};
    //匹配方法
    for (int k = 0; k < 11; k++) {
        if (y == Y[k]) {
            if ([[NSString stringWithFormat:@"%c",YY[k]] isEqualToString:l]) {
                isYes = YES;
            }
        }
    }
    return isYes;
}


#pragma mark———————— (正则)用户输入金额验证
#define K_BANINPUT  @"限制金额的最后一位非小数点"
// 金额验证第一步：（对小数点输入限制,且小数点后只能是两位数字）
-(BOOL)isBoxCanInputNumberBoolMethod{
    //判断如果输入一个小数点，后面只能输入两个数字多的输不了，如果输入小数点也不行
    NSString *tempstr = self.text;
    size_t length = [tempstr length];
    int count_point = 0;//小数点的个数
    BOOL isPoint_ok = YES ;//小数点的检测
    for (size_t i=0; i < length; i++) {
        unichar c = [tempstr characterAtIndex:i];
        //是否是小数
        if (c == 0x2E ) {
            // 自动补0
            if ( 0 == i) {
                NSString *tempzero = @"0";
                self.text = [tempzero stringByAppendingString:self.text];
            }
            count_point++;
            //小数点后禁止输入小数点
            if ( 2 == count_point) {
                self.text = [tempstr substringWithRange:NSMakeRange(0, length - 1)];
                isPoint_ok = NO;//禁止输入第二个小数点
            }else{
                isPoint_ok = YES;//只有一个小数点的时候，可以输入
            }
            //小数位多于2位禁止输入
            if ( 2 <= (length-1 -i)) {
                isPoint_ok = NO;
                self.text = [tempstr substringWithRange:NSMakeRange(0, i+ 3)];
            }else{
                isPoint_ok = YES;
            }
            //最后一位禁止输入小数点
            if ( i == (K_PAYBOX_LENGTH -1)) {
                // 非iphone4s手机使用黑框提示
                if (K_IS_IPHONE_4) {
                    
                    ALT_SHOW(K_TILTLE, K_BANINPUT, K_SURE)
                }else{
                    
                    [[AutoAttentionView sharedInstance] autoShowAttentionWith:K_BANINPUT andWith:AX_KEY_WINDOW];
                }
                self.text = [tempstr substringToIndex:i];
            }
            //在输入框是否能输入的设置地方，只有 isPoint_ok = yes,才能输入否则禁止输入
        }
        //0后面只能输入小数点，如果不是小数点，就禁止输入
        if ([tempstr characterAtIndex:0] == 48) {
            if ([tempstr length] > 1) {//对第二个字符开始判断
                if ([tempstr characterAtIndex:1] >= 48) {
                    self.text = [self.text substringWithRange:NSMakeRange(0, length - 1)];
                    isPoint_ok = NO;//两个0，不可以输入
                }
            }
        }
    }
    
    if (isPoint_ok) {
        NSLog(@" \n\n【金额输入框小数点限制】 （当前可以输入）您已经输入了 %@\n",self.text);
    }else{
        NSLog(@" \n\n【金额输入框小数点限制】 （当前禁止输入）您已经输入了 %@\n",self.text);
    }
    
    return  isPoint_ok;
}


//是否是正确的金额（注意在第一步的验证基础上进行正则验证）
- (BOOL)regularMoneyLegal:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) type keepara:(NSString*) keepar{
    
    NSString *money = textFiled.text;
    
    BOOL result = false;
    if ([money length] > 0){
        // 判断是否是整数或者有不超过两位的小数
        NSString * regex = @"^(([0-9]|([1-9][0-9]{0,9}))((\\.[0-9]{1,2})?))$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:money];
    }
    return result;
}


#pragma mark———————— (正则)信用卡有安全码验证

- (BOOL)regularSafeCodeNum:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) type keepara:(NSString*) keepar{
    
    NSString*safeCodeNum = textFiled.text;
    
    BOOL result = false;
    if ([safeCodeNum length] == 3) {
        //判断信用卡是否位数够 （YES 位数 3 位）
        NSString *regex = @"^[0-9]{3}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        result = [pred evaluateWithObject:safeCodeNum];
    }
    return result;
}

#pragma mark———————— (正则)信用卡有效期验证

- (BOOL)regularInTimeLegal:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) type keepara:(NSString*) keepar{
    
    NSString *timeNum = textFiled.text;
    
    BOOL result = false;
    if ([timeNum length] == 4) {
        //是否是正确的有效期 （YES 位数 4 位）
        NSString *regex =@"^[0-9]{4}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        result = [pred evaluateWithObject:timeNum];
    }
    
    return result;
}



@end

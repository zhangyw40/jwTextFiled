//
//  UITextField+Addtion.h
//  HuJIn
//
//  Created by Mac_NJW on 16/9/13.
//  Copyright © 2016年 Mac_NJW. All rights reserved.
//

#import <UIKit/UIKit.h>

// 用户名长度 限制
#define K_LOGIN_U_LENGTH  16

// 登录密码长度 限制
#define K_LOGIN_P_LENGTH  16

 //验证码长度 限制
#define K_SMCODE_LENGTH    6

 //金额长度 限制
#define K_PAYBOX_LENGTH   12

 //身份证长度 限制
#define K_IDCARD_LENGTH   18

 //银行卡长度 限制
#define K_BANKRD_LENGTH   20

 //手机号长度 限制
#define K_PHONE_LENGTH    11

 //邮箱长度 限制
#define K_EMAIL_LENGTH    30

 //信用卡有效期 限制
#define K_CREDIT_LENGTH    4

 //信用卡的安全码 限制
#define K_CREDIT_S_LENGTH    3


// 输入框的类别设计
typedef NS_ENUM(NSInteger,TEXTFIELD_TYPE) {
    
    TEXTFIELD_TYPE_LOGIN_U,//登录用户名输入框
    TEXTFIELD_TYPE_LOGIN_P,//登录密码输入框
    TEXTFIELD_TYPE_SMCODE, //验证码输入框
    TEXTFIELD_TYPE_PAYBOX, //金额框
    TEXTFIELD_TYPE_IDCARD, //身份证输入框
    TEXTFIELD_TYPE_BANKRD, //银行卡输入框
    TEXTFIELD_TYPE_PHONE,  //手机号输入框
    TEXTFIELD_TYPE_EMAIL,  //邮箱输入框
    TEXTFIELD_TYPE_CREDIT, //信用卡有效期输入框
    TEXTFIELD_TYPE_CRED_S, //信用卡安全码输入框
    
};


// 提示的样式设计
typedef NS_ENUM(NSInteger,WARING_BOX_TYPE) {
    
    WARING_BOX_TYPE_DEFAULT, // iOS 系统提示框 （默认）
    WARING_BOX_TYPE_BLACKBX, // 自定义黑框提示
    WARING_BOX_TYPE_JWDGBOX, // 自定义的带有定制按钮提示框
    
};


// 是否进行提示，还是默默限制
typedef NS_ENUM(NSInteger,ISHAVE_BOX_TYPE) {
    
    ISHAVE_BOX_TYPE_NO,  // 无提示框（默认）
    ISHAVE_BOX_TYPE_YES, // 有提示框
    
};


// 回调（输入n个字之后的响应操作，比如改变页面的偏移量等）
typedef void(^AfterEnterBlock)(UITextField *TF,NSString *TF_STR);

@interface UITextField (Addtion)

// 动态属性 (输入框类型)
@property (nonatomic,assign) TEXTFIELD_TYPE textFiled_Type;

// 动态属性 （回调块）
@property (nonatomic,copy)AfterEnterBlock tempBlock;

// 内部实现对不同输入框的长度的限制 (外部调用设置)
- (void)setTextFiledType:(TEXTFIELD_TYPE)type;

/**
 *  轮询检验方法
 *
 *  @param tf_Ary          按照放入 tf 顺序校验（数组）
 *  @param ishave_box_Type 是否提示（枚举）
 *  @param wars_Ary        校验失败提示语 （数组）
 *  @param null_Ary        空输入提示语 （数组）
 *  @param war_Type        提示类型 （枚举）
 *  @param keepar          保留参数 （字符串，暂未作用）
 *
 *  @return 所有校验结果
 */
- (BOOL)pollingCheckTextFiled:(NSArray*)tf_Ary isHaveBox:(ISHAVE_BOX_TYPE) ishave_box_Type haveBoxTitles:(NSArray*)wars_Ary nullWarTitles:(NSArray*)null_Ary withBoxType:(WARING_BOX_TYPE)war_Type keepara:(NSString*) keepar;





/**
 *  扩充方法，一般用不上（暂时未实现,先注释掉，后期修订）
 *
 */
#pragma mark—————————— 方便外部进行的正则校验 (一般不用)
/*
//登录用户名 校验
- (BOOL)regularUserNameLegal:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) box_Type haveBoxTitles:(NSArray*)wars_Ary withBoxType:(WARING_BOX_TYPE)war_Type keepara:(NSString*) keepar;

//登录密码 校验
- (BOOL)regularLoginPsword:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) box_Type haveBoxTitles:(NSArray*)wars_Ary withBoxType:(WARING_BOX_TYPE)war_Type keepara:(NSString*) keepar;

//验证码 校验
- (BOOL)regularSmsCode:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) box_Type haveBoxTitles:(NSArray*)wars_Ary withBoxType:(WARING_BOX_TYPE)war_Type keepara:(NSString*) keepar;

//金额 校验
- (BOOL)regularMoneyLegal:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) box_Type haveBoxTitles:(NSArray*)wars_Ary withBoxType:(WARING_BOX_TYPE)war_Type keepara:(NSString*) keepar;

//身份证 校验
- (BOOL)regularIdCardNum:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) box_Type haveBoxTitles:(NSArray*)wars_Ary withBoxType:(WARING_BOX_TYPE)war_Type keepara:(NSString*) keepar;

//银行卡 校验
- (BOOL) checkCardNo:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) box_Type haveBoxTitles:(NSArray*)wars_Ary withBoxType:(WARING_BOX_TYPE)war_Type keepara:(NSString*) keepar;

//手机号 校验
- (BOOL)regularPhoneNoLegal:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) box_Type haveBoxTitles:(NSArray*)wars_Ary withBoxType:(WARING_BOX_TYPE)war_Type keepara:(NSString*) keepar;

//邮箱 校验
- (BOOL) regularE_Mail:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) box_Type haveBoxTitles:(NSArray*)wars_Ary withBoxType:(WARING_BOX_TYPE)war_Type keepara:(NSString*) keepar;

//信用卡有效期 校验
- (BOOL)regularInTimeLegal:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) box_Type haveBoxTitles:(NSArray*)wars_Ary withBoxType:(WARING_BOX_TYPE)war_Type keepara:(NSString*) keepar;

//信用卡安全码 校验
- (BOOL)regularSafeCodeNum:(UITextField*) textFiled isHaveBox:(ISHAVE_BOX_TYPE) box_Type haveBoxTitles:(NSArray*)wars_Ary withBoxType:(WARING_BOX_TYPE)war_Type keepara:(NSString*) keepar;

*/

@end



/**
 *  该次扩展类方法说明：
 （1）、该次封装能够在必要的时候，对信息进行页面的及时提示效果，使用了类中 自动提示框，采用了霸屏的提示方案。
  (2)、使用runtime技术在categories 类中实现动态的添加属性
  (3)、所有输入框的验证都在该内部实现
  (4)、如果以后有新的需求，就继续扩充： 宏，扩充：case 的条件
  (5)、同时提供外部正则校验的方法，该方法能够定制提示文案(该方法会按照顺序对 tf 数组挨个轮询，并且能够按照要求进行提示 )
 （6）、为了提高逻辑的清新与可读性，暂时不对，内部实现的 switch 块进行抽象
 */




/**
 *  使用说明 demo:
 // 测试输入框的输入约束效果
 UITextField * tf_1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, K_WIDTH, 30)];
 [self.view addSubview:tf_1];
 tf_1.backgroundColor = [UIColor cyanColor];
 [tf_1 setDelegate:(id)tf_1];
 
 tf_1.tempBlock = ^(UITextField *TF, NSString *TF_STR) {
 NSLog(@"及时得到当前输入框的内容=========== %@ ",TF_STR);
 
 if ([TF_STR length] > 6) {
 
 [TF setBackgroundColor:[UIColor redColor]];
 }else{
 [TF setBackgroundColor:[UIColor cyanColor]];
 }
 };
 [tf_1 setTextFiledType:TEXTFIELD_TYPE_PAYBOX];//(金额 16)
 */









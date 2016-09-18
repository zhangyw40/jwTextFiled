//
//  AddBankCardViewController.m
//  HuJIn
//
//  Created by Mac_NJW on 16/9/18.
//  Copyright © 2016年 Mac_NJW. All rights reserved.
//

// 校验错误
#define K_ERROR_HOLDNAME  @"持卡人姓名输入错误！"
#define K_ERROR_IDCARD    @"身份证号码格式不正确！"
#define K_ERROR_BANKCARD  @"银行卡号格式不正确！"
#define K_ERROR_PHONENUM  @"手机号码格式不正确！"

// 校验位空
#define K_NULL_HOLDNAME  @"持卡人姓名不能为空！"
#define K_NULL_IDCARD    @"身份证号码不能为空！"
#define K_NULL_BANKCARD  @"银行卡号不能为空！"
#define K_NULL_PHONENUM  @"银行预留手机号不能为空！"


#import "AddBankCardViewController.h"
#import "UITextField+Addtion.h"

@interface AddBankCardViewController ()
{
    NSArray *_tfAry;
}
@end

@implementation AddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithUi];
    
}

- (void)initWithUi{
    
    [self setTitle:@"绑定银行卡"];
    
    // 及时监听输入内容
     _tfAry = @[_hold_Name_TF,_idCard_TF,_bankCardNo_TF,_phone_TF];
    // 设置类型
    [_hold_Name_TF jwTextFiledType:TEXTFIELD_TYPE_LOGIN_U];
    [_idCard_TF jwTextFiledType:TEXTFIELD_TYPE_IDCARD];
    [_bankCardNo_TF jwTextFiledType:TEXTFIELD_TYPE_BANKRD];
    [_phone_TF jwTextFiledType:TEXTFIELD_TYPE_PHONE];
    
    
    for (UITextField *textFiled in _tfAry) {
        // 及时监听
        textFiled.tempBlock = ^(UITextField *TF,NSString *TF_STR){
          
            NSLog(@"\n\n 及时检测到您输入的内容为 %@",TF_STR);
            if (TF.textFiled_Type == TEXTFIELD_TYPE_IDCARD) {
                
                NSLog(@"\n\n 系统检测到您正在输入身份证号码！\n");
            }
        };
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark——————— 下一步按钮点击事件
- (IBAction)nextBtnClickAct:(UIButton *)sender {
    
    // 轮询校验
    _tfAry = @[_hold_Name_TF,_idCard_TF,_bankCardNo_TF,_phone_TF];
    NSArray *_errorAry = @[K_ERROR_HOLDNAME,K_ERROR_IDCARD,K_ERROR_BANKCARD,K_ERROR_PHONENUM];
    NSArray *_nilAry = @[K_NULL_HOLDNAME,K_NULL_IDCARD,K_NULL_BANKCARD,K_NULL_PHONENUM];
    BOOL is_ok = [_hold_Name_TF pollingCheckTextFiled:_tfAry isHaveBox:ISHAVE_BOX_TYPE_YES haveBoxTitles:_errorAry nullWarTitles:_nilAry withBoxType:WARING_BOX_TYPE_BLACKBX keepara:@"YES"];// 如果是 @"YES" 就是开启错误定位
    if (is_ok) {
        
        NSLog(@"\n\n 所有输入合法，可以继续执行逻辑!\n");
    }else{
        
        NSLog(@"\n\n 检测到有不合法输入，不可以继续执行逻辑!\n");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

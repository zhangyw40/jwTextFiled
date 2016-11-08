//
//  ViewController.m
//  jwTextFiled
//
//  Created by JW_N on 16/9/16.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "jwTextFiled.h"
#import "AddBankCardViewController.h"

@interface ViewController ()<UITextFieldDelegate>
{
    NSArray *_tfs_ary,*_titles_Ary,*_niltfs_Ary;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化存放 tf 的数组
    _tfs_ary = @[_use_tf,_id_tf,_bankcard_tf,_pay_tf];
    // 校验提示文案数组
    _titles_Ary = @[@"用户名不符合要求",
                    @"请输入正确身份证号",
                    @"请输入正确银行卡号",
                    @"请输入正确金额",];
    // 空输入提示文案
    _niltfs_Ary = @[@"用户名不能为空",
                    @"身份证不能为空",
                    @"银行卡不能为空",
                    @"金额不能为空"];
    
    //设置约束样式
    [_use_tf jw_TextFiledType:TEXTFIELD_TYPE_LOGIN_U];
    [_id_tf jw_TextFiledType:TEXTFIELD_TYPE_IDCARD];
    [_bankcard_tf jw_TextFiledType:TEXTFIELD_TYPE_BANKRD];
    [_pay_tf jw_TextFiledType:TEXTFIELD_TYPE_PAYBOX];
    
    // 及时检测
    for (UITextField *TF in _tfs_ary) {
        
        TF.tempBlock = ^(UITextField *TF ,NSString *TF_STR){
            
            // 用户名
            if (TF == _use_tf) {
                
                NSLog(@"\n\n 用户名输入框，及时输入的检测是 %@\n",TF_STR);
                
            }
            // 身份证号
            if (TF == _id_tf) {
                
                NSLog(@"\n\n身份证输入框，及时输入的检测是 %@\n",TF_STR);
            }
        };
    }
    
}

// 点击空白处进行校验
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 轮询校验
    // 如果要开启定位功能，最后一个参数为 @"YES"
   BOOL is_ok = [_use_tf pollingCheckTextFiled:_tfs_ary
                                     isHaveBox:ISHAVE_BOX_TYPE_YES
                                 haveBoxTitles:_titles_Ary
                                 nullWarTitles:_niltfs_Ary
                                   withBoxType:WARING_BOX_TYPE_BLACKBX
                                       keepara:@"YES"];
    
    if (!is_ok) {
        NSLog(@"\n\n所有的输入框都校验通过\n");
        
        AddBankCardViewController *addbank = [AppDelegate receiveClassObjcParm1:@"AddBankCardViewController" parm2:K_ADD_BANKCARD_VC_ID];
        [self showDetailViewController:addbank sender:self];
        
    }else{
        NSLog(@"\n\n有输入框没有通过校验\n");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


//
//  AddBankCardViewController.h
//  HuJIn
//
//  Created by Mac_NJW on 16/9/18.
//  Copyright © 2016年 Mac_NJW. All rights reserved.
//

#import <UIKit/UIKit.h>

// 邦卡
#define K_ADD_BANKCARD_VC_ID  @"ADDBANKCARD"

@interface AddBankCardViewController : UIViewController

// 持卡人 TF
@property (weak, nonatomic) IBOutlet UITextField *hold_Name_TF;

// 身份证号 TF
@property (weak, nonatomic) IBOutlet UITextField *idCard_TF;

// 银行卡号 TF
@property (weak, nonatomic) IBOutlet UITextField *bankCardNo_TF;

// 预留手机号 TF
@property (weak, nonatomic) IBOutlet UITextField *phone_TF;

@end

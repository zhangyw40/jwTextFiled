# jwTextFiled 

jwTextFiled 简单实现以下功能：

0、在使用的地方仅仅 #import "jwTextFiled.h" 即可；博客说明使用场景请访问 http://www.jianshu.com/p/80ef2d47729d 。

1、支持输入框类型为：用户名，密码，验证码，交易金额，身份证，银行卡，手机号，邮箱，信用卡有效期，信用卡安全码输入框正则校验，根据需要你可以自行扩展修改，使用极少的代码实现对一个或者一组输入框的输入长度做输入限制，并能够对所有的输入框进行定制规则的校验。    

2、支持错误校验规则：详见代码内部正则注释。 

3、提示类型：不提示，默默校验；校验并且提示（支持系统提示，黑框提示，用户自定义提示） 

4、提示内容：通过函数传值，能够对校验失败，和输入框为空的时候进行提示。 

5、对输入框当前输入内容的回调，通过一次遍历，能够得到所有输入框及时的输入信息。  

6、封装倒计时控件，采用target-action设计思想很好的解决了多次重发的问题。

7、引入反馈页面使用的效果 UIPlaceholderTextView 文件。

8、自动获取输入框的内容，能够帮助你做一些你想做的事情：效果如下 code

    //如,短信验证码页面，初始化了jwTextFiled 设置后,当进入该页面后，自动获取验证码成功后，验证码输入框智能获取焦点，键盘出现，页面自动偏移，当输入够6位的时候，输入框取消焦点，键盘消失，页面回复原来位置。

    -(void)intelligentSwitchInputBox:(BOOL)isOpen{

    if (isOpen) {
        
        _smCode_TF.tempBlock = ^(UITextField *TF,NSString *TF_STR){
            
            if (TF == _smCode_TF) {// 验证码长度为6自动回收键盘
                
                if ( 6 == [TF_STR length] ) {
                    
                    [TF resignFirstResponder];
                    [_scrolview setContentOffset:CGPointMake(0, 0) animated:YES];
                    
                }else{
                    
                    [TF becomeFirstResponder];
                    [_scrolview setContentOffset:CGPointMake(0, 20 + 58) animated:YES];
                    
                }
            }
        };
        
    }
    }

9、改良自定义输入框辅助工具，新增自动获取用户输入焦点的方法，在VC中仅需一行代码，实现页面的输入框的智能切换焦点。{设计实现：如果输入长度达到最大长度就按照输入框的数组由上到下的去自动获取焦点，使用场景，多于三个输入框的页面}。
  实例代码：[_smCode_TF jw_AutoGetFocusTfAry:_tfAry start:0];

#注意：

***金额输入框输入规则：

1、首位输入小数点，自动前面补0。

2、只能输入一位小数点，若连续两次输入小数点，禁止第二个输入。

3、小数位只能有两位，多余输入自动禁止。

4、输入金额限制的最后一位的时候如果是小数点，就进行提示，并删除小数点。



***身份证输入框输入规则:

1、最多能输入18位。

2、如果最后以为是小写x,则自动转化为大写 X。

3、对18位长度的身份证号码做了组成身份证算法校验。


***手机号验证规则：
注意事项请看注释部分。

2016-09-20日新增CD

*** CD使用实例

在视图控制器中将 _cdView 写为私有变量。

在 ViewDidLoad 方法里初始化：

_cdView = [[CdVIew alloc] initWithFrame:CGRectMake(50, 50, 90, 40) addTarget:self action:@selector(changeCD:)];

[self.view addSubview:_cdView];

_cdView.layer.cornerRadius = 10;

[_cdView setCd_count:60];

[_cdView setCdLayer_cornerRadius:6];

[_cdView setCdLayer_borderColor:[UIColor blackColor] borderWidth:1.0f];

- (void)changeCD:(CdVIew*)cdview{

[_cdView runCd];

//... 请求网络方法

NSLog(@"\n\n您点击了按钮，哈哈😝\n");

}




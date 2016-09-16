//
//  ZLAlertDialog.h
//  ZLPackage
//
//  Created by NJW on 16/2/29.
//  Copyright © 2016年 www.zlebank.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum ButtonType{
    Button_OK,
    Button_CANCEL,
    Button_OTHER
}ButtonType;

@class ZLAlertDialogItem;
typedef void(^ZLAlertDialogHandler)(ZLAlertDialogItem *item);

@interface ZLAlertDialog : UIView
{
    UIView *_coverView;
    UIView *_alertView;
    UILabel *_labelTitle;
    UILabel *_labelmessage;
    
    UIScrollView *_buttonScrollView;
    UIScrollView *_contentScrollView;
    
    NSMutableArray *_items;
    NSString *_title;
    NSString *_messaege;
}

//按钮宽度,如果赋值,菜单按钮宽之和,超过alert宽,菜单会滚动
@property(assign,nonatomic)CGFloat buttonWidth;
//将要显示在alert上的自定义view
@property(strong,nonatomic)UIView *contentView;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;
- (void)addButton:(ButtonType)type withTitle:(NSString *)title handler:(ZLAlertDialogHandler)handler;
- (void)show;
- (void)dismiss;

@end

@interface ZLAlertDialogItem : NSObject
@property(nonatomic,copy) NSString *title;
@property(nonatomic) ButtonType type;
@property(nonatomic) NSUInteger tag;
@property(nonatomic, copy) ZLAlertDialogHandler action;

@end

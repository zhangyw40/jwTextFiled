//
//  AutoAttentionView.m
//  BatchPro
//
//  Created by wangchao on 15-6-23.
//  Copyright (c) 2015年 wangchao. All rights reserved.
//

#import "AutoAttentionView.h"

@interface AutoAttentionView ()

@property(nonatomic, strong) UILabel *label;

@end

@implementation AutoAttentionView

+ (AutoAttentionView *)sharedInstance
{
    static AutoAttentionView *singleton = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        singleton = [[AutoAttentionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return singleton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];

        self.label = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 120) / 2.0,
                                                               (self.frame.size.height - 50) / 2.0, 120, 50)];
        self.label.backgroundColor = [UIColor blackColor];
        self.label.layer.cornerRadius = 3;
        [self.label.layer setMasksToBounds:YES];
        self.label.textColor = [UIColor whiteColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:16];
        [self addSubview:self.label];
    }
    return self;
}

- (void)autoShowAttentionWith:(NSString *)str andWith:(UIView *)view
{
    [self setFrame:[UIScreen mainScreen].bounds];
    self.label.alpha = 0;
    self.label.text = str;
    [self.label sizeToFit];
    [self.label setFrame:CGRectMake((self.frame.size.width - self.label.frame.size.width - 20) / 2.0,
                                    (self.frame.size.height - 50) / 2.0, self.label.frame.size.width + 20, 50)];
    [view addSubview:self];

    [UIView animateWithDuration:0.3
        animations:^{
            self.label.alpha = 1;
        }
        completion:^(BOOL finished) {
            [self performSelector:@selector(hideNow) withObject:nil afterDelay:1.0];
        }];
}

- (void)hideNow
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3
            animations:^{
                self.label.alpha = 0;
            }
            completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
    });
}

@end

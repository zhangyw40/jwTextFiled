//
//  AppDelegate.m
//  jwTextFiled
//
//  Created by JW_N on 16/9/16.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark——————— 辅助加载storyboard函数
+ (id)receiveClassObjcParm1:(NSString *)className parm2:(NSString*)classID{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:className bundle:[NSBundle mainBundle]];
    
    Class myClass = NSClassFromString(className);
    
    UIViewController * tempController = [storyboard instantiateViewControllerWithIdentifier:classID];
    
    if ([tempController isKindOfClass:myClass]) {
        return tempController;
    }
    
    return nil;
    
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


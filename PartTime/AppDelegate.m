//
//  AppDelegate.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>
#import <UMMobClick/MobClick.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [MobClick setCrashReportEnabled:YES];
    // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    //[MobClick setLogEnabled:NO];
    //参数为NSString
    //*类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [MobClick setAppVersion:XcodeAppVersion];
    //
    UMConfigInstance.appKey = UMENG_APPKEY;
    UMConfigInstance.channelId = Ument_channelId;
    UMConfigInstance.ePolicy = (ReportPolicy)REALTIME;
    
    //  [MobClick checkUpdate]; //自动更新检查,
    //如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary
    //*)appInfo的参数
    
    [MobClick setLogSendInterval:60];
    //  [MobClick updateOnlineConfig]; //在线参数配置
    [MobClick startWithConfigure:UMConfigInstance];
    
    [UMConfigure initWithAppkey:@"" channel:@"App Store"];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

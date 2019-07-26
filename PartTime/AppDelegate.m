//
//  AppDelegate.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "AppDelegate.h"
//#import <UMCommon/UMCommon.h>
#import <UMMobClick/MobClick.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    // 版本号
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];

    
    // 日志（真实环境注意NO）
    [MobClick setCrashReportEnabled:YES];
    [MobClick setLogEnabled:YES];
    [MobClick setEncryptEnabled:YES];
    [MobClick setLogSendInterval:300.];
   
    UMConfigInstance.appKey = UMENG_APPKEY;
    UMConfigInstance.channelId = Ument_channelId;
    UMConfigInstance.ePolicy = (ReportPolicy)REALTIME;
    
    // 开启
    [MobClick startWithConfigure:[UMAnalyticsConfig sharedInstance]];

    
    //用于单个页面的弹窗
    UIWindow *hightWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    hightWindow.windowLevel = UIWindowLevelStatusBar;
    hightWindow.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:hightWindow];
    
    //用于所以界面之上，用于吐字提示
    UIWindow *highestWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    highestWindow.windowLevel = UIWindowLevelStatusBar;
    highestWindow.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:highestWindow];
    
    [PTManager shareManager].hightWindow = hightWindow;
    [PTManager shareManager].highestWindow = highestWindow;
    
    [NewShowLabel newShowLabel];
    
    
    //获取UUID存储到keyChain中
    NSString *uuid = [SAMKeychain passwordForService:@"兼职圈" account:@""];
    if (!uuid) {
        NSString *uuid = [NSUUID UUID].UUIDString;
        [SAMKeychain setPassword:uuid forService:@"兼职圈" account:@"" error:nil];
    }
   
    //首次打开app
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:PT_FIRST_TIME]) {
        [defaults setBool:YES forKey:PT_FIRST_TIME];
        [PartTimeUserFirstActiveModel requestFirstActiveCompleteBlock:^(id obj) {
            NSLog(@"首次打开app激活成功");
        } faileBlock:^(id error) {
            NSLog(@"首次打开app激活失败");
        }];
    }
    
   
    //用户登录状态，更新用户信息
    if ([PTUserUtil loginStatus]) {
        [PartTimeUserGetInfoModel requestUserWithUserId:[PTUserUtil getUserId] completeBlock:^(id obj) {
           
            PartTimeUserGetInfoModel *model = (PartTimeUserGetInfoModel *)obj;
            //[NewShowLabel setMessageContent:model.message];
            
        } faileBlock:^(id error) {
            
        }];
    }
    

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

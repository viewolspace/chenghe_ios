//
//  PTWebViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/26.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTWebViewController.h"
@interface PTWebViewController ()
{
    UIWebView *_webView;
}

@property (nonatomic,strong)UIWebView *webView;

@end

@implementation PTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.model.adUrl]];
    
    [self.webView loadRequest:request];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    
}


#pragma mark - setter and getter
- (UIWebView *)webView
{
    if (!_webView) {
        CGFloat naHeight = [PTManager shareManager].navigationBarHeight;
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_OF_SCREEN, HEIGHT_OF_SCREEN - naHeight)];
        [self.view addSubview:_webView];
    }
    
    return _webView;
}

@end

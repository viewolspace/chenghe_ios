//
//  PTLoginViewController.m
//  PartTime
//
//  Created by Mac on 2019/7/22.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "PTLoginViewController.h"
@interface PTLoginViewController ()
{
    NSInteger _firstTextFieldTag;
    NSInteger _secondTextFieldTag;
    NSTimer   *_timer;
    NSInteger _testNumber;
}
@end

@implementation PTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _testNumber = 60;
   
    self.testBtn.userInteractionEnabled = NO;
    self.confirmBtn.userInteractionEnabled = NO;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius  = 5.f;
    
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = self.confirmBtn.size.height / 2.0;

    self.shadowView.layer.shadowOpacity = 0.1;
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, 5);
 
    _firstTextFieldTag = 100;
    _secondTextFieldTag = 200;
    
    self.firstTextField.tag = _firstTextFieldTag;
    self.secondTextField.tag = _secondTextFieldTag;
  
    self.firstTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.secondTextField.keyboardType  = UIKeyboardTypeNumberPad;
   
    [self.firstTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.secondTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
   
}

- (void)stopTimer{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        _testNumber = 60;
        [self.testBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)startTimer{
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
    }else{
        NSLog(@"已经开始获取验证码了！");
    }
 
}


- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.tag == _firstTextFieldTag) {
        //手机号码
        if ([NSString validataPhoneNumber:textField.text]) {
            [self canLogin:YES];
        }else{
            [self canLogin:NO];
        }
        
    }else{
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - senderActions -
- (IBAction)closeAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)testAction:(UIButton *)sender {
    [self.view endEditing:YES];
    [self startTimer];
}

- (IBAction)confirmAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
}

- (void)canLogin:(BOOL)isCanLogin{
    
    if (isCanLogin) {
        
        [self.confirmBtn.layer addSublayer:self.confirmLayer];
        self.confirmLabel.textColor = [UIColor whiteColor];
        self.confirmBtn.userInteractionEnabled = YES;
        self.testBtn.userInteractionEnabled    = YES;
        [self.testBtn setTitleColor:[PTTool colorFromHexRGB:@"#588ffe"] forState:UIControlStateNormal];
        
    }else{
        
        [self.confirmLayer removeFromSuperlayer];
        self.confirmLabel.textColor = [PTTool colorFromHexRGB:@"#b2b2b2"];
        self.confirmBtn.userInteractionEnabled = NO;
        self.testBtn.userInteractionEnabled = NO;
         [self.testBtn setTitleColor:[PTTool colorFromHexRGB:@"#b2b2b2"] forState:UIControlStateNormal];

    }
   
}

- (void)timeAction:(NSTimer *)timer
{
    _testNumber --;
    if (_testNumber <= 0) {
        [self stopTimer];
        return;
    }
    NSString *times = [NSString stringWithFormat:@"%ld",_testNumber];
    [self.testBtn setTitle:times forState:UIControlStateNormal];
}


#pragma mark - setting and getting

- (CAGradientLayer *)confirmLayer
{
    if (!_confirmLayer) {
        _confirmLayer = [PTTool customLayer:self.confirmBtn haveCorner:YES];
    }
    
    return _confirmLayer;
}

@end

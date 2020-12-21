//
//  ViewController.m
//  TdsDemo
//
//  Created by 曹箭波 on 2020/12/21.
//

#import "ViewController.h"
#import <TapSDK/TapSDK.h>
#import <TapSDK/TapLoginHelper.h>
#import <TapSDK/TDSMoment.h>

@interface ViewController ()<TapLoginResultDelegate, TDSMomentDelegate>
- (void) initTapSDK;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [loginButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(taptapLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    
    
    UIButton *momentButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
    [momentButton setTitle:@"Moment" forState:UIControlStateNormal];
    [momentButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [momentButton addTarget:self action:@selector(taptapMoment:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:momentButton];
    
    
    
    [self initTapSDK];
}

- (void) initTapSDK {
    
    TDSConfig *config = TDSConfig.new;
    config.clientId = @"FwFdCIr6u71WQDQwQN";
    
    [TDSInitializer initWithConfig:config];
    
    // 开启 TapDB
    [TDSInitializer enableTapDBWithChannel:@"default" gameVersion:@"1.0.0"];
        
    // 开启 动态
    [TDSInitializer enableMoment];
    [TDSMomentSdk setDelegate:self];
    
}

- (void) taptapLogin:(UIButton *) button {
    [TapLoginHelper registerLoginResultDelegate:self];
    [TapLoginHelper startTapLogin:@[@"public_profile"]];
}


- (void) taptapMoment:(UIButton *) button {
    TDSMomentConfig *momentConfig = [[TDSMomentConfig alloc] init];
    [TDSMomentSdk openTapMomentWithConfig:momentConfig];
}

- (void)onLoginSuccess:(TTSDKAccessToken *)token {
    NSLog(@"Login success %@", [token toJsonString]);
    
}

- (void)onLoginCancel {
    NSLog(@"Login cancel");
    
}

- (void)onLoginError:(AccountGlobalError *)error{
    NSLog(@"Login error %@", [error toJsonString]);
}

- (void)didChangeResultCode:(NSInteger)code msg:(NSString *)msg {
    
}


@end

//
//  AppDelegate.h
//  12306NG
//
//  Created by Zhao Yang on 12/13/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;
@class UserCenterViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LoginViewController *loginView;
@property (strong, nonatomic) UserCenterViewController *userCenterViewController;
-(void)didLoginIn;
-(void)didLoginOut;
@end

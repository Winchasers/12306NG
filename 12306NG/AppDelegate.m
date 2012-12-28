//
//  AppDelegate.m
//  12306NG
//
//  Created by Zhao Yang on 12/13/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import "AppDelegate.h"

#import "LoginViewController.h"
#import "UserCenterViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation AppDelegate
@synthesize window=_window;
@synthesize loginView=_loginView;
@synthesize userCenterViewController=_userCenterViewController;

- (void)dealloc
{
    [_window release];
    [_loginView release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_black"]];
    // Override point for customization after application launch.
//if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.loginView = [[[LoginViewController alloc] init] autorelease];
 //   }
    
    UINavigationController* navController=[[UINavigationController alloc] initWithRootViewController:self.loginView];
    [navController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"banner"]]];
    [navController setNavigationBarHidden:YES];
    self.window.rootViewController = navController; 
    [navController release];
    //self.window.rootViewController = self.loginView;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)didLoginIn
{
    
    self.userCenterViewController=[[UserCenterViewController alloc] init];
    UINavigationController* navController=[[UINavigationController alloc] initWithRootViewController:self.userCenterViewController];
    [navController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"banner"]]];
     self.window.rootViewController = navController;  
    
    self.loginView.view.frame=CGRectOffset(self.loginView.view.frame, 0, 20);
    [self.window.rootViewController.view addSubview:self.loginView.view];    
    
    
    
    [UIView animateWithDuration:0.8 animations:^{
        self.loginView.view.layer.opacity=0;
    } completion:^(BOOL finished) {
        [self.loginView.view removeFromSuperview];
    } ];
    
}
-(void)didLoginOut
{ 
    self.loginView = [[[LoginViewController alloc] init]autorelease]; 
    self.loginView.view.frame=CGRectOffset( self.loginView.view.frame, 0, -480);
    [self.userCenterViewController.navigationController.view addSubview:self.loginView.view];  
    
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.loginView.view.frame=CGRectOffset(self.loginView.view.frame, 0, 460);
    } completion:^(BOOL finished) {
        self.loginView = [[[LoginViewController alloc] init]autorelease];
        UINavigationController* navController=[[UINavigationController alloc] initWithRootViewController:self.loginView];
        [navController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"banner"]]];
        [navController setNavigationBarHidden:YES];
        self.window.rootViewController = navController;
        [navController release];
    }];    
}


@end

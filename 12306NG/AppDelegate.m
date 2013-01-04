//
//  AppDelegate.m
//  12306NG
//
//  Created by Zhao Yang on 12/13/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import "AppDelegate.h"
#import "Flurry.h"
#import "HTMLParser.h"
#import "ASIHTTPRequest.h"

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
    
    [self test2];
    [Flurry startSession:@"HMPD8ZD9D9RZ67J7SP7T"];
    
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isAutoLogin"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    [self test1];
    

         
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor=MAIN_BG_COLOR;
    
    //BOOL isAutoLogin= [[[NSUserDefaults standardUserDefaults] objectForKey:@"isAutoLogin"] boolValue];
    BOOL isAutoLogin=NO;

    NSString* userName= [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    
    
    
    if (isAutoLogin&&userName&&![userName isEqualToString:@""]) {
        
         self.userCenterViewController=[[[UserCenterViewController alloc] init]autorelease];   
        UINavigationController* navController=[[UINavigationController alloc] initWithRootViewController:self.userCenterViewController];
        //[navController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"banner"]]];
        [navController.navigationBar setTintColor:([UIColor colorWithPatternImage:[UIImage imageNamed:@"bluebutton"]])];
        //[navController setNavigationBarHidden:YES];
        self.window.rootViewController = navController;
        [navController release];
    }else {
        
        self.loginView = [[[LoginViewController alloc] init] autorelease];    
        UINavigationController* navController=[[UINavigationController alloc] initWithRootViewController:self.loginView];
        [navController.navigationBar setTintColor:MAIN_NAV_COLOR];
         [navController setNavigationBarHidden:YES];
        self.window.rootViewController = navController;
        [navController release];
    }
    
    
    
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
    
    self.userCenterViewController=[[[UserCenterViewController alloc] init]autorelease];
    UINavigationController* navController=[[UINavigationController alloc] initWithRootViewController:self.userCenterViewController];
    [navController.navigationBar setTintColor:MAIN_NAV_COLOR];
     self.window.rootViewController = navController;
    [navController release];
    
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
    
    [ASIHTTPRequest clearSession];
    self.loginView = [[[LoginViewController alloc] init]autorelease]; 
    self.loginView.view.frame=CGRectOffset( self.loginView.view.frame, 0, -480);
    [self.userCenterViewController.navigationController.view addSubview:self.loginView.view];  
    
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.loginView.view.frame=CGRectOffset(self.loginView.view.frame, 0, 460);
    } completion:^(BOOL finished) {
        self.loginView = [[[LoginViewController alloc] init]autorelease];
        UINavigationController* navController=[[UINavigationController alloc] initWithRootViewController:self.loginView];
        [navController.navigationBar setTintColor:MAIN_NAV_COLOR];
        [navController setNavigationBarHidden:YES];
        self.window.rootViewController = navController;
        [navController release];
    }];    
}

-(void)test1
{
    
    NSString* html=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"userinfo" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];;    
    HTMLParser* parse=[[HTMLParser alloc] initWithString:html  error:nil];            
    HTMLNode* body=parse.body;
    
    NSArray* arr=[body findChildrenOfClass:@"pim_font"];
    
    NSMutableDictionary* dict=[NSMutableDictionary dictionary];
    for (HTMLNode* nodeTable in arr) {
        
        
        HTMLNode* nodeTR =[nodeTable firstChild];
        while (nodeTR&&nodeTR->_node) {
            
            NSArray* tdArray=[nodeTR findChildTags:@"td"];
            if ([tdArray count]>1) {
                
                HTMLNode* nodeTD= [tdArray objectAtIndex:0]; 
                HTMLNode* nodeTD2=[tdArray objectAtIndex:1];
                NSString* name=[nodeTD contents];
                NSString* value=[nodeTD2 contents];
                if(value==nil)value=@"";
                [dict setValue:value forKey:name];
                
            }
            nodeTR=nodeTR.nextSibling;
        }
    }
    
    LogInfo(@"%@",dict);
    
    [[[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",dict] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease] show];
}


-(void)test2
{
   NSString* str=@"%E8%AF%B7%E8%BE%93%E5%85%A5%E6%B1%89%E5%AD%97%E6%88%96%E6%8B%BC%E9%9F%B3%E9%A6%96%E5%AD%97%E6%AF%8D";
    
  LogInfo(@"%@",   [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
    
}
@end

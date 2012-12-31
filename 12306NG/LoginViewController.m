//
//  LoginViewController.m
//  12306NG
//
//  Created by Zhao Yang on 12/13/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import "LoginViewController.h"
#import "UserCenterViewController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "NSString+SBJSON.h"

#define OFFSET_Y 85

@interface LoginViewController ()
@property(nonatomic,retain)NSMutableArray* tableArray;
@property(nonatomic,retain)UITableView* mainTableView;
@property(nonatomic,retain)ASIHTTPRequest* requestImg;

@end

@implementation LoginViewController
@synthesize tableArray,mainTableView;
@synthesize requestImg;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([[UIScreen mainScreen] bounds].size.height == 568.0) {
        self = [super initWithNibName:@"LoginViewController_ip5" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
        isCodeLoaded=NO;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_black"]];
    
   
    
    
    
    
    int OffsetY=30;
    
    
    UIImageView* logoView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    logoView.frame=CGRectMake(20, OffsetY, 280, 70);
    [self.view addSubview:logoView];
    
    
    CGRect rect=CGRectMake(10, OffsetY+80, self.view.bounds.size.width-20,150);
    self.mainTableView=[[[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped] autorelease]  ;    
    [self.view addSubview:self.mainTableView];
    mainTableView.backgroundColor=[UIColor clearColor];
    mainTableView.backgroundView=nil;
    mainTableView.dataSource=(id<UITableViewDataSource>)self;
    mainTableView.delegate=(id<UITableViewDelegate>)self;
    mainTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    mainTableView.scrollEnabled=NO;
    
    UIButton* btnLogin=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnLogin.frame=CGRectMake(20, OffsetY+230, 280, 40);
    [btnLogin setTitle:@"登  录" forState:UIControlStateNormal];
//    [btnLogin setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"banner_bluebutton"]]];
    [btnLogin addTarget:self action:@selector(onLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    
    
    UIButton* btnRegist=[UIButton buttonWithType:UIButtonTypeCustom];
    btnRegist.frame=CGRectMake(20, OffsetY+280, 80, 40);
    btnRegist.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [btnRegist setTitle:@"注册新用户" forState:UIControlStateNormal];
    btnRegist.showsTouchWhenHighlighted=YES;
    [btnRegist addTarget:self action:@selector(onRegistClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRegist];
    
    
    
    UIView* lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 35-3, 80, 1)];
    lineView.backgroundColor=[UIColor whiteColor];
    [btnRegist addSubview:lineView];
    [lineView release];
    
    UIButton* btnAutoLogin=[UIButton buttonWithType:UIButtonTypeCustom];
    btnAutoLogin.frame=CGRectMake(220-50, OffsetY+280, 130, 40);
    btnAutoLogin.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [btnAutoLogin setTitle:@"允许自动登录" forState:UIControlStateNormal];
    [btnAutoLogin setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    //btnAutoLogin.showsTouchWhenHighlighted=YES;
    [btnAutoLogin setImage:[UIImage imageNamed:@"auto_login_frame"] forState:UIControlStateNormal];
    [btnAutoLogin setImage:[UIImage imageNamed:@"auto_login2"] forState:UIControlStateSelected];
    BOOL b=[[[NSUserDefaults standardUserDefaults] objectForKey:@"isAutoLogin"] boolValue];
    btnAutoLogin.selected=b;
    [btnAutoLogin addTarget:self action:@selector(onAutoLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAutoLogin];
    
    
    
    UITextView* tipsView=[[UITextView alloc] initWithFrame:CGRectMake(20, 360, 280, 100)];
    [self.view addSubview:tipsView];
    tipsView.backgroundColor=[UIColor clearColor];
    tipsView.textColor=[UIColor whiteColor];
    tipsView.font=[UIFont systemFontOfSize:14];
    tipsView.text=@"友情提示：\n☞ 设置自动登录系统将保存你的账号信息\n☞ 自动登录将有助于你在站点繁忙的时候更有计划订到车票";
    [tipsView setEditable:NO];
    [tipsView release];
    
    
    
    UITapGestureRecognizer* tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tapGesture.delegate=(id<UIGestureRecognizerDelegate>)self;
    [self.view addGestureRecognizer:tapGesture];
    


}
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    
//    if ([gestureRecognizer isKindOfClass:[UIButton class]]) {
//        return NO;
//    }
//    return YES;
//}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}
-(void)tap:(UIGestureRecognizer*)gesture
{
    if (self.view.frame.origin.y==-OFFSET_Y) {
        [UIView animateWithDuration:0.3 animations:^{
        self.view.frame=CGRectOffset(self.view.frame, 0, OFFSET_Y);
        }];
    }
    [self.view endEditing:YES];
}
-(void)onAutoLoginClick:(UIButton*)btn
{
    
    btn.selected=!btn.selected;
    
    [[NSUserDefaults standardUserDefaults] setBool:btn.selected forKey:@"isAutoLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
-(void)onRegistClick
{
    
    [self.view endEditing:YES];
    RegisterViewController* regController=[[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regController animated:YES];
    [regController release];
    //    UINavigationController* navController=[[UINavigationController alloc] initWithRootViewController:userController];
    //    [navController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"banner"]]];
    //    [userController release];   

}


-(void)onLoginClick

{
    
    
#if (DEBUG_MODE==1)    
    [((AppDelegate*)[UIApplication sharedApplication].delegate) didLoginIn];
    return;
#endif
    
        
        if (!textCode||!textCode.text
            ||[@"" isEqualToString:[textCode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]){
            
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];        
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"     请输入验证码！     ";
            hud.margin = 10.f;
            hud.yOffset = -60.f;
            hud.removeFromSuperViewOnHide = YES;	
            [hud hide:YES afterDelay:2];
            [textCode becomeFirstResponder];
            return;
        }
    if (!textName||!textName.text
        ||[@"" isEqualToString:[textName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]){
        
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"     请输入用户名！     ";
        hud.margin = 10.f;
        hud.yOffset = -60.f;
        hud.removeFromSuperViewOnHide = YES;	
        [hud hide:YES afterDelay:2];
        [textName becomeFirstResponder];
        return;
    }
    if (!textPwd||!textPwd.text
        ||[@"" isEqualToString:[textPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]){
        
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];        
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"     请输入密码！     ";
        hud.margin = 10.f;
        hud.yOffset = -60.f;
        hud.removeFromSuperViewOnHide = YES;	
        [hud hide:YES afterDelay:2];
        [textPwd becomeFirstResponder];
        return;
    }

    

    
    if (self.view.frame.origin.y==-OFFSET_Y) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame=CGRectOffset(self.view.frame, 0, OFFSET_Y);
        }];
    }

    [self.view endEditing:YES];
    HUD=[[MBProgressHUD alloc] initWithView:self.view];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"  亲，正在登录中，请稍后...    ";
    HUD.margin = 30.f;
    HUD.yOffset = -45.f;
    [self.view addSubview:HUD];
    [HUD showWhileExecuting:@selector(doRequestData) onTarget:self withObject:nil animated:YES];


}
-(void)doRequestData
{
    
    
    ASIFormDataRequest* loginAysnSuggest=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/loginAction.do?method=loginAysnSuggest"]];    
    //loginAysnSuggest.delegate=(id<ASIHTTPRequestDelegate>)self;
    loginAysnSuggest.useCookiePersistence=YES;
    [loginAysnSuggest setValidatesSecureCertificate:NO];
    /*    
     x-requested-with: XMLHttpRequest
     Accept-Language: zh-cn
     Referer: https://dynamic.12306.cn/otsweb/loginAction.do?method=init#
     Accept: application/json, text/javascript, *
     Accept-Encoding: gzip, deflate
     User-Agent: Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)
     Host: dynamic.12306.cn
     Content-Length: 0
     Connection: Keep-Alive
     Cache-Control: no-cache
     
     */   
    
    [loginAysnSuggest addRequestHeader:@"x-requested-with" value:@"XMLHttpRequest"];
    [loginAysnSuggest addRequestHeader:@"Accept-Language" value:@"zh-CN"];
    [loginAysnSuggest addRequestHeader:@"Referer" value:@"https://dynamic.12306.cn/otsweb/loginAction.do?method=init"];
    [loginAysnSuggest addRequestHeader:@"Accept" value:@"application/json,text/javascript,*/*"];
    [loginAysnSuggest addRequestHeader:@"Accept-Encoding" value:@" gzip, deflate"];    
    [loginAysnSuggest addRequestHeader:@"User-Agent" value:@" Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"];    
    [loginAysnSuggest addRequestHeader:@"Host" value:@" dynamic.12306.cn"];
    [loginAysnSuggest addRequestHeader:@"Content-Length" value:@"0"];
    [loginAysnSuggest addRequestHeader:@"Connection" value:@" Keep-Alive"];
    [loginAysnSuggest addRequestHeader:@"Cache-Control" value:@" no-cache"];    
    
    
    [loginAysnSuggest startSynchronous];
    
    if ([self CheckHasHttpError:loginAysnSuggest showAlert:YES]) {
        return;
    }
     
    NSLog(@"%@",loginAysnSuggest.responseString);
    
    NSMutableDictionary* dict=[loginAysnSuggest.responseString JSONValue];
    
    NSString* loginRand=[dict objectForKey:@"loginRand"];
    //NSString* randError=[dict objectForKey:@"randError"];
    
    
    ASIFormDataRequest* req=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/loginAction.do?method=login"]];    
//    req.delegate=(id<ASIHTTPRequestDelegate>)self;
    req.useCookiePersistence=YES;
    [req setValidatesSecureCertificate:NO];
    [req addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,*/*"];
    [req addRequestHeader:@"Referer" value:@"https://dynamic.12306.cn/otsweb/loginAction.do?method=init"];
    [req addRequestHeader:@"Accept-Language" value:@"zh-CN"];
    [req addRequestHeader:@"User-Agent" value:@" Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"];
    [req addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [req addRequestHeader:@"Accept-Encoding" value:@" gzip, deflate"];
    [req addRequestHeader:@"Host" value:@" dynamic.12306.cn"];
    //[req addRequestHeader:@"Content-Length" value:@" 166"];
    [req addRequestHeader:@"Connection" value:@" Keep-Alive"];
    [req addRequestHeader:@"Cache-Control" value:@" no-cache"];
    
    
//    req.requestCookies=[NSMutableArray arrayWithArray:[CookiesHelper sharedCookiesHelper].cookies];
    
    //53174e1302ff09f8
    NSString* strF=@"loginRand=%@&refundLogin=N&refundFlag=Y&loginUser.user_name=%@&nameErrorFocus=&user.password=%@&passwordErrorFocus=&randCode=%@&randErrorFocus=focus";
    
    
    NSString* str=[NSString stringWithFormat:strF,loginRand,textName.text,textPwd.text,textCode.text];
    [req setPostBody:[NSMutableData dataWithData:[str dataUsingEncoding:NSUTF8StringEncoding]]]; 
    
    [req startSynchronous];
    
    if ([self CheckHasHttpError:req showAlert:YES]) {
        return;
    }
   
    [req applyCookieHeader];
    
    
     LogInfo(@"%@",req.responseCookies);
    [self CheckAndProcessResponeData:req.responseData];
    
    //[CookiesHelper sharedCookiesHelper].cookies=req.responseCookies ;
    
    
    
    
       
//    
//    UserCenterViewController* userController=[[UserCenterViewController alloc] init];
//    UINavigationController* navController=[[UINavigationController alloc] initWithRootViewController:userController];
//    [navController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"banner"]]];
//    [userController release];    
//     
//    [self presentModalViewController:navController animated:YES];
//    [navController release];
}
-(void)CheckAndProcessResponeData:(NSData*)data
{
    
    if (!data||[data length]==0) {
        return;
    }
    
    NSString* ResponeString= [NSString stringWithCString:[data bytes] encoding:NSUTF8StringEncoding];
    
    if (!ResponeString) {
        return;
    }
    LogInfo(@"\n\n==================================ResponeString==================\n%@\n==================================EndResponeString==================\n",ResponeString);
    
    
    
    
    NSRegularExpression* regexError=[[NSRegularExpression alloc] initWithPattern:@"请输入正确的验证码" options:NSRegularExpressionCaseInsensitive error:nil];
    
    
    NSTextCheckingResult* rError=  [regexError firstMatchInString:ResponeString options:0 range:(NSRange){0,ResponeString.length}];
    
    [regexError release];
    
    if (rError.range.length>0) {
        
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:@"请输入正确的验证码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];   
        [self changeImg:nil]; 
        
        return;
        
    }
    
    
    NSRegularExpression* regexAlert=[[NSRegularExpression alloc] initWithPattern:@"var message = [\"](.*)[\"]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    
    NSTextCheckingResult* rAlert=  [regexAlert firstMatchInString:ResponeString options:0 range:(NSRange){0,ResponeString.length}];
    [regexAlert release];
    
    if (rAlert.range.length>0) {
        
        NSString* msg=[ResponeString substringWithRange:(NSRange){rAlert.range.location+15,rAlert.range.length-15-1}];
        if (![msg isEqualToString:@""]) {
            
            
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];  
            [self changeImg:nil]; 
            
            return;
            
        }
    }
    NSRegularExpression* regex=[[NSRegularExpression alloc] initWithPattern:@"var u_name = [\'](.*)[\'][;]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSTextCheckingResult* r=  [regex firstMatchInString:ResponeString options:0 range:(NSRange){0,ResponeString.length}];
    
    [regex release];
    if (!r.range.length>0) {
        
        
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:@"系统维护中，维护时间为23:00-07:00，在此期间，如需在互联网购票、改签或退票，请到铁路车站窗口办理，谢谢！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];  
        //[self changeImg:nil]; 
        [self.navigationController dismissModalViewControllerAnimated:YES];        
        return;
    }
    
    NSString* nameStr=[ResponeString substringWithRange:(NSRange){r.range.location+14,r.range.length-14-2}];
    
    [[NSUserDefaults standardUserDefaults] setObject:nameStr forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    [GlobalClass sharedClass].userName=nameStr;     
//    [GlobalClass sharedClass].isLoginIn=YES; 
    
    [((AppDelegate*)[UIApplication sharedApplication].delegate) didLoginIn];
    
    

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell_ABC";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
       // cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        //cell.backgroundColor=[UIColor clearColor];
        
        if (indexPath.row==0) {
        cell.textLabel.text=@"用户名";
            textName=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
            textName.placeholder=@"请输入12306注册账号";
            textName.text=@"iostest";
            textName.autocapitalizationType=UITextAutocapitalizationTypeNone;
            textName.autocorrectionType=UITextAutocorrectionTypeNo;
            textName.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
            textName.delegate=self;
            textName.returnKeyType=UIReturnKeyNext;
            cell.accessoryView=textName;
            
            
        }else if (indexPath.row==1) 
        {
             cell.textLabel.text=@"密   码";
            
            textPwd=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
            textPwd.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
            textPwd.placeholder=@"请输入12306密码";
            textPwd.text=@"ios123";
            textPwd.secureTextEntry=YES;
            textPwd.delegate=self;
            textPwd.returnKeyType=UIReturnKeyNext;
            cell.accessoryView=textPwd;
            
        }
    else if (indexPath.row==2)  {
        
        
        cell.textLabel.text=@"验证码";
        UIView* v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];      
        textCode=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
        textCode.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        textCode.placeholder=@"验证码点击可刷新";
        textCode.font=[UIFont systemFontOfSize:14];
        textCode.autocapitalizationType=UITextAutocapitalizationTypeNone;
        textCode.autocorrectionType=UITextAutocorrectionTypeNo;
        textCode.delegate=self;
        [v addSubview:textCode];
        textCode.returnKeyType=UIReturnKeyDone;
        
        
        imgBtn=[[UIButton alloc] initWithFrame:CGRectMake(120, 0, 60, 40)];
        [cell.contentView addSubview:imgBtn];
        [imgBtn addTarget:self action:@selector(changeImg:) forControlEvents:UIControlEventTouchUpInside];
        [self performSelectorInBackground:@selector(changeImg:) withObject:nil];
        
        [v addSubview:imgBtn];
        
        cell.accessoryView=v;
        [v release];
    }
        
    } 
    //cell.textLabel.text=[[tableArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    
    
    return cell ;
}

-(void)changeImg:(UIButton*)btn
{
      
    self.requestImg=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/passCodeAction.do?rand=sjrand"]] ;
    
    requestImg.accessibilityLabel=@"imgCode";
    [requestImg setValidatesSecureCertificate:NO];
    //[requestImg applyCookieHeader];
     requestImg.delegate=(id<ASIHTTPRequestDelegate>)self;
    [requestImg startAsynchronous];
    
    [imgBtn setImage:nil forState:UIControlStateNormal];
    
    UIActivityIndicatorView* activity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.tag=1231;
    activity.center=CGPointMake(30, 20);    
    [activity startAnimating];
     [imgBtn addSubview:activity];
    [activity release];
    
    
    
    
}
- (void)requestFinished:(ASIHTTPRequest *)request_
{
    if (request_==requestImg) {
        
        [request_ applyCookieHeader];
        UIImage* img=[UIImage imageWithData:request_.responseData]; 
        
        [[imgBtn viewWithTag:1231] removeFromSuperview];
        [imgBtn setImage:img forState:UIControlStateNormal];
        
        isCodeLoaded=YES;
    }
//    if ([request_.accessibilityLabel isEqualToString:@"imgCode"]) {
//        
//        [request_ applyCookieHeader];
//        UIImage* img=[UIImage imageWithData:request_.responseData]; 
//        [imgBtn setImage:img forState:UIControlStateNormal];
//        
//        isCodeLoaded=YES;
//    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [[imgBtn viewWithTag:1231] removeFromSuperview];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:request.error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(self.view.frame.origin.y==0)
    {
 
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame=CGRectOffset(self.view.frame, 0, -OFFSET_Y);
    }];
    
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField; 
{
    if (textField==textName) {
        [textPwd becomeFirstResponder];
    }else if (textField==textPwd)  {
        [textCode becomeFirstResponder];
    }else {
        //[self.view endEditing:YES];
        [self  onLoginClick];
    }
    return YES;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [requestImg setDelegate:nil];
}
- (void)dealloc
{
    
   
    [self.requestImg setDelegate:nil];
    [self.requestImg release];
    [super dealloc];
    
}

- (BOOL)CheckHasHttpError:(ASIHTTPRequest *)request showAlert:(BOOL)showAlert
{
    if (request.error.code==0) {
        return NO;
    }else {
        
        if (showAlert) {
        
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:request.error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        }

        return YES;
        
    }
    
        
}
@end

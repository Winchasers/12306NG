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

@interface LoginViewController ()
@property(nonatomic,retain)NSMutableArray* tableArray;
@property(nonatomic,retain)UITableView* mainTableView;

@end

@implementation LoginViewController
@synthesize tableArray,mainTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([[UIScreen mainScreen] bounds].size.height == 568.0) {
        self = [super initWithNibName:@"LoginViewController_ip5" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_black"]];
    
    
    
    
    
    
    
    UIImageView* logoView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    logoView.frame=CGRectMake(20, 30, 280, 70);
    [self.view addSubview:logoView];
    
    
    CGRect rect=CGRectMake(10, 110, self.view.bounds.size.width-20,150);
    self.mainTableView=[[[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped] autorelease]  ;    
    [self.view addSubview:self.mainTableView];
    mainTableView.backgroundColor=[UIColor clearColor];
    mainTableView.backgroundView=nil;
    mainTableView.dataSource=(id<UITableViewDataSource>)self;
    mainTableView.delegate=(id<UITableViewDelegate>)self;
    
    UIButton* btnLogin=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnLogin.frame=CGRectMake(20, 260, 280, 40);
    [btnLogin setTitle:@"登  录" forState:UIControlStateNormal];
//    [btnLogin setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"banner_bluebutton"]]];
    [btnLogin addTarget:self action:@selector(onLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    
    
    UIButton* btnRegist=[UIButton buttonWithType:UIButtonTypeCustom];
    btnRegist.frame=CGRectMake(20, 310, 80, 30);
    btnRegist.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [btnRegist setTitle:@"注册新用户" forState:UIControlStateNormal];
    [btnRegist addTarget:self action:@selector(onRegistClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRegist];
    
    
    UIView* lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 30-1, 80, 1)];
    lineView.backgroundColor=[UIColor whiteColor];
    [btnRegist addSubview:lineView];
    [lineView release];
    
    UIButton* btnAutoLogin=[UIButton buttonWithType:UIButtonTypeCustom];
    btnAutoLogin.frame=CGRectMake(220-40, 310, 120, 30);
    btnAutoLogin.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [btnAutoLogin setTitle:@"允许自动登录" forState:UIControlStateNormal];
    [btnAutoLogin setImage:[UIImage imageNamed:@"auto_login_frame"] forState:UIControlStateNormal];
    [btnAutoLogin setImage:[UIImage imageNamed:@"auto_login2"] forState:UIControlStateSelected];
    btnAutoLogin.selected=YES;
    [btnAutoLogin addTarget:self action:@selector(onAutoLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAutoLogin];
    
    
    
    UITextView* tipsView=[[UITextView alloc] initWithFrame:CGRectMake(20, 360, 280, 100)];
    [self.view addSubview:tipsView];
    tipsView.backgroundColor=[UIColor clearColor];
    tipsView.textColor=[UIColor whiteColor];
    tipsView.font=[UIFont systemFontOfSize:14];
    tipsView.text=@"友情提示：\n☞ 设置自动登录系统将保存你的账号信息\n☞ 自动登录将有助于你在站点繁忙的时候更有计划订到车票";
    [tipsView release];
    
    
    
    
    


}
-(void)onAutoLoginClick:(UIButton*)btn
{
    
    btn.selected=!btn.selected;
    
}
-(void)onRegistClick
{
    
    RegisterViewController* regController=[[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regController animated:YES];
    [regController release];
    //    UINavigationController* navController=[[UINavigationController alloc] initWithRootViewController:userController];
    //    [navController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"banner"]]];
    //    [userController release];   

}
-(void)onLoginClick
{
    
    [((AppDelegate*)[UIApplication sharedApplication].delegate) didLoginIn];
    
//    
//    UserCenterViewController* userController=[[UserCenterViewController alloc] init];
//    UINavigationController* navController=[[UINavigationController alloc] initWithRootViewController:userController];
//    [navController.navigationBar setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"banner"]]];
//    [userController release];    
//     
//    [self presentModalViewController:navController animated:YES];
//    [navController release];
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
        
        
        if (indexPath.row==0) {
        cell.textLabel.text=@"用户名";
            textName=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
            textName.placeholder=@"请输入12306注册账号";
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
            textPwd.delegate=self;
            textPwd.returnKeyType=UIReturnKeyNext;
            cell.accessoryView=textPwd;
            
        }
    else if (indexPath.row==2)  {
        
        
        cell.textLabel.text=@"验证码";
        UIView* v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];      
        textCode=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        textCode.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        textCode.placeholder=@"验证码点击可刷新";
        textCode.delegate=self;
        [v addSubview:textCode];
        textCode.returnKeyType=UIReturnKeyDone;
        cell.accessoryView=v;
        [v release];
    }
        
    } 
    //cell.textLabel.text=[[tableArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    
    
    return cell ;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField; 
{
    if (textField==textName) {
        [textPwd becomeFirstResponder];
    }else if (textField==textPwd)  {
        [textCode becomeFirstResponder];
    }else {
        [self.view endEditing:YES];
    }
    return YES;
}
@end

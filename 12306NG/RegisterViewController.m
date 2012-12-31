//
//  RegisterViewController.m
//  12306NG
//
//  Created by Zhao Yang on 12/13/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property(nonatomic,retain) NSMutableArray* tableArray;
@property(nonatomic,retain) NSMutableDictionary* dataDict;
@property(nonatomic,retain)UITableView* mainTableView;

@end

@implementation RegisterViewController
@synthesize tableArray,dataDict, mainTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([[UIScreen mainScreen] bounds].size.height == 568.0) {
        self = [super initWithNibName:@"RegisterViewController_ip5" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
        self.tableArray=[NSMutableArray arrayWithObjects:
                         [NSMutableArray arrayWithObjects:
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"用  户  名",@"title",@"name",@"id",@"",@"value",@"6-30位(字母、数字均可)",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"密       码",@"title",@"pwd",@"id",@"",@"value",@"至少6位(字母、数字均可)",@"mask" ,nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"确认密码",@"title",@"pwd2",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"查询密码",@"title",@"qpwd",@"id",@"",@"value",@"6位数字语音查询密码",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"确认密码",@"title",@"qpwd2",@"id",@"",@"value",@"请再次输入语音查询密码",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"验  证  码",@"title",@"code",@"id",@"",@"value",@"验证码点击可刷新",@"mask", nil],
                          nil],
                         
                         
                         [NSMutableArray arrayWithObjects:
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"手机号码",@"title",@"phone",@"id",@"",@"value",@"接受订票信息",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"电子邮件",@"title",@"email",@"id",@"",@"value",@"激活账号，接受订单信息",@"mask", nil],
                          nil],
                         
                         
                         
                         [NSMutableArray arrayWithObjects:
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"姓       名",@"title",@"idName",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"性       别",@"title",@"sex",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"出生日期",@"title",@"birthday",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"证件类型",@"title",@"idType",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"证件号码",@"title",@"idNumber",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"旅客类型",@"title",@"userType",@"id",@"",@"value",@"",@"mask", nil],
                          nil],
                         nil];
        self.dataDict=[NSMutableDictionary dictionary];
        
        for (NSMutableArray* rowArray  in self.tableArray) 
        {
            for (NSMutableDictionary* dict  in rowArray)
            {
                
                [self.dataDict setValue:[dict objectForKey:@"value"] forKey:[dict objectForKey:@"id"]];
            }
        }
        
        
        
    }
    return self;
}

-(void)onSubmitClick
{
    
    
    // isKeyBoardShow=NO;
    [self.view endEditing:YES];
    
    
    
    
    
//    
//    @"" canBeConvertedToEncoding:NSUnicodeStringEncoding
    
    NSString* msg=[self replaceUnicode:self.dataDict.debugDescription ];
//    
//    
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    
    //NSLog(@"%@",self.dataDict);
}
- (NSString *)replaceUnicode:(NSString *)unicodeStr {  
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];  
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];  
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2 ] stringByAppendingString:@"\""];  
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];  
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData  
                                                          mutabilityOption:NSPropertyListImmutable   
                                                                    format:NULL  
                                                          errorDescription:NULL];  
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];  
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor=[UIColor clearColor];
    self.title=NSLocalizedString(@"新用户注册", nil);
    self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(onSubmitClick)] autorelease];
    
    CGRect rect=CGRectMake(0, 0, self.view.bounds.size.width,420);
    self.mainTableView=[[[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped] autorelease]  ;    
    [self.view addSubview:self.mainTableView];
    mainTableView.backgroundColor=[UIColor clearColor];
    mainTableView.backgroundView=nil;
    mainTableView.dataSource=(id<UITableViewDataSource>)self;
    mainTableView.delegate=(id<UITableViewDelegate>)self;
    mainTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
    isKeyBoardShow=NO;
    
    [self registerForKeyboardNotifications];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    tagIndex=100;
    return [tableArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [[tableArray objectAtIndex:section]  count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //static NSString *CellIdentifier = @"Cell_ABC";
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell-%d-%d",indexPath.section,indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        
        NSMutableDictionary* dataDic=[[tableArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.textLabel.text=[dataDic valueForKey:@"title"];
        cell.textLabel.textColor=[UIColor colorWithWhite:0.2 alpha:0.9];
        
        // if (indexPath.section==0&&indexPath.row==0) {
        
        
        UITextField* textName=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];    
        textName.accessibilityLabel=[dataDic valueForKey:@"id"];    
        textName.tag=tagIndex++;
        textName.placeholder=[dataDic valueForKey:@"mask"];
        textName.text=[dataDic valueForKey:@"value"];
        textName.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        textName.delegate=self;
        textName.returnKeyType=UIReturnKeyNext;
        cell.accessoryView=textName;
        
        NSLog(@"%d",textName.tag);
        
        
    }
    
    
    
    // }
    
    
    
    return cell ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView* v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    
    UILabel* lb=[[UILabel alloc] initWithFrame:CGRectMake(30, 10, tableView.frame.size.width, 30)];
    lb.backgroundColor=[UIColor clearColor];
    
    
     
    if (CGColorEqualToColor([UIColor whiteColor].CGColor,[MAIN_BG_COLOR CGColor]))
    {
        lb.textColor=[UIColor blackColor];
    }else {
        
        lb.textColor=[UIColor whiteColor];
    }
    
    
    lb.font=[UIFont boldSystemFontOfSize:15];
    
    [lb setText:section==0?@"基本信息":section==1?@"联系方式":@"个人信息"];
    [v addSubview:lb];
    return [v autorelease];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 40;
}


#pragma mark -
#pragma mark  tableViewAction

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    /***********************************************************************/     
    if (indexPath.section==0&&indexPath.row==0) 
    {
        //        UserInfomationViewController* controller=[[UserInfomationViewController alloc] init];
        //        [self.navigationController pushViewController:controller animated:YES];
        //        [controller release];
    }
    else if (indexPath.section==0&&indexPath.row==1)
    {
        
    }
    /***********************************************************************/   
    if (indexPath.section==1&&indexPath.row==0) 
    {
        //        QueryTicketViewController* controller=[[QueryTicketViewController alloc] init];
        //        [self.navigationController pushViewController:controller animated:YES];
        //        [controller release];
    }
    else if (indexPath.section==1&&indexPath.row==1)
    {
        //        OrderListViewController* controller=[[OrderListViewController alloc] init];
        //        [self.navigationController pushViewController:controller animated:YES];
        //        [controller release];
    }
    /***********************************************************************/ 
    if (indexPath.section==2&&indexPath.row==0) 
    {
        //        ResidualTicketInformViewController* controller=[[ResidualTicketInformViewController alloc] init];
        //        [self.navigationController pushViewController:controller animated:YES];
        //        [controller release];
    }
    else if (indexPath.section==2&&indexPath.row==1)
    {
        //        UserInfomationViewController* controller=[[UserInfomationViewController alloc] init];
        //        [self.navigationController pushViewController:controller animated:YES];
        //        [controller release];
    }
    /***********************************************************************/ 
    if (indexPath.section==3&&indexPath.row==0) 
    {
        //        FeedbackViewController* controller=[[FeedbackViewController alloc] init];
        //        [self.navigationController pushViewController:controller animated:YES];
        //        [controller release];
    }
    else if (indexPath.section==3&&indexPath.row==1)
    {
    }
    else if (indexPath.section==3&&indexPath.row==2)
    {
        //        [iVersion sharedInstance].ignoredVersion=@"1.1";
        //        [[iVersion sharedInstance] checkForNewVersion];
        
    }
    else if (indexPath.section==3&&indexPath.row==3)
    {
        //        AboutUsViewController* controller=[[AboutUsViewController alloc] init];
        //        [self.navigationController pushViewController:controller animated:YES];
        //        [controller release];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if ([tableView cellForRowAtIndexPath:indexPath].accessoryType!=UITableViewCellAccessoryNone) {        
        [tableView.delegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 - (void)textFieldDidEndEditing:(UITextField *)textField;
 {
 
 if ([[UIDevice currentDevice].systemVersion floatValue]<5.0) {
 
 NSIndexPath* indexPath=   [mainTableView indexPathForRowAtPoint:[textField convertPoint:CGPointMake(10, 10) toView:self.mainTableView]];
 [self.dataDict setValue:textField.text forKey: [[[self.tableArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"id"]];
 
 }
 else {
 
 if (textField.accessibilityLabel&& ![textField.accessibilityLabel isEqualToString:@""]) {
 [self.dataDict setValue:textField.text forKey:textField.accessibilityLabel];
 }
 
 }
 if (!isKeyBoardShow) {
 [UIView animateWithDuration:0.5 animations:^{
 self.mainTableView.frame=CGRectMake(0, 0, 320, 420);
 } ];
 }
 
 
 
 }
 
 
 - (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
 {
 if (!isKeyBoardShow) {
 isKeyBoardShow=YES;
 [UIView animateWithDuration:0.3 animations:^{
 self.mainTableView.frame=CGRectMake(0, 0, 320, 420-215);
 //            NSIndexPath* indexPath=   [mainTableView indexPathForRowAtPoint:[textField convertPoint:CGPointMake(10, 10) toView:self.mainTableView]];        
 //            [self.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
 
 } ];
 }
 
 NSIndexPath* indexPath=   [mainTableView indexPathForRowAtPoint:[textField convertPoint:CGPointMake(10, 10) toView:self.mainTableView]];        
 [self.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
 
 } 
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType==UIReturnKeyNext) {
        
        int tag=textField.tag+1;
        NSLog(@"%d",textField.tag);
//        if(tag==114)
//        {
//            [self.view endEditing:YES];
//            return YES;
//        }
//        
        for (UIView* subView in self.mainTableView.subviews) {
            if ([subView isKindOfClass:[UITableViewCell class]]) {
                
                UIView* v=[subView viewWithTag:tag];
                if (v&& [v isKindOfClass:[UITextField class]]) {
                    [(UITextField*)v becomeFirstResponder];
                    return YES;
                }
                
            }
        }
    }
    
    return YES;
}
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWasShown:)
//                                                 name:UIKeyboardDidChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
    
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    isKeyBoardShow=YES;
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    mainTableView.contentInset = contentInsets;
    mainTableView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    //CGRect aRect = mainTableView.frame;
    
    NSIndexPath* indexPath=   [mainTableView indexPathForRowAtPoint:[activeField convertPoint:CGPointMake(10, 10) toView:self.mainTableView]];        
    [self.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    
    //    aRect.size.height -= kbSize.height;
    //    if (!CGRectContainsPoint(aRect, [activeField convertPoint:CGPointMake(0, 0) toView:mainTableView]) ) {
    //        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y+kbSize.height);
    //        [mainTableView setContentOffset:scrollPoint animated:YES];
    //    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    isKeyBoardShow=NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        mainTableView.contentInset = contentInsets;
        mainTableView.scrollIndicatorInsets = contentInsets;
    }];
    //    UIView animateWithDuration:0 animations:^{
    //        <#code#>
    //    } completion:^(BOOL finished) {
    //        
    //    }
    //    
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
    
    if (isKeyBoardShow) {
        
        NSIndexPath* indexPath=   [mainTableView indexPathForRowAtPoint:[activeField convertPoint:CGPointMake(10, 10) toView:self.mainTableView]];        
        [self.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue]<5.0) {
        
        NSIndexPath* indexPath=   [mainTableView indexPathForRowAtPoint:[textField convertPoint:CGPointMake(10, 10) toView:self.mainTableView]];
        [self.dataDict setValue:textField.text forKey: [[[self.tableArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"id"]];
        
    }
    else {
        
        if (textField.accessibilityLabel&& ![textField.accessibilityLabel isEqualToString:@""]) {
            [self.dataDict setValue:textField.text forKey:textField.accessibilityLabel];
        }
        
    }

}
@end

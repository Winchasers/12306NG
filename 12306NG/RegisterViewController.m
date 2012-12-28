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
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"用  户  名",@"title",@"name",@"id",@"Sun",@"value",@"6-30位(字母、数字均可)",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"密       码",@"title",@"pwd",@"id",@"Sun",@"value",@"至少6位(字母、数字均可)",@"mask" ,nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"确认密码",@"title",@"pwd2",@"id",@"Sun",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"查询密码",@"title",@"qpwd",@"id",@"Sun",@"value",@"6位数字语音查询密码",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"确认密码",@"title",@"qpwd2",@"id",@"Sun",@"value",@"sss",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"验  证  码",@"title",@"code",@"id",@"Sun",@"value",@"sss",@"mask", nil],
                          nil],
                         
                         
                         [NSMutableArray arrayWithObjects:
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"手机号码",@"title",@"phone",@"id",@"Sun",@"value",@"sss",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"电子邮件",@"title",@"email",@"id",@"Sun",@"value",@"sss",@"mask", nil],
                          nil],
                         
                         
                         
                         [NSMutableArray arrayWithObjects:
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"姓       名",@"title",@"idName",@"id",@"Sun",@"value",@"sss",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"性       别",@"title",@"sex",@"id",@"Sun",@"value",@"sss",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"出生日期",@"title",@"birthday",@"id",@"Sun",@"value",@"sss",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"证件类型",@"title",@"idType",@"id",@"Sun",@"value",@"sss",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"证件号码",@"title",@"idNumber",@"id",@"Sun",@"value",@"sss",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"旅客类型",@"title",@"userType",@"id",@"Sun",@"value",@"sss",@"mask", nil],
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
    
    
    isKeyBoardShow=NO;
    [self.view endEditing:YES];
    
    
    
//    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:self.dataDict.debugDescription delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];
    
    //NSLog(@"%@",self.dataDict);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor=[UIColor clearColor];
    self.title=NSLocalizedString(@"我的抢票助手", nil);
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
    
    static NSString *CellIdentifier = @"Cell_ABC";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier] ;
    if (cell==nil) {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        
//        if (indexPath.section==2) {
//            UISwitch* inputMethod=[[UISwitch alloc] initWithFrame:CGRectMake(210, 9, 100, 50)];
//            //[inputMethod setOn:[GlobalClass sharedClass].isEnableBaiduInput animated:YES];
//            [inputMethod addTarget:self action:@selector(swithChanged:) forControlEvents:UIControlEventValueChanged];
//            cell.accessoryView=inputMethod;
//            [inputMethod release];
//        }
        
    } 
    NSMutableDictionary* dataDic=[[tableArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text=[dataDic valueForKey:@"title"];
    
    
    // if (indexPath.section==0&&indexPath.row==0) {
    
    
    UITextField* textName=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    
    textName.accessibilityLabel=[dataDic valueForKey:@"id"];    
    textName.tag=tagIndex++;
    textName.placeholder=[dataDic valueForKey:@"mask"];
    textName.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    textName.delegate=self;
    textName.returnKeyType=UIReturnKeyNext;
    cell.accessoryView=textName;
    
    NSLog(@"%d",textName.tag);
    
    
    
    
    
    
    // }
    
    
    
    return cell ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView* v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    
    UILabel* lb=[[UILabel alloc] initWithFrame:CGRectMake(30, 10, tableView.frame.size.width, 30)];
    lb.backgroundColor=[UIColor clearColor];
    lb.textColor=[UIColor whiteColor];
    
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType==UIReturnKeyNext) {
        
        NSLog(@"%d",textField.tag);
        
        for (UIView* subView in self.mainTableView.subviews) {
            if ([subView isKindOfClass:[UITableViewCell class]]) {
                
                UIView* v=[subView viewWithTag:textField.tag+1];
                if (v&& [v isKindOfClass:[UITextField class]]) {
                    [(UITextField*)v becomeFirstResponder];
                    return YES;
                }
                
            }
        }
    }
    return YES;
}
@end

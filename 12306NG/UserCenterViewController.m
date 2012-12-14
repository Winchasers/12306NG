//
//  UserCenterViewController.m
//  12306NG
//
//  Created by Zhao Yang on 12/13/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import "UserCenterViewController.h"


//Section0
#import "UserInfomationViewController.h"

//Section1
#import "QueryTicketViewController.h"
#import "OrderListViewController.h"


//Section2
#import "ResidualTicketInformViewController.h"

//Section3
#import "FeedbackViewController.h"
#import "AboutUsViewController.h"



@interface UserCenterViewController ()
@property(nonatomic,retain)NSMutableArray* tableArray;
@property(nonatomic,retain)UITableView* mainTableView;

@end

@implementation UserCenterViewController
@synthesize tableArray,mainTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([[UIScreen mainScreen] bounds].size.height == 568.0) {
        self = [super initWithNibName:@"UserCenterViewController_ip5" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
        self.tableArray=[NSMutableArray arrayWithObjects:
                         [NSMutableArray arrayWithObjects:
                          NSLocalizedString(@"我的资料",nil),
                          NSLocalizedString(@"同行旅客管理",nil),nil],
                         [NSMutableArray arrayWithObjects:
                          NSLocalizedString(@"车票查询",nil),
                          NSLocalizedString(@"我的订单",nil),nil],
                         
                         [NSMutableArray arrayWithObjects:
                          NSLocalizedString(@"余票通知",nil),
                          NSLocalizedString(@"订单通知",nil),nil],
                         
                         [NSMutableArray arrayWithObjects:
                          NSLocalizedString(@"意见反馈",nil),
                          NSLocalizedString(@"软件评分",nil),
                          NSLocalizedString(@"软件升级",nil),
                          NSLocalizedString(@"关于我们",nil),nil],
                         nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=NSLocalizedString(@"我的抢票助手", nil);
    
    CGRect rect=CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height-44);
    self.mainTableView=[[[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped] autorelease]  ;    
    [self.view addSubview:self.mainTableView];
    mainTableView.backgroundColor=[UIColor clearColor];
    mainTableView.backgroundView=nil;
    mainTableView.dataSource=(id<UITableViewDataSource>)self;
    mainTableView.delegate=(id<UITableViewDelegate>)self;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        
        if (indexPath.section==2) {
            UISwitch* inputMethod=[[UISwitch alloc] initWithFrame:CGRectMake(210, 9, 100, 50)];
            //[inputMethod setOn:[GlobalClass sharedClass].isEnableBaiduInput animated:YES];
            [inputMethod addTarget:self action:@selector(swithChanged:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView=inputMethod;
            [inputMethod release];
        }
        
    } 
    cell.textLabel.text=[[tableArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    

    
    return cell ;
}

#pragma mark -
#pragma mark  tableViewAction

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
/***********************************************************************/     
    if (indexPath.section==0&&indexPath.row==0) 
    {
        UserInfomationViewController* controller=[[UserInfomationViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
    else if (indexPath.section==0&&indexPath.row==1)
    {
 
    }
/***********************************************************************/   
    if (indexPath.section==1&&indexPath.row==0) 
    {
        QueryTicketViewController* controller=[[QueryTicketViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
    else if (indexPath.section==1&&indexPath.row==1)
    {
        OrderListViewController* controller=[[OrderListViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }
/***********************************************************************/ 
    if (indexPath.section==2&&indexPath.row==0) 
    {
        ResidualTicketInformViewController* controller=[[ResidualTicketInformViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
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
        FeedbackViewController* controller=[[FeedbackViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
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
        AboutUsViewController* controller=[[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];

    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if ([tableView cellForRowAtIndexPath:indexPath].accessoryType!=UITableViewCellAccessoryNone) {        
        [tableView.delegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)swithChanged:(UISwitch*)sender
{
    
}
@end

//
//  UserInfomationViewController.m
//  12306NG
//
//  Created by Zhao Yang on 12/13/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import "UserInfomationViewController.h"
#import "NGUserService.h"
#import <QuartzCore/QuartzCore.h>

@interface UserInfomationViewController ()
@property(nonatomic,retain)NSMutableArray* tableArray;
@property(nonatomic,retain)UITableView* mainTableView;
@property(nonatomic,retain)NSMutableDictionary* dataDict;
@end

@implementation UserInfomationViewController
@synthesize userInfoKey;

@synthesize tableArray,mainTableView;

@synthesize dataDict;

-(id)initWithUserInfoKey:(UserInfoKey)userInfoKey_
{
    
    self=[super init];
    if (self) {
        // Custom initialization
        self.userInfoKey=userInfoKey_;
    }
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([[UIScreen mainScreen] bounds].size.height == 568.0) {
        self = [super initWithNibName:@"UserInfomationViewController_ip5" bundle:nibBundleOrNil];
    }else{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
        self.tableArray=[NSMutableArray arrayWithObjects:
                         [NSMutableArray arrayWithObjects:
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"姓    名",@"title",@"name",@"id",@"",@"value",@"",@"mask",nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"性别",@"title",@"sex",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"出生日期",@"title",@"birthday",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"证件类型",@"title",@"idType",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"证件号码",@"title",@"idNumber",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"手机号码",@"title",@"phone",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"电子邮箱",@"title",@"email",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"旅客类型",@"title",@"userType",@"id",@"",@"value",@"",@"mask", nil],
                          
                          nil],nil];
        
        
        self.dataDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                       @"张三",@"name",
                       @"M",@"sex",
                       @"1980-11-11",@"birthday",
                       @"1",@"idType",
                       @"123456789012345678",@"idNumber",
                       @"110",@"phone",
                       @"110@1.com",@"email",
                       @"0",@"userType",
                       nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"个人资料管理";
    
    
    
    
    if (self.userInfoKey==UserInfoMe) {
        self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editContent)] autorelease];
    }
    
    segControlTop=[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"我的资料",@"同行旅客", nil]];
    segControlTop.frame=CGRectMake(10, 15, 300, 30);
    segControlTop.segmentedControlStyle=UISegmentedControlStylePlain;
    segControlTop.selectedSegmentIndex=self.userInfoKey;
    
    [self.view addSubview:segControlTop];
    
    
    CGRect rect=CGRectMake(0, 50, self.view.bounds.size.width,420-50);
    self.mainTableView=[[[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped] autorelease]  ;    
    //[self.view addSubview:self.mainTableView];
    mainTableView.backgroundColor=[UIColor clearColor];
    mainTableView.backgroundView=nil;
    mainTableView.dataSource=(id<UITableViewDataSource>)self;
    mainTableView.delegate=(id<UITableViewDelegate>)self;
    mainTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
    
    loadingView=[[UIView alloc] initWithFrame:CGRectInset(rect, 10, 10)];
    [self.view addSubview:loadingView];
    loadingView.backgroundColor=[UIColor whiteColor];
    loadingView.layer.cornerRadius=8;
    
    UIActivityIndicatorView* activity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.center=CGPointMake(loadingView.frame.size.width/2, loadingView.frame.size.height/2);
    [loadingView addSubview:activity];
    [activity startAnimating];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    
    self.dataDict=[[NGUserService sharedService] getUserInfo];
    
    if (self.dataDict) {
        
        loadingView.layer.opacity=1;
        mainTableView.layer.opacity=0;
        [self.view addSubview:mainTableView];
        
        [UIView animateWithDuration:0.5 animations:^{
            loadingView.layer.opacity=0;
            mainTableView.layer.opacity=1;
        } completion:^(BOOL finished) {
            [loadingView removeFromSuperview];
        }];
        
        
        
        //        
        //        
    }else {
        
        for (UIView* v in [loadingView subviews]) {
            [v removeFromSuperview];
        }
        UILabel* lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        lable.center=CGPointMake(loadingView.frame.size.width/2, loadingView.frame.size.height/2);
        lable.text=@"暂无数据";
        [loadingView addSubview:lable];
    }
    
    
    
}
-(void)editContent
{
    [mainTableView setEditing:!mainTableView.isEditing];
    if (mainTableView.isEditing) {
        self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editContent)] autorelease];
        
        [UIView transitionWithView:self.view duration:0.6 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
        
    }else {
        self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editContent)] autorelease];
        
        [self editEnd];
        [self.view endEditing:YES];
        [mainTableView reloadData];
        
        //        sleep(1);
        
        [UIView transitionWithView:self.view duration:0.6 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        } completion:^(BOOL finished)
         {
             
         }
         ];
    }
    
    //   
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);
//{
//    
//}

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return NO;
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
    
    NSMutableDictionary* cellDict=[[self.tableArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text=[cellDict objectForKey:@"title"];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    //cell.detailTextLabel.text=[self.dataDict objectForKey:[cellDict objectForKey:@"id"]];;
    
    UILabel* labelValue=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];     
    //labelName.textAlignment=UITextAlignmentCenter;
    labelValue.text=[self.dataDict objectForKey:[cellDict objectForKey:@"id"]];
    labelValue.backgroundColor=[UIColor clearColor];
    cell.accessoryView=labelValue;
    [labelValue release];
    
    
    NSString* itemID=[cellDict objectForKey:@"id"];
    if ([itemID isEqualToString:@"sex"]) {
        
        
        UISegmentedControl* segSexControl=[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"男",@"女", nil]];
        segSexControl.frame=CGRectMake(10, 15, 180, 30);
        segSexControl.segmentedControlStyle=UISegmentedControlStylePlain;
        [segSexControl addTarget:self action:@selector(changeSex:) forControlEvents:UIControlEventValueChanged];
        segSexControl.selectedSegmentIndex=[[self.dataDict objectForKey:[cellDict objectForKey:@"id"]] isEqualToString:@"男"]?0:1;
        cell.editingAccessoryView=segSexControl;
        //[segControl release];
        
        
    }
    else if ([itemID isEqualToString:@"birthday"]||[itemID isEqualToString:@"idType"]||[itemID isEqualToString:@"userType"])  {
        
        
        
        UIView* v=[[UIView alloc] initWithFrame:CGRectMake(0, 0,200, 30)];
        
        UILabel* labelValue=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];     
        labelValue.textAlignment=UITextAlignmentRight;
        labelValue.textColor=[UIColor greenColor];
        labelValue.text=[self.dataDict objectForKey:[cellDict objectForKey:@"id"]];
        labelValue.backgroundColor=[UIColor clearColor];
        [v addSubview:labelValue];
        [labelValue release];
        
        UIButton* btn=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        btn.frame=CGRectMake(170, 0, 30, 30);
        [v addSubview:btn];
        
        
        
        cell.editingAccessoryView=v;
        [v release];
        
    }
    
    else {
        
        
        
        UITextField* textName=[[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)]; 
        //textName.borderStyle=UITextBorderStyleLine;
        textName.borderStyle=UITextBorderStyleBezel;
        textName.textColor=[UIColor greenColor];
        textName.accessibilityLabel=[cellDict objectForKey:@"id"];
        textName.text=[self.dataDict objectForKey:[cellDict objectForKey:@"id"]];
        textName.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        cell.editingAccessoryView=textName;
        textName.delegate=self;
        [textName release];
    }
    
    return cell ;
}


-(void)changeSex:(UISegmentedControl*)segControl
{
    if(segControl.selectedSegmentIndex==0)
    {
        //segControl.selectedSegmentIndex=1;
        [self.dataDict setObject:@"男" forKey:@"sex"];
        
    }else {
        //segControl.selectedSegmentIndex=0;
        [self.dataDict setObject:@"女" forKey:@"sex"];
    }
    //[mainTableView setNeedsDisplay];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!isKeyBoardShow) {
        isKeyBoardShow=YES;
        
        segControlTop.hidden=YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.mainTableView.frame=CGRectMake(0, 0, 320, 200);
        }];
        
    }
    NSIndexPath* indexPath=   [mainTableView indexPathForRowAtPoint:[textField convertPoint:CGPointMake(10, 10) toView:self.mainTableView]];        
    [self.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
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
    
    
    
}

-(void)editEnd
{
    
    
    segControlTop.hidden=NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.mainTableView.frame=CGRectMake(0, 50, self.view.bounds.size.width,420-50); 
    } ];
    
    isKeyBoardShow =NO;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    [segControlTop release];
}
@end

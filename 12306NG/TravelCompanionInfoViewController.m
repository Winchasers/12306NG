//
//  TravelCompanionInfoViewController.m
//  12306NG
//
//  Created by Lei Sun on 12/31/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import "TravelCompanionInfoViewController.h"
#import "UserInfomationViewController.h"
#import "NGUserService.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"

@interface TravelCompanionInfoViewController ()
@property(nonatomic,retain)NSMutableArray* tableArray;
@property(nonatomic,retain)UITableView* mainTableView;
@property(nonatomic,retain)NSMutableDictionary* dataDict;
@property(nonatomic,retain)UIView* loadingView;
@end

@implementation TravelCompanionInfoViewController

@synthesize tableArray,mainTableView;

@synthesize dataDict;

@synthesize titleName;

@synthesize userDataDict;
@synthesize loadingView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tableArray=[NSMutableArray arrayWithObjects:
                         [NSMutableArray arrayWithObjects:
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"姓    名",@"title",@"idName",@"id",@"",@"value",@"",@"mask",nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"性    别",@"title",@"sex",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"出生日期",@"title",@"birthday",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"证件类型",@"title",@"idType",@"id",@"1",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"证件号码",@"title",@"idNumber",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"手机号码",@"title",@"phone",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"电子邮箱",@"title",@"email",@"id",@"",@"value",@"",@"mask", nil],
                          [NSMutableDictionary dictionaryWithObjectsAndKeys:@"旅客类型",@"title",@"userType",@"id",@"1",@"value",@"",@"mask", nil],
                          
                          nil],nil];
        
        
        self.dataDict=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                       @"张三",@"idName",
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
	// Do any additional setup after loading the view.
    
   
    self.title= [userDataDict objectForKey:@"passenger_name"];
    [self showCustomBackButton];
    
    CGRect rect=CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height-44);
    
    self.mainTableView=[[[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped] autorelease]  ;    
    //[self.view addSubview:self.mainTableView];
    mainTableView.backgroundColor=[UIColor clearColor];
    mainTableView.backgroundView=nil;
    mainTableView.dataSource=(id<UITableViewDataSource>)self;
    mainTableView.delegate=(id<UITableViewDelegate>)self;
    mainTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
    CGRect rect2=rect;    
    rect2.size.height-=0;
    self.loadingView=[[UIView alloc] initWithFrame:CGRectInset(rect2, 10, 10)];    
    loadingView.backgroundColor=[UIColor whiteColor];
    loadingView.layer.cornerRadius=8;

    
    [self registerForKeyboardNotifications];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView* v in [loadingView subviews]) {
        [v removeFromSuperview];
    }
    UIActivityIndicatorView* activity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.center=CGPointMake(loadingView.frame.size.width/2, loadingView.frame.size.height/2);
    [loadingView addSubview:activity];
    [activity startAnimating];
    
    [self.view addSubview:loadingView];
    loadingView.layer.opacity=1;    
    self.navigationItem.rightBarButtonItem=nil;
}
-(void)viewDidAppear:(BOOL)animated
{
    
    
   [self.view addSubview:loadingView];
    [self loadMainTableView];
    
}

-(NSMutableDictionary*)parseDataDic
{
    
//    {
//        address = "";
//        "born_date" =         {
//            date = 1;
//            day = 4;
//            hours = 0;
//            minutes = 0;
//            month = 0;
//            seconds = 0;
//            time = "-28800000";
//            timezoneOffset = "-480";
//            year = 70;
//        };
//        code = 1;
//        "country_code" = CN;
//        email = "dev123456789@163.com";
//        "first_letter" = IPHONETEST;
//        isUserSelf = Y;
//        "mobile_no" = 18900000001;
//        "old_passenger_id_no" = "";
//        "old_passenger_id_type_code" = "";
//        "old_passenger_name" = "";
//        "passenger_flag" = 0;
//        "passenger_id_no" = 110101200001010010;
//        "passenger_id_type_code" = 1;
//        "passenger_id_type_name" = "\U4e8c\U4ee3\U8eab\U4efd\U8bc1";
//        "passenger_name" = "\U706b\U8f66\U7968";
//        "passenger_type" = 1;
//        "passenger_type_name" = "\U6210\U4eba";
//        "phone_no" = "";
//        postalcode = "";
//        recordCount = 1;
//        "sex_code" = M;
//        "sex_name" = "\U7537";
//        studentInfo = "<null>";
//    }
    NSDictionary* birthdayDict=[self.userDataDict objectForKey:@"born_date"];
    int year=[[birthdayDict objectForKey:@"year"] intValue]+1900;
    
    NSString* birthday=[NSString stringWithFormat:@"%d-%@-%@",year,[birthdayDict objectForKey:@"month" ],[birthdayDict objectForKey:@"day"]];

    
     return  [NSMutableDictionary dictionaryWithObjectsAndKeys:
                   [self.userDataDict  objectForKey:@"passenger_name"],@"idName",
                   [self.userDataDict  objectForKey:@"passenger_name"],@"idNameOld",
                   [self.userDataDict  objectForKey:@"sex_code"],@"sex",
                   birthday,@"birthday",
                   [self.userDataDict  objectForKey:@"passenger_id_type_code"],@"idType",
                   [self.userDataDict  objectForKey:@"passenger_id_type_code"],@"idTypeOld",
                   [self.userDataDict  objectForKey:@"passenger_id_no"],@"idNumber",
                [self.userDataDict  objectForKey:@"passenger_id_no"],@"idNumberOld",
                   [self.userDataDict  objectForKey:@"mobile_no"],@"phone",
                   [self.userDataDict  objectForKey:@"email"],@"email",
                   [self.userDataDict  objectForKey:@"passenger_type_name"],@"userTypeName",
                   [self.userDataDict  objectForKey:@"passenger_type"],@"userType",
                   nil];
    
    
    
    
}


-(void)loadMainTableView
{
    dispatch_async(dispatch_queue_create("getListWithUsers", nil), ^{
        
        
        
        if (self.userDataDict) {
            self.dataDict= [self parseDataDic];
        }else
        {
          self.dataDict=[[NGUserService sharedService] getUserInfo];
        }
        dispatch_async(dispatch_get_main_queue(),^{
            if (self.dataDict) {
                self.navigationItem.rightBarButtonItem=self.editButtonItem;
                loadingView.layer.opacity=1;
                mainTableView.layer.opacity=0;
                [mainTableView reloadData];
                [self.view addSubview:mainTableView];
                
                [UIView animateWithDuration:0.5 animations:^{
                    loadingView.layer.opacity=0;
                    mainTableView.layer.opacity=1;
                } completion:^(BOOL finished) {
                    [loadingView removeFromSuperview];
                }];
                
            }else {
                
                for (UIView* v in [loadingView subviews]) {
                    [v removeFromSuperview];
                }
                
                UITapGestureRecognizer* tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToReLoadDatas:)];                
                [loadingView addGestureRecognizer:tapGesture];
                [tapGesture release];
                UILabel* lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
                lable.center=CGPointMake(loadingView.frame.size.width/2, loadingView.frame.size.height/2);
                lable.text=@"暂无数据，点击重新加载";
                lable.numberOfLines=2;
                lable.textAlignment=UITextAlignmentCenter;
                [loadingView addSubview:lable];
            }
            //isMainTableLoaded=YES;
        });
    });
    
}

-(void)editContent
{
    
   
    //selectedSegmentIndex
    if (!mainTableView.isEditing) {
        //[segControlTop setEnabled:NO];
         [mainTableView setEditing:!mainTableView.isEditing animated:NO];
        self.navigationItem.rightBarButtonItem=self.editButtonItem;
        
//        self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(editContent)] autorelease];

        
             [UIView transitionWithView:self.view duration:0.6 options:UIViewAnimationOptionTransitionFlipFromRight animations:
             nil completion:nil];
//            mainTableView.frame=CGRectMake(0, 0, mainTableView.frame.size.width, mainTableView.frame.size.height+50);
         
    }else {
        //[segControlTop setEnabled:YES];
        
//        self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(editContent)] autorelease];
//        
//        self.navigationItem.rightBarButtonItem=self.editButtonItem;//
        
        
        
        
        
        [self.view endEditing:YES];
        
        MBProgressHUD* HUD=[[MBProgressHUD alloc] initWithView:self.view];
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = @"  提交中，请稍后...    ";
        HUD.margin = 30.f;
        HUD.yOffset = -45.f;
        [self.view addSubview:HUD];
        [HUD showWhileExecuting:@selector(doRequestData) onTarget:self withObject:nil animated:YES];
        
        [HUD release];

        
        
    }
    //   
}



-(void)doRequestData
{
    NSString* ResponeString= [[NGUserService sharedService] modifyPassengerInfo:self.dataDict];
    NSRegularExpression* regexAlert=[[NSRegularExpression alloc] initWithPattern:@"var message = [\"](.*)[\"]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult* rAlert=  [regexAlert firstMatchInString:ResponeString options:0 range:(NSRange){0,ResponeString.length}];
    [regexAlert release];
    
    if (rAlert.range.length>0) {
        
        NSString* msg=[ResponeString substringWithRange:(NSRange){rAlert.range.location+15,rAlert.range.length-15-1}];
        if (![msg isEqualToString:@""]) {
            
            
            
            if ([msg rangeOfString:@"成功"].length>0) {
                if (self.navigationController.childViewControllers&&[self.navigationController.viewControllers count]>1) {
                    UserInfomationViewController* controller=(UserInfomationViewController*)[self.navigationController.viewControllers objectAtIndex:1];
                    if (controller) {
                        controller.isNeedsToReLoadWhileViewWillAppear=YES;
                    }
                    
                }
                
            }
            
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
           // return;
            
        }
    }
    
     [mainTableView setEditing:!mainTableView.isEditing animated:NO];
    [mainTableView reloadData];
    
    self.navigationItem.rightBarButtonItem=self.editButtonItem;
    
    //mainTableView.frame=CGRectMake(0, 50, mainTableView.frame.size.width, mainTableView.frame.size.height-50);
    [UIView transitionWithView:self.view duration:0.6 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
    

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

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
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
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
            segSexControl.selectedSegmentIndex=[[self.dataDict objectForKey:[cellDict objectForKey:@"id"]] isEqualToString:@"M"]?0:1;
            cell.editingAccessoryView=segSexControl;
            
            //[segControl release];
            
            UILabel* labelValue=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
            //labelName.textAlignment=UITextAlignmentCenter;
            labelValue.text=[[self.dataDict objectForKey:[cellDict objectForKey:@"id"]] isEqualToString:@"M"]?@"男":@"女";
            labelValue.backgroundColor=[UIColor clearColor];
            cell.accessoryView=labelValue;
            [labelValue release];
            
            
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
        [self.dataDict setObject:@"M" forKey:@"sex"];
        
    }else {
        [self.dataDict setObject:@"F" forKey:@"sex"];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSIndexPath* indexPath=   [mainTableView indexPathForRowAtPoint:[activeField convertPoint:CGPointMake(10, 10) toView:self.mainTableView]];        
    [self.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)tapToReLoadDatas:(UIGestureRecognizer *)gesture
{
    [self.loadingView removeGestureRecognizer:gesture];     
    for (UIView* v in [loadingView subviews]) {
        [v removeFromSuperview];
    }
    UIActivityIndicatorView* activity=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.center=CGPointMake(loadingView.frame.size.width/2, loadingView.frame.size.height/2);
    [loadingView addSubview:activity];
    [activity startAnimating];
    self.navigationItem.rightBarButtonItem=nil;
    [self loadMainTableView];
}

-(UIBarButtonItem*)editButtonItem
{
    NGCustomButton* subButton=[[NGCustomButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [subButton addTarget:self action:@selector(editContent) forControlEvents:UIControlEventTouchUpInside];
    subButton.titleLabel.text=mainTableView.isEditing?@"完成":@"编辑";
    UIBarButtonItem* btn=[[UIBarButtonItem alloc] initWithCustomView:subButton];
    return [btn autorelease];
}

@end

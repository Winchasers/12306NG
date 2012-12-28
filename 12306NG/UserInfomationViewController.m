//
//  UserInfomationViewController.m
//  12306NG
//
//  Created by Zhao Yang on 12/13/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import "UserInfomationViewController.h"

@interface UserInfomationViewController ()

@end

@implementation UserInfomationViewController
@synthesize userInfoKey;

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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"个人资料管理";
    
    if (self.userInfoKey==UserInfoMe) {
        self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(editContent)] autorelease];
    }
    
    UISegmentedControl* segControl=[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"我的资料",@"同行旅客", nil]];
    segControl.frame=CGRectMake(10, 10, 300, 30);
    segControl.segmentedControlStyle=UISegmentedControlStylePlain;

    [self.view addSubview:segControl];
    
    
    
    
    
    
}
-(void)editContent
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  FeedbackViewController.m
//  12306NG
//
//  Created by Zhao Yang on 12/13/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(UIBarButtonItem*)editButtonItem
{
    NGCustomButton* subButton=[[NGCustomButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [subButton addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    subButton.titleLabel.text=@"发送";
    UIBarButtonItem* btn=[[UIBarButtonItem alloc] initWithCustomView:subButton];
    return [btn autorelease];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"意见反馈";
    
    [self showCustomBackButton];
    
     self.navigationItem.rightBarButtonItem= self.editButtonItem;
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    //[sendButton release];

    // Do any additional setup after loading the view from its nib.
    contentView=[[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 150)];
    contentView.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    contentView.font=[UIFont systemFontOfSize:15];
    contentView.layer.borderWidth=1;
    contentView.layer.cornerRadius=8;
    contentView.delegate=(id<UITextViewDelegate>)self;
    [self.view addSubview:contentView];
    [contentView becomeFirstResponder];
    
    
    UILabel* lb=[[UILabel alloc] initWithFrame:CGRectMake(10, 165, 100, 30)];
    lb.font=[UIFont systemFontOfSize:14];
    lb.backgroundColor=[UIColor clearColor];
    [lb setText:@"联系方式(可选):"];
    [self.view addSubview:lb];
    [lb release];
    
    
    mailOrphone=[[UITextField alloc] initWithFrame:CGRectMake(110+5, 165, self.view.frame.size.width-120-5, 30)];
    mailOrphone.layer.borderWidth=1;
    mailOrphone.font=[UIFont systemFontOfSize:15];
    mailOrphone.layer.borderColor=[[UIColor grayColor] CGColor];
    mailOrphone.layer.cornerRadius=2;
    mailOrphone.backgroundColor=[UIColor whiteColor];
    mailOrphone.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    mailOrphone.placeholder=@"可输入您的邮箱或手机号";
    [self.view addSubview:mailOrphone];

}
-(void)sendClick
{  
    
    NSString *formatString = @"mailto:920043287@qq.com?subject=12306NG&body=%@";
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:formatString,contentView.text]]];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView&&textView.text&&textView.text.length>0) {
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }
    else if(self.navigationItem.rightBarButtonItem.isEnabled)  {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  LoginViewController.h
//  12306NG
//
//  Created by Zhao Yang on 12/13/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    
    NSMutableArray* tableArray;
    NSMutableDictionary* dataDict;
    UITableView* mainTableView;
    
    UITextField* textName;
    UITextField* textPwd;
    UITextField* textCode;
    
    UIButton* imgBtn;
    
    MBProgressHUD* HUD;
    
    BOOL isCodeLoaded;
    
    ASIHTTPRequest* requestImg;
}

@end

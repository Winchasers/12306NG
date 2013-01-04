//
//  UserInfomationViewController.h
//  12306NG
//
//  Created by Zhao Yang on 12/13/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+backButtonAction.h"



typedef enum
{
    UserInfoMe,
    UserInfoOther
}UserInfoKey;


@interface UserInfomationViewController : UIViewController<UITextFieldDelegate>
{
    UserInfoKey userInfoKey;
    
    UIScrollView* mainScrollView;
    
    NSMutableArray* tableArray;
    UITableView* mainTableView;
    BOOL isMainTableLoaded;
    
    
    NSMutableArray* userListArray;
    UITableView* userListTableView;
    BOOL isUserListTableLoaded;
    
    NSMutableDictionary* dataDict;
    
    UISegmentedControl* segControlTop;
    
    
    BOOL isKeyBoardShow;
    
    UIView* loadingView;
    
    UITextField* activeField;
    
    BOOL isNeedsToReLoadWhileViewWillAppear;
    
    

}
-(id)initWithUserInfoKey:(UserInfoKey)userInfoKey;
@property(nonatomic,assign)UserInfoKey userInfoKey;
@property(nonatomic,assign)BOOL isNeedsToReLoadWhileViewWillAppear;
@end

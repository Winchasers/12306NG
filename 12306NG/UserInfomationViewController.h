//
//  UserInfomationViewController.h
//  12306NG
//
//  Created by Zhao Yang on 12/13/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum
{
    UserInfoMe,
    UserInfoOther
}UserInfoKey;


@interface UserInfomationViewController : UIViewController<UITextFieldDelegate>
{
    UserInfoKey userInfoKey;
    NSMutableArray* tableArray;
    UITableView* mainTableView;
    
    NSMutableDictionary* dataDict;
    
    UISegmentedControl* segControlTop;
    
    
    BOOL isKeyBoardShow;
    
    UIView* loadingView;
    
    

}
-(id)initWithUserInfoKey:(UserInfoKey)userInfoKey;
@property(nonatomic,assign)UserInfoKey userInfoKey;
@end

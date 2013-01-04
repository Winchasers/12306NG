//
//  TravelCompanionInfoViewController.h
//  12306NG
//
//  Created by Lei Sun on 12/31/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelCompanionInfoViewController : UIViewController<UITextFieldDelegate>
{
    NSMutableArray* tableArray;
    UITableView* mainTableView;    
    NSMutableDictionary* dataDict;
    
    BOOL isKeyBoardShow;
    
    UIView* loadingView;
    UITextField* activeField;
    
    
    NSMutableDictionary* userDataDict;
    NSString* titleName;
    
}
@property(nonatomic,retain)NSMutableDictionary* userDataDict;
@property(nonatomic,retain)NSString* titleName;

@end

//
//  UIViewController+backButtonAction.m
//  12306NG
//
//  Created by Sun on 1/1/13.
//  Copyright (c) 2013 12306NG. All rights reserved.
//

#import "UIViewController+backButtonAction.h"

@implementation UIViewController (backButtonAction)

-(void)showCustomBackButton
{
    NGBackButton* backButton=[NGBackButton button];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc ] initWithCustomView:backButton] autorelease];;
}
-(void)backButtonActionAnimated:(BOOL)animated
{
    if (self.navigationController) {
        if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
            [self.navigationController popViewControllerAnimated:animated];
        }else if ([self.navigationController respondsToSelector:@selector(dismissModalViewControllerAnimated:)])
        {
            [self.navigationController dismissModalViewControllerAnimated:animated];
        }
    }
}
-(void)backButtonAction
{
    if (self.navigationController) {
        if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([self.navigationController respondsToSelector:@selector(dismissModalViewControllerAnimated:)])
        {
            [self.navigationController dismissModalViewControllerAnimated:YES];
        }
    }
}
@end
//@implementation UINavigationBar (backButtonAction)
//@end

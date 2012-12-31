//
//  UINavigationController+CustomBackgroundColor.m
//  12306NG
//
//  Created by Lei Sun on 12/30/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import "UINavigationController+CustomBackgroundColor.h"
#import <QuartzCore/QuartzCore.h>


@implementation UINavigationController(CustomBackgroundColor)

- (id)init {
    self = [super init];
    if (self) {
        //UIImage *image = [UIImage imageNamed:@"navtop.png"];
        if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
            [self.navigationBar setBackgroundImage:NAV_BG_IMAGE forBarMetrics:UIBarMetricsDefault];
        }
    }
    return self;
}


@end


@implementation UINavigationBar(CustomBackgroundColor)

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        super.backgroundColor=[UIColor clearColor];
//        self.layer.masksToBounds=YES;
//    }
//    return self;
//}

- (void)drawRect:(CGRect)rect {
     //UIImage *image = [UIImage imageNamed:@"navtop.png"];
     //LogInfo(@"rect:%@",NSStringFromCGRect(rect));    
     CGRect rect2=  CGRectMake(0, 0, rect.size.width,NAV_BG_IMAGE.size.height+1);
     [NAV_BG_IMAGE drawInRect:rect2];
}

@end

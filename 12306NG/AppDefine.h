//
//  AppDefine.h
//  12306NG
//
//  Created by Lei Sun on 12/28/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#ifndef _2306NG_AppDefine_h
#define _2306NG_AppDefine_h



#define DEBUG_MODE 0


#define NAV_BG_IMAGE [UIImage imageNamed:@"banner.png"]


//#define MAIN_NAV_COLOR ([UIColor colorWithPatternImage:[UIImage imageNamed:@""]])
//#define MAIN_NAV_COLOR ([UIColor colorWithPatternImage:[UIImage imageNamed:@"bluebutton"]])
#define MAIN_NAV_COLOR ([UIColor blackColor])


#define MAIN_BG_COLOR ([UIColor colorWithPatternImage:[UIImage imageNamed:@"background_black"]])
//#define MAIN_BG_COLOR ([UIColor whiteColor])

#define DEFAULT_SERVER_IP @"127.0.0.1" 
#define DEFAULT_SERVER_PORT @"88"

#define FUNCBARBUTTON(TITLE, SELECTOR) 	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]

#define FUNCIMGBUTTON(FILENAME, SELECTOR) [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:FILENAME] style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]

#define SYSBARBUTTON(ITEM, SELECTOR) [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:ITEM target:self action:SELECTOR] autorelease]


#define SysVersion ([[UIDevice currentDevice].systemVersion floatValue])


#ifndef ScreenHeight
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#endif


#endif

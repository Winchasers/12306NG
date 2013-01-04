//
//  NGCustomButton.m
//  12306NG
//
//  Created by Sun on 1/1/13.
//  Copyright (c) 2013 12306NG. All rights reserved.
//

#import "NGCustomButton.h"

@implementation NGCustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.showsTouchWhenHighlighted=YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor colorWithRed:0x75/255.0 green:0x75/255.0 blue:0x75/255.0 alpha:1] set];
    //    }
    UIBezierPath * squarePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4.];
    [squarePath fill];
    
    [[UIColor whiteColor] set];
    NSString* backStr=self.titleLabel.text;
    UIFont* font=[UIFont systemFontOfSize:15];
    CGSize size= [backStr sizeWithFont:font];
    CGRect newRect= CGRectInset(rect, (rect.size.width-size.width)/2,  (rect.size.height-size.height)/2);
    [backStr drawInRect:newRect withFont:[UIFont systemFontOfSize:15] lineBreakMode:UILineBreakModeWordWrap  alignment:UITextAlignmentCenter];
}


@end

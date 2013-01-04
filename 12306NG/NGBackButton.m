//
//  NGBackButton.m
//  12306NG
//
//  Created by Sun on 1/1/13.
//  Copyright (c) 2013 12306NG. All rights reserved.
//

#import "NGBackButton.h"

#define kTriangleWidth 12

@implementation NGBackButton

+(NGBackButton*)button
{
    return [[[self alloc] initWithFrame:(CGRectMake(0, 0, 55, 30))] autorelease];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsTouchWhenHighlighted=YES;
    }
    return self;
}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];    
//    self.titleLabel.frame=CGRectMake(20, 0, 30, 50);
//    [self addSubview:self.titleLabel];
//    
//}
//
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //[super drawRect:rect];
    //[self.titleLabel drawRect:rect];
    
    
    
//    CGContextRef context=UIGraphicsGetCurrentContext();
//    if (self.isHighlighted&&self.isSelected) {
//        [[UIColor colorWithRed:0xE5/255.0 green:0xE5/255.0 blue:0xE5/255.0 alpha:1] set];
//    }
//    else
//    {
        [[UIColor colorWithRed:0x75/255.0 green:0x75/255.0 blue:0x75/255.0 alpha:1] set];
//    }
    
    CGRect squareRect = CGRectOffset(rect, kTriangleWidth-2, 0);
    squareRect.size.width -= kTriangleWidth-2;
    UIBezierPath * squarePath = [UIBezierPath bezierPathWithRoundedRect:squareRect cornerRadius:4.];
    [squarePath fill];
    
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(2, rect.size.height / 2)];
    [trianglePath addLineToPoint:CGPointMake(kTriangleWidth, 0.)];
    [trianglePath addLineToPoint:CGPointMake(kTriangleWidth, rect.size.height)];
    [trianglePath closePath];
    [trianglePath fill];
    

    [[UIColor whiteColor] set];    
    NSString* backStr=@" 返回 ";
    UIFont* font=[UIFont systemFontOfSize:15];    
    CGSize size= [backStr sizeWithFont:font];    
    CGRect newRect= CGRectInset(squareRect, (squareRect.size.width-size.width)/2,  (squareRect.size.height-size.height)/2);
    [backStr drawInRect:newRect withFont:[UIFont systemFontOfSize:15] lineBreakMode:UILineBreakModeWordWrap  alignment:UITextAlignmentCenter];
}
@end

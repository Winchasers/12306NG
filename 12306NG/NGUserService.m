//
//  NGUserService.m
//  12306NG
//
//  Created by Lei Sun on 12/29/12.
//  Copyright (c) 2012 12306NG. All rights reserved.
//

#import "NGUserService.h"
#import "HTMLParser.h"
#import "ASIDownloadCache.h"


static NGUserService* _sharedNGUserServiceIntance;

@implementation NGUserService


+(id)sharedService
{
    if (_sharedNGUserServiceIntance==nil) {
        _sharedNGUserServiceIntance=[[NGUserService alloc] init];
    }
    return _sharedNGUserServiceIntance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _sharedNGUserServiceIntance=self;
        
    }
    return self;
}

-(UIImage*)getValidateCodeImage
{
    
    //    ASIHTTPRequest* request= [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/passCodeAction.do?rand=sjrand"]] ;
    //    
    //    [request setValidatesSecureCertificate:NO];
    //    [request applyCookieHeader];
    //     request.delegate=(id<ASIHTTPRequestDelegate>)self;
    //    [request startAsynchronous];
    return nil;
    
}
-(BOOL)LoginInWithName:(NSString*)userName andPwd:(NSString*)userPwd andCode:(NSString*)code
{
    return YES;
}
-(void)LoginOut
{
    
}
-(NSMutableArray*)getListWithUsers
{
    sleep(2);
    NSMutableArray* returnArray=[[NSMutableArray alloc] initWithObjects:@"李   四",@"王五五", nil];
    return [returnArray autorelease];;
    
    
}
-(NSMutableDictionary*)getUserInfo 
{
//    sleep(3);
    
     ASIHTTPRequest* request= [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/sysuser/editMemberAction.do?method=initEdit"]];
    
    [request setCachePolicy:ASIUseDefaultCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    
    [request setValidatesSecureCertificate:NO];
    [request addRequestHeader:@"Host" value:@"dynamic.12306.cn"];   
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,*/*"];
    [request addRequestHeader:@"Referer" value:@"https://dynamic.12306.cn/otsweb/sysuser/editMemberAction.do?method=initEdit"];
    [request addRequestHeader:@"Accept-Language" value:@"zh-CN"];
    [request addRequestHeader:@"User-Agent" value:@" Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Accept-Encoding" value:@" gzip, deflate"];
    [request addRequestHeader:@"Host" value:@" dynamic.12306.cn"];
    //[req addRequestHeader:@"Content-Length" value:@" 166"];
    [request addRequestHeader:@"Connection" value:@" Keep-Alive"];
    //[req addRequestHeader:@"Cache-Control" value:@" no-cache"];
    
    
    
    [request startSynchronous];
    
    NSString* responseString=request.responseString;
    
    
    
    
    
    
    NSString* leftString=@"<!--right  -->";
    NSString* rightString=@"<!--right end-->";
    
    responseString=[[responseString componentsSeparatedByString:rightString] objectAtIndex:0];
    NSArray* tmpArray=[responseString componentsSeparatedByString:leftString];
    if (!([tmpArray count]>1)) {
        return nil;
    }
    responseString=[tmpArray objectAtIndex:1];
    
    responseString=[responseString stringByReplacingOccurrencesOfString:@"</th>" withString:@""];
    
    
    NSString* html=[NSString stringWithFormat:@"<html><body>%@</body></html>",responseString];    
    HTMLParser* parse=[[HTMLParser alloc] initWithString:html  error:nil];            
    HTMLNode* body=parse.body;
    
    
    
    
    //     
    //    HTMLParser* parse=[[HTMLParser alloc] initWithString:responseString  error:nil];    
    //    
    //    HTMLNode* body=parse.body;   
    //    [parse release];
    
    
    
    //    NSString* showString=@"";    
    //    NSArray* arr=[body findChildrenOfClass:@"pim_right"];
    //    // [body release];
    //    for (HTMLNode* node in arr) {
    //        showString=[showString stringByAppendingString:[node rawContents]];
    //    }
    //    
    //
    //    
    //    
    //    
    //     NSString* pattern=@"<table width(.*)table>";
    //    
    ////     NSString* pattern=@"[<]table width=[\"]100[%][\"] border=[\"]0[\"] cellspacing=[\"]0[\"] cellpadding=[\"]0[\"] class=[\"]pim_font[\"]>(.*)<[/]table>";
    //    NSRegularExpression* regex=[[NSRegularExpression alloc] initWithPattern:pattern options:   NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators error:nil];
    //    
    //    NSTextCheckingResult* r1=[regex firstMatchInString:responseString options:0 range:(NSRange){0,responseString.length}];
    //     [regex release];
    //    
    //    responseString=[responseString substringWithRange:r1.range];
    //    responseString=[responseString stringByReplacingOccurrencesOfString:@"</th>" withString:@""];
    //    
    //    
    //    NSString* html=[NSString stringWithFormat:@"<html><body>%@</body></html>",responseString];    
    //        HTMLParser* parse=[[HTMLParser alloc] initWithString:html  error:nil];            
    //        HTMLNode* body=parse.body;
    //    
    //        //[parse release];
    //    
    
     NSArray* arr=[body findChildrenOfClass:@"pim_font"];
    
    NSMutableDictionary* dict=[NSMutableDictionary dictionary];
    for (HTMLNode* nodeTable in arr) {
        
        
        HTMLNode* nodeTR =[nodeTable firstChild];
        while (nodeTR&&nodeTR->_node) {
            
            NSArray* tdArray=[nodeTR findChildTags:@"td"];
            if ([tdArray count]>1) {
                
                HTMLNode* nodeTD= [tdArray objectAtIndex:0]; 
                HTMLNode* nodeTD2=[tdArray objectAtIndex:1];
                NSString* name=[nodeTD contents];
                NSString* value=[nodeTD2 contents];
                
                NSString* key=[self getkeyByKeyCNName:name];
                if (key) {
                    if(value==nil)value=@"";
                    [dict setValue:value forKey:key];
                }
            }
            nodeTR=nodeTR.nextSibling;
        }
    }
    
    LogInfo(@"%@",dict);    
    return dict;
    
    
}
-(NSString*)getkeyByKeyCNName:(NSString*)cnName
{
    
    if ([cnName hasPrefix:@"姓名"]) {
        return @"name";
    }else if ([cnName hasPrefix:@"性别"]) {
        return @"sex";
    }else if ([cnName hasPrefix:@"出生日期"]) {
        return @"birthday";
    //}else if ([cnName hasPrefix:@"国家或地区"]) {
    //    return @"";
    }else if ([cnName hasPrefix:@"证件类型"]) {
        return @"idType";}
    else if ([cnName hasPrefix:@"证件号码"]) {
            return @"idNumber";
    }else if ([cnName hasPrefix:@"手机号"]) {
        return @"phone";
    }else if ([cnName hasPrefix:@"电子邮件"]) {
        return @"email";
    }else if ([cnName hasPrefix:@"旅客类型"]) {
        return @"userType";
    }
    return nil;
    
//    @"张三",@"name",
//    @"M",@"sex",
//    @"1980-11-11",@"birthday",
//    @"1",@"idType",
//    @"123456789012345678",@"idNumber",
//    @"110",@"phone",
//    @"110@1.com",@"email",
//    @"0",@"userType",
}

@end

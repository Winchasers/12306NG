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
#import "NSString+SBJSON.h"


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
-(NSString*)getAddPassengerToken
{
//(Request-Line)	POST /otsweb/passengerAction.do?method=initAddPassenger& HTTP/1.1
//Host	dynamic.12306.cn
//User-Agent	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0) Gecko/20100101 Firefox/14.0.1
//Accept	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
//Accept-Language	zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3
//Accept-Encoding	gzip, deflate
//Connection	keep-alive
//Referer	https://dynamic.12306.cn/otsweb/passengerAction.do?method=initUsualPassenger
//Cookie	JSESSIONID=E78564464379ABC2008F9A9E6EC0126E; BIGipServerotsweb=2345926922.62495.0000; BIGipServerotsquery=2363031818.59425.0000
//Content-Type	application/x-www-form-urlencoded
//Content-Length	217
    
    
    ASIFormDataRequest* request= [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/passengerAction.do?method=initAddPassenger"]];    
    [request setCachePolicy:ASIUseDefaultCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    [request setValidatesSecureCertificate:NO];
    [request addRequestHeader:@"Host" value:@"dynamic.12306.cn"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,*/*"];
    [request addRequestHeader:@"Referer" value:@"https://dynamic.12306.cn/otsweb/passengerAction.do?method=initAddPassenger"];
    [request addRequestHeader:@"Accept-Language" value:@"zh-CN"];
    [request addRequestHeader:@"User-Agent" value:@" Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Accept-Encoding" value:@" gzip, deflate"];
    [request addRequestHeader:@"Connection" value:@" Keep-Alive"];

    [request startSynchronous];
    
    
    LogInfo(@"%@",request.responseString);
    
    //<input type="hidden" name="org.apache.struts.taglib.html.TOKEN" value="7464e55fe3305bfd4805669e14bff9ce">
    
    NSString* retString=request.responseString;
    
    NSRegularExpression* regexAlert=[[NSRegularExpression alloc] initWithPattern:@"<input type=[\"]hidden[\"] name=[\"]org.apache.struts.taglib.html.TOKEN[\"] value=[\"](.*)[\"]>" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult* rAlert=  [regexAlert firstMatchInString:retString options:0 range:(NSRange){0,retString.length}];
    [regexAlert release];
    
    if (rAlert.range.length>0) {
        
        int pos=70+1;
        NSString* msg=[retString substringWithRange:(NSRange){rAlert.range.location+pos,rAlert.range.length-pos-2}];
        if (![msg isEqualToString:@""]) {
            
            
//            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//            [alert release];
            return  msg;
            
        }
    }
    
    return @"";
    
    
    


    
    
}

-(NSString*)addPassenger:(NSMutableDictionary*)info
{
//(Request-Line)	POST /otsweb/passengerAction.do?method=savePassenger HTTP/1.1
//    Host	dynamic.12306.cn
//    User-Agent	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0) Gecko/20100101 Firefox/14.0.1
//    Accept	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
//        Accept-Language	zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3
//        Accept-Encoding	gzip, deflate
//        Connection	keep-alive
//        Referer	https://dynamic.12306.cn/otsweb/passengerAction.do?method=initAddPassenger&
//        Cookie	JSESSIONID=E78564464379ABC2008F9A9E6EC0126E; BIGipServerotsweb=2345926922.62495.0000; BIGipServerotsquery=2363031818.59425.0000
//        Content-Type	application/x-www-form-urlencoded
//        Content-Length	798
    
    
//    org.apache.struts.taglib.html.TOKEN=29f4a779679ff03a3cfe549d1294ad7b&name=%E9%93%81%E8%B7%AF&sex_code=M&born_date=1980-11-11&country_code=CN&card_type=1&card_no=110101198011111114&passenger_type=1&mobile_no=18912345678&phone_no=110&email=1%401.11&address=123&postalcode=100000&studentInfo.province_code=11&studentInfo.school_code=&studentInfo.school_name=%E7%AE%80%E7%A0%81%2F%E6%B1%89%E5%AD%97&studentInfo.department=&studentInfo.school_class=&studentInfo.student_no=&studentInfo.school_system=4&studentInfo.enter_year=2002&studentInfo.preference_card_no=&studentInfo.preference_from_station_name=%E7%AE%80%E7%A0%81%2F%E6%B1%89%E5%AD%97&studentInfo.preference_from_station_code=&studentInfo.preference_to_station_name=%E7%AE%80%E7%A0%81%2F%E6%B1%89%E5%AD%97&studentInfo.preference_to_station_code=
    
    
    ASIFormDataRequest* request= [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/passengerAction.do?method=savePassenger"]];
    
    [request setCachePolicy:ASIUseDefaultCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    [request setValidatesSecureCertificate:NO];
    [request addRequestHeader:@"Host" value:@"dynamic.12306.cn"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,*/*"];
    [request addRequestHeader:@"Referer" value:@"https://dynamic.12306.cn/otsweb/passengerAction.do?method=savePassenge"];
    [request addRequestHeader:@"Accept-Language" value:@"zh-CN"];
    [request addRequestHeader:@"User-Agent" value:@" Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Accept-Encoding" value:@" gzip, deflate"];
    //[req addRequestHeader:@"Content-Length" value:@" 166"];
    [request addRequestHeader:@"Connection" value:@" Keep-Alive"];
    //[req addRequestHeader:@"Cache-Control" value:@" no-cache"];
    
    
//    [request addPostValue:@"0" forKey:@"pageIndex"];
//    [request addPostValue:@"7" forKey:@"pageSize"];
//    [request addPostValue:@"请输入汉字或拼音首字母" forKey:@"passenger_name"];
//    
 
    
    
    NSString* strF=@"org.apache.struts.taglib.html.TOKEN=%@&name=%@&sex_code=%@&born_date=%@&country_code=CN&card_type=%@&card_no=%@&passenger_type=%@&mobile_no=%@&phone_no=&email=%@&address=&postalcode=&studentInfo.province_code=11&studentInfo.school_code=&studentInfo.school_name=%E7%AE%80%E7%A0%81%2F%E6%B1%89%E5%AD%97&studentInfo.department=&studentInfo.school_class=&studentInfo.student_no=&studentInfo.school_system=4&studentInfo.enter_year=2002&studentInfo.preference_card_no=&studentInfo.preference_from_station_name=%E7%AE%80%E7%A0%81%2F%E6%B1%89%E5%AD%97&studentInfo.preference_from_station_code=&studentInfo.preference_to_station_name=%E7%AE%80%E7%A0%81%2F%E6%B1%89%E5%AD%97&studentInfo.preference_to_station_code=";
    NSString* str=[NSString stringWithFormat:strF,                   
                   [self getAddPassengerToken],
                   [info objectForKey:@"idName"],
                   [info objectForKey:@"sex"],
                   [info objectForKey:@"birthday"],
                   [info objectForKey:@"idType"],
                   
                   [info objectForKey:@"idNumber"],
                   [info objectForKey:@"userType"],
                   [info objectForKey:@"phone"],
                   
                   [info objectForKey:@"email"]
                   
                   ];
    [request setPostBody:[NSMutableData dataWithData:[str dataUsingEncoding:NSUTF8StringEncoding]]];
    
    [request startSynchronous];

    
    LogInfo(@"%@",request.responseString);
//    dispatch_barrier_sync(dispatch_get_main_queue(), ^{
//        
//        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:request.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
//        
//    });
    
    
    
    return request.responseString;
    
    
}

-(NSString*)getmodifyPassengerToken
{
    //(Request-Line)	POST /otsweb/passengerAction.do?method=initAddPassenger& HTTP/1.1
    //Host	dynamic.12306.cn
    //User-Agent	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0) Gecko/20100101 Firefox/14.0.1
    //Accept	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    //Accept-Language	zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3
    //Accept-Encoding	gzip, deflate
    //Connection	keep-alive
    //Referer	https://dynamic.12306.cn/otsweb/passengerAction.do?method=initUsualPassenger
    //Cookie	JSESSIONID=E78564464379ABC2008F9A9E6EC0126E; BIGipServerotsweb=2345926922.62495.0000; BIGipServerotsquery=2363031818.59425.0000
    //Content-Type	application/x-www-form-urlencoded
    //Content-Length	217
    
    
    ASIFormDataRequest* request= [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/passengerAction.do?method=initModifyPassenger"]];
    [request setCachePolicy:ASIUseDefaultCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    [request setValidatesSecureCertificate:NO];
    [request addRequestHeader:@"Host" value:@"dynamic.12306.cn"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,*/*"];
    [request addRequestHeader:@"Referer" value:@"https://dynamic.12306.cn/otsweb/passengerAction.do?method=initModifyPassenger"];
    [request addRequestHeader:@"Accept-Language" value:@"zh-CN"];
    [request addRequestHeader:@"User-Agent" value:@" Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Accept-Encoding" value:@" gzip, deflate"];
    [request addRequestHeader:@"Connection" value:@" Keep-Alive"];
    
    [request startSynchronous];
    
    
    LogInfo(@"%@",request.responseString);
    
    //<input type="hidden" name="org.apache.struts.taglib.html.TOKEN" value="7464e55fe3305bfd4805669e14bff9ce">
    
    NSString* retString=request.responseString;
    
    NSRegularExpression* regexAlert=[[NSRegularExpression alloc] initWithPattern:@"<input type=[\"]hidden[\"] name=[\"]org.apache.struts.taglib.html.TOKEN[\"] value=[\"](.*)[\"]>" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult* rAlert=  [regexAlert firstMatchInString:retString options:0 range:(NSRange){0,retString.length}];
    [regexAlert release];
    
    if (rAlert.range.length>0) {
        
        int pos=70+1;
        NSString* msg=[retString substringWithRange:(NSRange){rAlert.range.location+pos,rAlert.range.length-pos-2}];
        if (![msg isEqualToString:@""]) {
            
            
            //            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //            [alert show];
            //            [alert release];
            return  msg;
            
        }
    }
    
    return @"";
    
    
    
    
    
    
    
}


-(NSString*)modifyPassengerInfo:(NSMutableDictionary*)info
{
    
 //    (Request-Line)	POST /otsweb/passengerAction.do?method=modifyPassenger HTTP/1.1
//        Host	dynamic.12306.cn
//        User-Agent	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0) Gecko/20100101 Firefox/14.0.1
//        Accept	text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
//        Accept-Language	zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3
//       Accept-Encoding	gzip, deflate
//      Connection	keep-alive
//      Referer	https://dynamic.12306.cn/otsweb/passengerAction.do?method=initModifyPassenger
//      Cookie	JSESSIONID=445A21F199EE2307494C07C75376DA0B; BIGipServerotsweb=2345926922.62495.0000; BIGipServerotsquery=2363031818.59425.0000
//     Content-Type	application/x-www-form-urlencoded
//     Content-Length	902
    
    
//    org.apache.struts.taglib.html.TOKEN=99faf62b2a19e14ea2f22cf8d62f66bc&name=%E5%8E%86%E5%85%89%E6%9E%97&old_name=%E5%8E%86%E5%85%89%E6%9E%97&gender=M&sex_code=M&born_date=1990-02-20&country_code=CN&card_type=1&old_card_type=1&card_no=510322199002204097&old_card_no=510322199002204097&psgTypeCode=3&passenger_type=3&mobile_no=&phone_no=&email=&address=&postalcode=&studentInfo.province_code=42&studentInfo.school_code=11075&studentInfo.school_name=%E4%B8%89%E5%B3%A1%E5%A4%A7%E5%AD%A6&studentInfo.department=&studentInfo.school_class=&studentInfo.student_no=2008114150&schoolSystemDefault=4&studentInfo.school_system=4&enterYearCode=2008&studentInfo.enter_year=2008&studentInfo.preference_card_no=&studentInfo.preference_from_station_name=%E5%AE%9C%E6%98%8C&studentInfo.preference_from_station_code=1307&studentInfo.preference_to_station_name=%E8%87%AA%E8%B4%A1&studentInfo.preference_to_station_code=1713
    
    
    
    ASIFormDataRequest* request= [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/passengerAction.do?method=modifyPassenger"]];
    
    [request setCachePolicy:ASIUseDefaultCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    [request setValidatesSecureCertificate:NO];
    [request addRequestHeader:@"Host" value:@"dynamic.12306.cn"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,*/*"];
    [request addRequestHeader:@"Referer" value:@"https://dynamic.12306.cn/otsweb/passengerAction.do?method=initModifyPassenger"];
    [request addRequestHeader:@"Accept-Language" value:@"zh-CN"];
    [request addRequestHeader:@"User-Agent" value:@" Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Accept-Encoding" value:@" gzip, deflate"];
    //[req addRequestHeader:@"Content-Length" value:@" 166"];
    [request addRequestHeader:@"Connection" value:@" Keep-Alive"];
    //[req addRequestHeader:@"Cache-Control" value:@" no-cache"];
    
    
    
    
    NSString* strF=@"org.apache.struts.taglib.html.TOKEN=%@&name=%@&old_name=%@&gender=%@&sex_code=%@&born_date=%@&country_code=CN&card_type=%@&old_card_type=%@&card_no=%@&old_card_no=%@&psgTypeCode=%@&passenger_type=%@&mobile_no=%@&phone_no=&email=%@&address=&postalcode=&studentInfo.province_code=11&studentInfo.school_code=&studentInfo.school_name=%E7%AE%80%E7%A0%81%2F%E6%B1%89%E5%AD%97&studentInfo.department=&studentInfo.school_class=&studentInfo.student_no=&studentInfo.school_system=4&studentInfo.enter_year=2002&studentInfo.preference_card_no=&studentInfo.preference_from_station_name=%E7%AE%80%E7%A0%81%2F%E6%B1%89%E5%AD%97&studentInfo.preference_from_station_code=&studentInfo.preference_to_station_name=%E7%AE%80%E7%A0%81%2F%E6%B1%89%E5%AD%97&studentInfo.preference_to_station_code=";
    NSString* str=[NSString stringWithFormat:strF,
                   [self getmodifyPassengerToken],
                   [info objectForKey:@"idName"],
                   [info objectForKey:@"idNameOld"],
                   [info objectForKey:@"sex"],
                   [info objectForKey:@"sex"],
                   [info objectForKey:@"birthday"],
                   [info objectForKey:@"idType"],
                   [info objectForKey:@"idTypeOld"],
                   [info objectForKey:@"idNumber"],
                   [info objectForKey:@"idNumberOld"],
                   [info objectForKey:@"userType"],
                   [info objectForKey:@"userType"],
                   [info objectForKey:@"phone"],                   
                   [info objectForKey:@"email"]
                   
                   ];
    [request setPostBody:[NSMutableData dataWithData:[str dataUsingEncoding:NSUTF8StringEncoding]]];
    
    [request startSynchronous];
    
    
    LogInfo(@"%@",request.responseString);
    //    dispatch_barrier_sync(dispatch_get_main_queue(), ^{
    //
    //        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil message:request.responseString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //        [alert show];
    //        [alert release];
    //
    //    });
    
    
    
    return request.responseString;

    
    
    
   // return YES;
    
}
-(NSMutableArray*)getListWithUsers
{
    //return [NSMutableArray array];
//    
//     (Request-Line)	POST /otsweb/passengerAction.do?method=queryPagePassenger HTTP/1.1
//     Host	dynamic.12306.cn
//     User-Agent	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0) Gecko/20100101 Firefox/14.0.1
//     Accept	application/json, text/javascript, */*
//    Accept-Language	zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3
//    Accept-Encoding	gzip, deflate
//    Connection	keep-alive
//    Content-Type	application/x-www-form-urlencoded; charset=UTF-8
//    X-Requested-With	XMLHttpRequest
//    Referer	https://dynamic.12306.cn/otsweb/passengerAction.do?method=initUsualPassenger
//    Content-Length	137
//    Cookie	JSESSIONID=7968B60F9AA9BBA86D6FAD9F2C205A1D; BIGipServerotsweb=2345926922.62495.0000; BIGipServerotsquery=2363031818.59425.0000
//    Pragma	no-cache
//    Cache-Control	no-cache
//
    
//    pageIndex=0&pageSize=7&passenger_name=%E8%AF%B7%E8%BE%93%E5%85%A5%E6%B1%89%E5%AD%97%E6%88%96%E6%8B%BC%E9%9F%B3%E9%A6%96%E5%AD%97%E6%AF%8D
    //PS:passenger_name 为搜索条件，目前为“请输入汉字或拼音首字母”的编码值 
    
    
//    {"recordCount":1,"rows":[{"address":"","born_date":{"date":11,"day":2,"hours":0,"minutes":0,"month":10,"seconds":0,"time":342720000000,"timezoneOffset":-480,"year":80},"code":"1","country_code":"CN","email":"sdfsaf@11.com","first_letter":"LJ","isUserSelf":"Y","mobile_no":"11111111111","old_passenger_id_no":"","old_passenger_id_type_code":"","old_passenger_name":"","passenger_flag":"0","passenger_id_no":"110101198011111114","passenger_id_type_code":"1","passenger_id_type_name":"二代身份证","passenger_name":"张三","passenger_type":"1","passenger_type_name":"成人","phone_no":"","postalcode":"","recordCount":"1","sex_code":"M","sex_name":"男","studentInfo":null}]}
//    
    
    
    
    ASIFormDataRequest* request= [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://dynamic.12306.cn/otsweb/passengerAction.do?method=queryPagePassenger"]];
    
    [request setCachePolicy:ASIUseDefaultCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    
    [request setValidatesSecureCertificate:NO];
    [request addRequestHeader:@"Host" value:@"dynamic.12306.cn"];
    [request addRequestHeader:@"Accept" value:@"application/json, text/javascript, */*"];
    [request addRequestHeader:@"Referer" value:@"https://dynamic.12306.cn/otsweb/passengerAction.do?method=initUsualPassenger"];
    [request addRequestHeader:@"Accept-Language" value:@"zh-CN"];
    [request addRequestHeader:@"X-Requested-With" value:@"XMLHttpRequest"];
    [request addRequestHeader:@"User-Agent" value:@" Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"];
    [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Accept-Encoding" value:@" gzip, deflate"];
    [request addRequestHeader:@"Pragma" value:@"no-cache"];
    [request addRequestHeader:@"Cache-Control" value:@" no-cache"];
    
    [request addPostValue:@"0" forKey:@"pageIndex"];
    [request addPostValue:@"7" forKey:@"pageSize"];
    [request addPostValue:@"请输入汉字或拼音首字母" forKey:@"passenger_name"];
    
    
    [request startSynchronous];
    
    NSString* responseString=request.responseString;

    NSMutableDictionary* retDict=[responseString JSONValue];
    
//    
//    NSMutableArray* returnArray=[NSMutableArray array];
    
    if (retDict) {
       NSMutableArray* arr=   [retDict objectForKey:@"rows"];
        if (arr) {
             LogInfo(@"returnArray:%@",arr);
            //[arr removeLastObject];
            return arr;
            
        }
        
    }
    return [NSMutableArray array];
//
//    
//    
//   returnArray=[[NSMutableArray alloc] initWithObjects:@"李   四",@"王五五",@"王五五",@"王五五",@"王五五",@"王五五",@"王五五", nil];
//    LogInfo(@"returnArray:%@",returnArray);
//    return returnArray;
//    
    
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
        return @"idName";
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

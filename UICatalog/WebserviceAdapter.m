//
//  WebserviceAdapter.m
//  UICatalog
//
//  Created by leo.chang on 12/13/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "WebserviceAdapter.h"

@implementation WebserviceAdapter

- (id)initWithUrl:(NSURL *)url param:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.url = url;
        self.param = dict;
    }
    return self;
}

#pragma mark - Private Methods
- (void)startRequestWithPostMethod:(NSString*)method
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:method];
    //add Header
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
    NSString *param = [self generateParamToString];
    NSData *data = [param dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [request setHTTPBody:data];
    [request setValue:[NSString stringWithFormat:@"%li",[data length]] forHTTPHeaderField:@"Content-Length"];
    
    //開始執行
    self.conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [self.conn start];
}

- (NSString*)generateParamToString
{
    NSArray *allKeys = self.param.allKeys;
    NSMutableString *string = [NSMutableString string];
    for (NSString *key in allKeys)
    {
        [string appendFormat:@"%@=%@", key, self.param[key]];
        if (![key isEqualToString:[allKeys lastObject]])
        {
            [string appendFormat:@"&"];
        }
    }
    //a=XX&b=OO
    return string;
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //fail
    //success
    if ([self.delegate respondsToSelector:@selector(adapter:didFailWithRequestResult:)])
    {
        [self.delegate adapter:self didFailWithRequestResult:self.data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //success
    if ([self.delegate respondsToSelector:@selector(adapter:didSuccessWithRequestResult:)])
    {
        [self.delegate adapter:self didSuccessWithRequestResult:self.data];
    }
}

@end

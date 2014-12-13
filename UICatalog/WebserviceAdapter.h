//
//  WebserviceAdapter.h
//  UICatalog
//
//  Created by leo.chang on 12/13/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WebserviceTag)
{
    WebserviceTagService1,
    WebserviceTagService2,
};

@protocol WebserviceAdapterDelegate;
@interface WebserviceAdapter : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSURLConnection *conn;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSDictionary *param;
@property (nonatomic, weak) id <WebserviceAdapterDelegate> delegate;

- (id)initWithUrl:(NSURL*)url param:(NSDictionary*)dict;

- (void)startRequestWithPostMethod:(NSString*)method;

@end


@protocol WebserviceAdapterDelegate <NSObject>

- (void)adapter:(WebserviceAdapter*)adapter didSuccessWithRequestResult:(NSData*)data;
- (void)adapter:(WebserviceAdapter*)adapter didFailWithRequestResult:(NSData*)data;

@end
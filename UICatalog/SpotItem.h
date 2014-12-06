//
//  SpotItem.h
//  UICatalog
//
//  Created by Leo Chang on 12/4/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpotItem : NSObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *town;
@property (nonatomic, strong) NSString *spot;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSNumber *counter;
@property (nonatomic, strong) NSString *objectId;

@property (nonatomic, assign) BOOL selected;

@end

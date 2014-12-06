//
//  Annotation.h
//  UICatalog
//
//  Created by Leo on 12/6/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *titie;
@property (nonatomic, strong) NSString *content;
@property (nonatomic) NSInteger tag;
@property (nonatomic) NSInteger pinType;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end

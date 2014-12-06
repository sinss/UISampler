//
//  SecondViewController.m
//  UICatalog
//
//  Created by Leo on 10/24/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "SecondViewController.h"
#import "Annotation.h"
#import "SpotItem.h"
#import <Parse/Parse.h>

@interface SecondViewController () <MKMapViewDelegate>

@property (nonatomic, strong) NSArray *hotSpots;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapView];
    
    [self getHotSpots];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addHotSpotsToMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupMapView
{
    CLLocation *center = [[CLLocation alloc] initWithLatitude:24.990243 longitude:121.510873];
    MKCoordinateSpan mapSpan;
    mapSpan.latitudeDelta = 0.05f;
    mapSpan.longitudeDelta = 0.05f;
    MKCoordinateRegion mapRegion;
    mapRegion.center = center.coordinate;
    mapRegion.span = mapSpan;
    self.mapView.region = mapRegion;
    self.mapView.delegate = self;
}



- (MKAnnotationView *) mapView:(MKMapView *)eMapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    Annotation *addTheAnnotation = (Annotation *)annotation;
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[eMapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
    if(pinView == nil) {
        
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        pinView.frame = CGRectMake(0, 0, 25, 25);
        
    }
    else
    {
        pinView.annotation = annotation;
    }
    
    switch (addTheAnnotation.pinType)
    {
        case 0:
            pinView.pinColor = MKPinAnnotationColorRed;
            break;
        case 1:
            pinView.pinColor = MKPinAnnotationColorRed;
            break;
        case 2:
            pinView.pinColor = MKPinAnnotationColorPurple;
            break;
        case 3:
            pinView.image =[UIImage imageNamed:@"pina"];
            break;
    }
    
    pinView.animatesDrop = NO;
    pinView.canShowCallout = YES;
    pinView.calloutOffset = CGPointMake(-5, 5);
    pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return pinView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    Annotation *addTheAnnotation = (Annotation *)view.annotation;
    
    [self processSpotClickWithIndex:addTheAnnotation.tag];
}

- (void)getHotSpots
{
    /*
     Get data from Parse
     */
    PFQuery *query = [PFQuery queryWithClassName:@"HotSpots"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *items, NSError *error){
        if (!error)
        {
            NSMutableArray *spots = [NSMutableArray array];
            //表示查詢成功
            for (PFObject *object in items)
            {
                @autoreleasepool
                {
                    SpotItem *item = [[SpotItem alloc] init];
                    item.spot = object[@"Spot"];
                    item.address = object[@"address"];
                    item.latitude = object[@"latitude"];
                    item.longitude = object[@"longitude"];
                    item.counter = object[@"counter"];
                    item.objectId = object.objectId;
                    [spots addObject:item];
                }
                NSLog(@"spot:%@", object[@"Spot"]);
                NSLog(@"address:%@", object[@"address"]);
            }
            self.hotSpots = [NSArray arrayWithArray:spots];
            
            [self addHotSpotsToMap];
        }
        else
        {
            //查詢失敗
            NSLog(@"error : %@" ,error);
        }
    }];
    //[query findObjectsInBackgroundWithTarget:self selector:@selector(findResult:error:)];
}

- (void)findResult:(NSArray*)items error:(NSError*)error
{
    
}

- (void)addHotSpotsToMap
{
    int counter = 0;
    for (SpotItem *item in _hotSpots)
    {
        Annotation *anno = [[Annotation alloc] initWithCoordinate:[[CLLocation alloc] initWithLatitude:item.latitude.doubleValue longitude:item.longitude.doubleValue].coordinate];
        anno.titie = item.spot;
        anno.content = item.address;
        anno.tag = counter;
        anno.pinType  = 0;
        
        [self.mapView addAnnotation:anno];
        
        counter ++;
    }
}

- (void)processSpotClickWithIndex:(NSInteger)index
{
    SpotItem *item = self.hotSpots[index];
    
    item.counter = [NSNumber numberWithInteger:(item.counter.integerValue + 1)];
    
    PFQuery *query = [PFQuery queryWithClassName:@"HotSpots"];
    [query whereKey:@"objectId" equalTo:item.objectId];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *items, NSError *error){
        
        if (!error)
        {
            PFObject *object = items[0];
            object[@"counter"] = item.counter;
            
            [object saveInBackground];
        }
    
    }];
}

@end

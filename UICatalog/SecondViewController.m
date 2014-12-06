//
//  SecondViewController.m
//  UICatalog
//
//  Created by Leo on 10/24/14.
//  Copyright (c) 2014 Perfectidea. All rights reserved.
//

#import "SecondViewController.h"
#import "Annotation.h"

@interface SecondViewController () <MKMapViewDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapView];
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
    //Annotation *addTheAnnotation = (Annotation *)view.annotation;
    
    
}

- (void)getHotSpots
{
    /*
     Get data from Parse
     */
}

- (void)addHotSpotsToMap
{
    Annotation *anno = [[Annotation alloc] initWithCoordinate:[[CLLocation alloc] initWithLatitude:25.085f longitude:121.524f].coordinate];
    anno.titie = [NSString stringWithFormat:@"Sample"];
    anno.content = [NSString stringWithFormat:@"content"];
    anno.tag = 0;
    anno.pinType  = 0;
    
    [self.mapView addAnnotation:anno];
}

@end

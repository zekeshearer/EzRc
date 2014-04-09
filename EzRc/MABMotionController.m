//
//  MABMotionController.m
//  EzRc
//
//  Created by Zeke Shearer on 3/31/14.
//  Copyright (c) 2014 EZS. All rights reserved.
//

#import "MABMotionController.h"

static CGFloat MABWiggleRoom = .2;

@interface MABMotionController ()

@end

@implementation MABMotionController

+ (MABMotionController *)instance
{
    static MABMotionController *_instance = nil;
    
    if ( !_instance ) {
        _instance = [[MABMotionController alloc] init];
    }
    return _instance;
}

- (id)init
{
    self = [super init];
    if ( self ) {
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.deviceMotionUpdateInterval = .05;
    }
    return self;
}


- (void)startUpdates
{
    NSLog(@"START DEVICE MOTION");
    if ([[[MABMotionController instance] motionManager] isDeviceMotionAvailable] == YES) {
        [[[MABMotionController instance] motionManager] startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
            CGFloat rollRads;
            CGFloat pitchRads;
            CGFloat throttlePercent;
            CGFloat steeringPercent;
    
            if ( error ) {
                return;
            }
            rollRads = deviceMotion.attitude.roll;
            pitchRads = deviceMotion.attitude.pitch;
            
            if ( rollRads < -M_PI_2 - MABWiggleRoom ) {
                //reverse
                throttlePercent = -fabsf(rollRads / (M_PI-MABWiggleRoom));
            } else if ( rollRads > -M_PI_2 + MABWiggleRoom ) {
                //forward
                throttlePercent =  fabsf(rollRads-M_PI_2 / (-M_PI_2+MABWiggleRoom));
            } else {
                throttlePercent = 0;
            }
            
            if ( pitchRads > MABWiggleRoom ) {
                //left
                steeringPercent = pitchRads / (M_PI_2-MABWiggleRoom);
            } else if ( pitchRads < -MABWiggleRoom ) {
                //right
                steeringPercent = pitchRads / (M_PI_2-MABWiggleRoom);
            } else {
                steeringPercent = 0;
            }
            
            throttlePercent = throttlePercent > 1 ? 1 : throttlePercent;
            throttlePercent = throttlePercent < -1 ? -1 : throttlePercent;
            steeringPercent = steeringPercent > 1 ? 1 : steeringPercent;
            steeringPercent = steeringPercent < -1 ? -1 : steeringPercent;
            
            [self.delegate motionController:self didUpdateSteering:steeringPercent throttle:throttlePercent];
            
        }];
    }
}

- (void)stopUpdates
{
    NSLog(@"STOP DEVICE MOTION");
    [[[MABMotionController instance] motionManager] stopDeviceMotionUpdates];
}

@end

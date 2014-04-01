//
//  MABMotionController.m
//  EzRc
//
//  Created by Zeke Shearer on 3/31/14.
//  Copyright (c) 2014 EZS. All rights reserved.
//

#import "MABMotionController.h"

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

@end

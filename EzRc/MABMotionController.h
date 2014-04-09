//
//  MABMotionController.h
//  EzRc
//
//  Created by Zeke Shearer on 3/31/14.
//  Copyright (c) 2014 EZS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@protocol MABMotionControllerDelegate;

@interface MABMotionController : NSObject

+ (MABMotionController *)instance;

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (assign, nonatomic) id<MABMotionControllerDelegate>delegate;

- (void)startUpdates;
- (void)stopUpdates;

@end

@protocol MABMotionControllerDelegate <NSObject>

// these values will be compliant with what the car expects
- (void)motionController:(MABMotionController *)motionController didUpdateSteering:(CGFloat)steering throttle:(CGFloat)throttle;

@end

//
//  MABBluetoothController.h
//  EzRc
//
//  Created by Zeke Shearer on 4/5/14.
//  Copyright (c) 2014 EZS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MABSteeringInputStraight,
    MABSteeringInputLeft,
    MABSteeringInputRight
} MABSteeringInput;

typedef enum {
    MABAccelerationInputNeutral,
    MABAccelerationInputForward,
    MABAccelerationInputReverse
} MABAccelerationInput;

@interface MABBluetoothController : NSObject

+ (MABBluetoothController *)instance;

- (BOOL)isConnected;
- (void)connect;
- (void)disconnect;

//booleanDigital
- (void)updateForSteering:(MABSteeringInput)steeringInput acceleration:(MABAccelerationInput)acceleration;

//PWM
- (void)updateForLeft:(CGFloat)leftImpulse right:(CGFloat)rightImpulse forward:(CGFloat)forwardImpulse back:(CGFloat)backImpulse;

@end

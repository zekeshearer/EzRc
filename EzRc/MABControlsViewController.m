//
//  MABControlsViewController.m
//  EzRc
//
//  Created by Zeke Shearer on 3/31/14.
//  Copyright (c) 2014 EZS. All rights reserved.
//

#import "MABControlsViewController.h"
#import "MABMotionController.h"
#import "MABBluetoothController.h"

@interface MABControlsViewController ()

@property (nonatomic, assign) BOOL isMotioning;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *goButton;

@end

@implementation MABControlsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startUpdates
{
    if ([[[MABMotionController instance] motionManager] isDeviceMotionAvailable] == YES) {
        [[[MABMotionController instance] motionManager] startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {

        }];
    }
}

- (void)stopUpdates
{
    [[[MABMotionController instance] motionManager] stopDeviceMotionUpdates];
}

- (IBAction)toggleMotionSensing:(id)sender
{
    if ( self.isMotioning ) {
        [self stopUpdates];
    } else {
        [self startUpdates];
    }
    self.isMotioning = !self.isMotioning;
}

- (IBAction)toggleDeviceConnection:(id)sender
{
    if ( [[MABBluetoothController instance] isConnected] ) {
        [[MABBluetoothController instance] disconnect];
    } else {
        [[MABBluetoothController instance] connect];
    }
}

//
//
//-(IBAction)sendDigitalOut:(id)sender
//{
//    UInt8 buf[3] = {0x01, 0x00, 0x00};
//    
//    if (swDigitalOut.on)
//        buf[1] = 0x01;
//    else
//        buf[1] = 0x00;
//    
//    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
//    [[MABBluetoothController  instance] writeData:data];
//}
//
///* Send command to Arduino to enable analog reading */
//-(IBAction)sendAnalogIn:(id)sender
//{
//    UInt8 buf[3] = {0xA0, 0x00, 0x00};
//    
//    if (swAnalogIn.on)
//        buf[1] = 0x01;
//    else
//        buf[1] = 0x00;
//    
//    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
//    [ble write:data];
//}
//
//// PWM slide will call this to send its value to Arduino
//-(IBAction)sendPWM:(id)sender
//{
//    UInt8 buf[3] = {0x02, 0x00, 0x00};
//    
//    buf[1] = sldPWM.value;
//    buf[2] = (int)sldPWM.value >> 8;
//    
//    NSData *data = [[NSData alloc] initWithBytes:buf length:3];
//    [ble write:data];
//}

@end

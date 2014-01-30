//
//  MAGViewController.m
//  Mobile Music Template
//
//  Created by Jesse Allison on 10/17/12.
//  Copyright (c) 2012 MAG. All rights reserved.
//

#import "MAGViewController.h"

@interface MAGViewController ()

@end

@implementation MAGViewController

@synthesize enabled;
@synthesize enableButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // _________________ LOAD Pd Patch ____________________
    dispatcher = [[PdDispatcher alloc] init];
    [PdBase setDelegate:dispatcher];
    patch = [PdBase openFile:@"mag_template.pd" path:[[NSBundle mainBundle] resourcePath]];
    if (!patch) {
        NSLog(@"Failed to open patch!");
    }
    enabled = NO;
}

/*
- (void)viewDidUnload
{
    // uncomment for pre-iOS 6 deployment
    [super viewDidUnload];
    [PdBase closeFile:patch];
    [PdBase setDelegate:nil];
}
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// _________________ UI Interactions with Pd Patch ____________________

- (IBAction)randomPitch:(UIButton *)sender {
    [PdBase sendBangToReceiver:@"random_note"];
}

- (IBAction)enable:(UIButton *)sender {
    
    if (enabled) {
        enabled = NO;
        // enableButton.titleLabel = @"Enable";
        [enableButton setTitle:@"Enable" forState:UIControlStateNormal];
        [PdBase sendFloat:0 toReceiver:@"enable"];
    } else {
        enabled = YES;
        [enableButton setTitle:@"Disable" forState:UIControlStateNormal];
        [PdBase sendFloat:1 toReceiver:@"enable"];
    }
    
}
@end
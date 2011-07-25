//
//  CuenkerAppDelegate.m
//  Cuenker
//
//  Created by Niko Felger on 25/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CuenkerAppDelegate.h"

@implementation CuenkerAppDelegate

@synthesize window;
@synthesize suenkButton;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
}

- (IBAction)suenk:(id)sender {
  [self.suenkButton setTitle:@"SÜNKING!!"];
  NSLog(@"received a suenk: message");
}
@end

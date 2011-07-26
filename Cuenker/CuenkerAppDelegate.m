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
@synthesize statusInicator;
@synthesize logView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
}

- (IBAction)suenk:(id)sender {
  if (rsyncTask != nil) [rsyncTask release];

  rsyncTask = [[RsyncTask alloc] initWithController:self];
  [rsyncTask startProcess];
}

- (void)appendOutput:(NSString *)output
{
  [[self.logView textStorage] appendAttributedString: [[[NSAttributedString alloc]
                                                     initWithString: output] autorelease]];
  [self.logView scrollRangeToVisible:NSMakeRange([[self.logView string] length], 0)];
}

- (void)processStarted
{
  [self.logView setString:@""];
  [self.statusInicator setStringValue:@"SÜNKING!!"];
  [self.statusInicator setBackgroundColor:[NSColor redColor]];
}

- (void)processFinished
{
  [self.statusInicator setStringValue:@"done"];
  [self.statusInicator setBackgroundColor:[NSColor greenColor]];
}

@end

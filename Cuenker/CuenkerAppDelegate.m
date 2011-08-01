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
@synthesize watchFSButton;
@synthesize statusInicator;
@synthesize logView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (void)awakeFromNib {
  [self setupStatusItem];
  
  rsyncController = [[RsyncController alloc] initWithTaskController:self];
}

- (IBAction)suenk:(id)sender {
  [rsyncController startRsync];
}

- (IBAction)startStopWatchingFSChanges:(id)sender {
  if([watchFSButton state] == NSOnState) {
    [rsyncController startWatchingFSChanges];
  } else {
    [rsyncController stopWatchingFSChanges];
  }
}

- (void)appendOutput:(NSString *)output
{
  [[logView textStorage] appendAttributedString: [[[NSAttributedString alloc]
                                                     initWithString: output] autorelease]];
  [logView scrollRangeToVisible:NSMakeRange([[self.logView string] length], 0)];
}

- (void)processStarted
{
  [logView setString:@""];
  [statusInicator setStringValue:@"SÜNKING!!"];
  [statusInicator setBackgroundColor:[NSColor redColor]];
  [statusItem setImage:[NSImage imageNamed: @"logo-color.png"]];
}

- (void)processFinished
{
  [statusInicator setStringValue:@"done"];
  [statusInicator setBackgroundColor:[NSColor greenColor]];
  [statusItem setImage:[NSImage imageNamed: @"logo-bw.png"]];
}


- (void)setupStatusItem {
  statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
  [statusItem retain];
  
  [statusItem setHighlightMode:YES];
  [statusItem setImage:[NSImage imageNamed: @"logo-bw.png"]];
  
  [statusItem setTarget:self];
  [statusItem setAction:@selector(statusItemAction)];
}

- (void)statusItemAction {
  NSLog(@"Look at me clicked");
}

@end

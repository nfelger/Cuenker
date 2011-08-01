//
//  CuenkerAppDelegate.h
//  Cuenker
//
//  Created by Niko Felger on 25/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RsyncController.h"

@interface CuenkerAppDelegate : NSObject <NSApplicationDelegate, RsyncTaskController> {
  NSWindow *window;
  NSButton *suenkButton;
  NSButton *watchFSButton;
  NSTextField *statusInicator;
  NSTextView *logView;
  NSStatusItem *statusItem;
  RsyncController *rsyncController;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSButton *suenkButton;
@property (assign) IBOutlet NSButton *watchFSButton;
@property (assign) IBOutlet NSTextField *statusInicator;
@property (assign) IBOutlet NSTextView *logView;

- (IBAction)suenk:(id)sender;
- (IBAction)startStopWatchingFSChanges:(id)sender;

- (void)setupStatusItem;
- (void)statusItemAction;
@end

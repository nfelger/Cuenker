//
//  CuenkerAppDelegate.h
//  Cuenker
//
//  Created by Niko Felger on 25/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RsyncTask.h"

@interface CuenkerAppDelegate : NSObject <NSApplicationDelegate, RsyncTaskController> {
  NSWindow *window;
  NSButton *suenkButton;
  NSTextField *statusInicator;
  NSTextView *logView;
  RsyncTask *rsyncTask;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSButton *suenkButton;
@property (assign) IBOutlet NSTextField *statusInicator;
@property (assign) IBOutlet NSTextView *logView;

- (IBAction)suenk:(id)sender;

@end

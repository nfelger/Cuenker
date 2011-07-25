//
//  CuenkerAppDelegate.h
//  Cuenker
//
//  Created by Niko Felger on 25/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CuenkerAppDelegate : NSObject <NSApplicationDelegate> {
  NSWindow *window;
  NSButton *suenkButton;
  NSTextField *statusInicator;
  NSTextFieldCell *logOutput;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSButton *suenkButton;
@property (assign) IBOutlet NSTextField *statusInicator;
@property (assign) IBOutlet NSTextFieldCell *logOutput;

- (IBAction)suenk:(id)sender;

@end

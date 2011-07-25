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
@synthesize logOutput;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
}

- (IBAction)suenk:(id)sender {
  [self.statusInicator setStringValue:@"SÜNKING!!"];
  [self.statusInicator setBackgroundColor:[NSColor redColor]];
  NSTask *task;
  task = [[NSTask alloc] init];
  [task setLaunchPath: @"/bin/ls"];
  
  NSArray *arguments;
  arguments = [NSArray arrayWithObjects: @"-laF", @".", nil];
  [task setArguments: arguments];
  
  NSPipe *pipe;
  pipe = [NSPipe pipe];
  [task setStandardOutput: pipe];
  
  NSFileHandle *file;
  file = [pipe fileHandleForReading];
  
  [task launch];
  
  NSData *data;
  data = [file readDataToEndOfFile];
  
  NSString *string;
  string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
  NSLog (@"ls returned:\n%@", string);
  
  [self.logOutput setStringValue:string];
  [string release];
  [task release];

  [self.statusInicator setStringValue:@"done"];
  [self.statusInicator setBackgroundColor:[NSColor greenColor]];
  NSLog(@"received a suenk: message");
}
@end

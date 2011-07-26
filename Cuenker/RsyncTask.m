//
//  RsyncTask.m
//  Cuenker
//
//  Created by Niko Felger on 26/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RsyncTask.h"

@implementation RsyncTask

- (id)initWithController:(id <RsyncController>)c
{
  self = [super init];
  controller = c;
  
  return self;
}

- (void)dealloc
{
  [self stopProcess];
  
  [task release];
  [super dealloc];
}

- (void) startProcess
{
  [controller processStarted];
  
  
  task = [[NSTask alloc] init];
  [task setLaunchPath: @"/usr/local/bin/rsync"];
  
  // TODO: Worry about releasing the args.
  NSArray *arguments;
  arguments = [NSArray arrayWithObjects: @"-varx", @"--delete", @"-e", @"ssh", @"--filter", @". /Users/nfelger/dev/songkick/rsync.filter", @"/Users/nfelger/dev/songkick/", @"of1-dev-nfelger:dev/songkick/", nil];
  
  [task setArguments: arguments];
  
  [task setStandardOutput: [NSPipe pipe]];
  [task setStandardError: [task standardOutput]];
  
  
  [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(getData:) 
                                               name: NSFileHandleReadCompletionNotification 
                                             object: [[task standardOutput] fileHandleForReading]];
  [[[task standardOutput] fileHandleForReading] readInBackgroundAndNotify];
  
  [task launch];    
}

- (void) stopProcess
{  
  [[NSNotificationCenter defaultCenter] removeObserver:self name:NSFileHandleReadCompletionNotification object: [[task standardOutput] fileHandleForReading]];
  
  [task terminate];
 
  NSData *data;
  while ((data = [[[task standardOutput] fileHandleForReading] availableData]) && [data length])
  {
    [controller appendOutput: [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]];
  }
  
  [controller processFinished];
  controller = nil;
}

- (void) getData: (NSNotification *)aNotification
{
  NSData *data = [[aNotification userInfo] objectForKey:NSFileHandleNotificationDataItem];
  
  if (![data length])
  {
    // No more data available, so end the task.
    [self stopProcess];
    return;
  }
  
  [controller appendOutput: [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease]];
  
  [[aNotification object] readInBackgroundAndNotify];  
}


@end



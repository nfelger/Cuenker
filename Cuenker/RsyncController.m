//
//  RsyncController.m
//  Cuenker
//
//  Created by Niko Felger on 31/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RsyncController.h"

@implementation RsyncController

static void gotEvent(ConstFSEventStreamRef stream, 
                     void *clientCallBackInfo, 
                     size_t numEvents, 
                     void *eventPathsVoidPointer, 
                     const FSEventStreamEventFlags eventFlags[], 
                     const FSEventStreamEventId eventIds[]
                     ) {
  NSArray *eventPaths = eventPathsVoidPointer;
  RsyncController *controller = clientCallBackInfo;
  NSLog(@"Registered changes in %@", eventPaths);
  [controller startRsync];
}

- (id)initWithTaskController:(id <RsyncTaskController>)tc
{
  self = [super init];
  taskController = tc;
  currentlyWatchingFS = false;
  
  return self;
}

- (void) dealloc {
  [self stopWatchingFSChanges];
  FSEventStreamUnscheduleFromRunLoop(stream, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
  CFRelease(stream);
  [super dealloc];
}

- (void)startRsync
{
  if (rsyncTask != nil) [rsyncTask release];
  
  rsyncTask = [[RsyncTask alloc] initWithController:taskController];
  [rsyncTask startProcess];
}

- (void)startWatchingFSChanges {
  if(currentlyWatchingFS) { return; }
  
  NSLog(@"Activating FS watcher");
  
  NSString *newPath = @"/Users/nfelger/dev/songkick/";
  FSEventStreamCallback newCallback = gotEvent;
  
  NSArray *paths = [[NSArray arrayWithObject:newPath] retain];
  struct FSEventStreamContext context;
  
  context.version = 0L;
  context.info = self;
  context.retain = (CFAllocatorRetainCallBack)CFRetain;
  context.release = (CFAllocatorReleaseCallBack)CFRelease;
  context.copyDescription = (CFAllocatorCopyDescriptionCallBack)CFCopyDescription;
  
  stream = FSEventStreamCreate(kCFAllocatorDefault,
                               newCallback,
                               &context,
                               (CFArrayRef)paths, 
                               kFSEventStreamEventIdSinceNow,
                               1.0, /*latency*/
                               kFSEventStreamCreateFlagUseCFTypes);
  if (!stream) {
    NSLog(@"Could not create event stream for path %@", newPath);
    [self release];
    return;
  }
  
  FSEventStreamScheduleWithRunLoop(stream, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
  
  FSEventStreamStart(stream);
  
  NSLog(@"Started watching %@", newPath);
  
  currentlyWatchingFS = true;
}

- (void)stopWatchingFSChanges {
  if(!currentlyWatchingFS) { return; }
  
  FSEventStreamStop(stream);
  
  currentlyWatchingFS = false;
}


@end

//
//  RsyncController.m
//  Cuenker
//
//  Created by Niko Felger on 31/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RsyncController.h"

@implementation RsyncController

- (id)initWithTaskController:(id <RsyncTaskController>)tc
{
  self = [super init];
  taskController = tc;

  return self;
}

- (void)startRsync
{
  if (rsyncTask != nil) [rsyncTask release];
  
  rsyncTask = [[RsyncTask alloc] initWithController:taskController];
  [rsyncTask startProcess];
}

@end

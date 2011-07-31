//
//  RsyncController.h
//  Cuenker
//
//  Created by Niko Felger on 31/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CoreServices/CoreServices.h>
#import "RsyncTask.h"

@interface RsyncController : NSObject {
@private
  RsyncTask *rsyncTask;
  BOOL currentlyWatchingFS;
  id <RsyncTaskController> taskController;
}

- (id)initWithTaskController:(id <RsyncTaskController>)taskController;
- (void)startRsync;
- (void)startWatchingFSChanges;
- (void)stopWatchingFSChanges;

@end

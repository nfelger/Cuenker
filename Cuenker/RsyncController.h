//
//  RsyncController.h
//  Cuenker
//
//  Created by Niko Felger on 31/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RsyncTask.h"

@interface RsyncController : NSObject {
@private
  RsyncTask *rsyncTask;
  id <RsyncTaskController> taskController;
}

- (id)initWithTaskController:(id <RsyncTaskController>)taskController;
- (void)startRsync;

@end

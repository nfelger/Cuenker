//
//  RsyncTask.h
//  Cuenker
//
//  Created by Niko Felger on 26/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RsyncTaskController

- (void)appendOutput:(NSString *)output;

- (void)processStarted;

- (void)processFinished;

@end

@interface RsyncTask : NSObject {
  NSTask *task;
  id     <RsyncTaskController>controller;
}

- (id)initWithController:(id <RsyncTaskController>)controller;

- (void) startProcess;

- (void) stopProcess;

@end


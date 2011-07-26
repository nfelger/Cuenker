//
//  RsyncTask.h
//  Cuenker
//
//  Created by Niko Felger on 26/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RsyncController

- (void)appendOutput:(NSString *)output;

- (void)processStarted;

- (void)processFinished;

@end

@interface RsyncTask : NSObject {
  NSTask *task;
  id     <RsyncController>controller;
}

- (id)initWithController:(id <RsyncController>)controller;

- (void) startProcess;

- (void) stopProcess;

@end


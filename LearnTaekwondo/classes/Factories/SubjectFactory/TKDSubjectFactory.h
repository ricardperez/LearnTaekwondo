//
//  TKDSubjectFactory.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 01/06/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This class may be accessed by its singleton using the class message
 * sharedInstance.
 * Its only instance message is used to get the subject instances (TKDSubject)
 * represented in the plist file of given name.
 */
@interface TKDSubjectFactory : NSObject

/**
 * Get the singleton.
 */
+ (TKDSubjectFactory *)sharedInstance;

/**
 * Will return an array of subjects (TKDSubject) represented in a plist of given
 * name.
 */
- (NSArray *)subjectsInPlist:(NSString *)plist;

@end

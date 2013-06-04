//
//  TKDNodeFactory.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKDSubject;
@class TKDNode;

/**
 * This class may be accessed by its singleton using the class message
 * sharedInstance.
 * Its only instance message is used to get the nodes instances of a particular
 * subject and message. It will parse the respective plist file and create new
 * instances for representing that information.
 *
 * A TKDSubject instance has a pointer to its respective nodes, which may be
 * used externally. Those nodes are cached to the subject instance, but the
 * first time they are going to be created by this factory.
 */
@interface TKDNodeFactory : NSObject

/**
 * Get the singleton.
 */
+ (TKDNodeFactory *)sharedInstance;

/**
 * Will return an array of nodes for that subject and given dan. The way to take
 * them is scanning the plist file respective to that subject.
 */
- (NSArray *)nodesForSubject:(TKDSubject *)subject dan:(unsigned int)dan;

@end

//
//  TKDTestNode.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKDNode;

/**
 * This class will be used to represent the models of the "Test" screen. It will
 * let us know how many errors have been done for a particular node.
 *
 * Instead of being a subclass of TKDNode and adding an integer property to
 * represent the number of errors, it uses composition and has both TKDNode and
 * the integer properties.
 */
@interface TKDTestNode : NSObject

/**
 * The node to be studied.
 * Should be readonly (externally).
 */
@property (nonatomic, retain) TKDNode *node;

/**
 * The number of errors for the node.
 * Should be readonly (externally).
 */
@property (nonatomic, assign) NSInteger failures;

/**
 * The parameters constructor.
 */
- (id)initWithNode:(TKDNode *)node andFailures:(NSInteger)failures;

/**
 * Will +1 the failures property.
 */
- (void)increaseFailures;

/**
 * Will return true only if failures property has a bigger than 0 value.
 */
- (BOOL)isFailed;

@end

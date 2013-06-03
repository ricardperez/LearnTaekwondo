//
//  TKDTestNode.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKDNode;
@interface TKDTestNode : NSObject

@property (nonatomic, retain) TKDNode *node;
@property (nonatomic, assign) NSInteger failures;

- (id)initWithNode:(TKDNode *)node andFailures:(NSInteger)failures;
- (void)increaseFailures;
- (BOOL)isFailed;

@end

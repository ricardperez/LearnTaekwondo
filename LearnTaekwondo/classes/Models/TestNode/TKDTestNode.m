//
//  TKDTestNode.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDTestNode.h"

@implementation TKDTestNode

- (void)dealloc
{
	[_node release];
	[super dealloc];
}

- (id)initWithNode:(TKDNode *)node andFailures:(NSInteger)failures
{
	self = [super init];
	if (self != nil)
	{
		self.node = node;
		self.failures = failures;
	}
	return self;
}

- (void)increaseFailures
{
	self.failures++;
}

- (BOOL)isFailed
{
	return (self.failures > 0);
}

@end

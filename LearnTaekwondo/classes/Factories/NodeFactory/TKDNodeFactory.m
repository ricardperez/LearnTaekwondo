//
//  TKDNodeFactory.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDNodeFactory.h"
#import "TKDSubject.h"
#import "TKDNode.h"

@implementation TKDNodeFactory

static TKDNodeFactory *_singleton = nil;
+ (TKDNodeFactory *)sharedInstance
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_singleton = [[TKDNodeFactory alloc] init];
	});
	return _singleton;
}

- (NSArray *)nodesForSubject:(TKDSubject *)subject dan:(unsigned int)dan
{
	NSString *plistName = [subject keyName];
	NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
	NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:path];
	
	NSString *key = [NSString stringWithFormat:@"%iDan", dan];
	NSArray *nodeKeyNames = [data objectForKey:key];
	
	NSMutableArray *nodes = [NSMutableArray arrayWithCapacity:[nodeKeyNames count]];
	for (NSString *nodeKeyName in nodeKeyNames)
	{
		TKDNode *node = [[TKDNode alloc] initWithSubject:subject andKeyName:nodeKeyName];
		if (node != nil)
		{
			[nodes addObject:node];
		}
		[node release];
	}
	
	return nodes;
	
	//TODO cache the plist dictionary and add a purge method to clear that cache
}

@end

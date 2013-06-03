//
//  TKDSubject.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 01/06/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDSubject.h"
#import "SupportMacros.h"
#import "HelperFunctions.h"
#import "TKDNodeFactory.h"

@implementation TKDSubject


- (void)dealloc
{
	[_keyName release];
	[_localizedName release];
	[_imageName release];
	[_nodes release];
	[_cachedImage release];
	[super dealloc];
}

- (id)initWithKeyName:(NSString *)keyName
{
	self = [super init];
	if (self != nil)
	{
		self.keyName = keyName;
		NSString *name = [keyName stringByReplacingOccurrencesOfString:@"_" withString:@" "];
		self.localizedName = NSLocalizedString([name capitalizedString], nil);
		self.imageName = [[self class] imageNameForKey:keyName];
		self.nodes = [NSMutableDictionary dictionaryWithCapacity:9];
	}
	return self;
}

- (UIImage *)cachedImage
{
	if (_cachedImage == nil)
	{
		self.cachedImage = [UIImage imageNamed:self.imageName];
	}
	
	return _cachedImage;
}

- (NSArray *)nodesForDan:(NSInteger)dan
{
	NSString *key = [NSString stringWithFormat:@"%iDan", dan];
	NSArray *nodes = [self.nodes objectForKey:key];
	if (nodes == nil)
	{
		nodes = [[TKDNodeFactory sharedInstance] nodesForSubject:self dan:dan];
		[self.nodes setObject:nodes forKey:key];
	}
	return nodes;
}

- (void)purge
{
	self.nodes = [NSMutableDictionary dictionaryWithCapacity:9];
}


#pragma mark - Private
+ (NSString *)imageNameForKey:(NSString *)keyName
{
	NSString *imageName = [NSString stringWithFormat:@"%@.png", keyName];
	return ImageNameForCurrentDevice(imageName);
}

@end

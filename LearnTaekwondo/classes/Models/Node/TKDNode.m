//
//  TKDNode.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDNode.h"
#import "SupportMacros.h"
#import "HelperFunctions.h"

@interface TKDNode ()

+ (NSString *)imageNameForKey:(NSString *)keyName;

@end

@implementation TKDNode

- (void)dealloc
{
	[_keyName release];
	[_localizedName release];
	[_imageName release];
	[_cachedImage release];
	[super dealloc];
}

- (id)initWithSubject:(TKDSubject *)subject andKeyName:(NSString *)keyName
{
	self = [super init];
	if (self != nil)
	{
		self.subject = subject;
		self.keyName = keyName;
		NSMutableString *name = [NSMutableString stringWithString:[keyName stringByReplacingOccurrencesOfString:@"_" withString:@" "]];
		if ([name length] > 0)
		{
			char firstChar = [name characterAtIndex:0];
			NSString *upperFirstChar = [[NSString stringWithFormat:@"%c", firstChar] uppercaseString];
			[name replaceCharactersInRange:NSMakeRange(0, 1) withString:upperFirstChar];
		}
		self.localizedName = NSLocalizedString(name, nil);
		self.imageName = [[self class] imageNameForKey:keyName];
	}
	return self;
}

- (void)purge
{
	self.cachedImage = nil;
}

- (UIImage *)cachedImage
{
	if (_cachedImage == nil)
	{
		self.cachedImage = [UIImage imageNamed:self.imageName];
	}
	
	return _cachedImage;
}


#pragma mark - Private
+ (NSString *)imageNameForKey:(NSString *)keyName
{
	NSString *imageName = [NSString stringWithFormat:@"%@.png", keyName];
	return ImageNameForCurrentDevice(imageName);
}


@end

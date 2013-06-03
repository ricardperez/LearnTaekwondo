//
//  TKDSubjectFactory.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 01/06/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDSubjectFactory.h"
#import "TKDSubject.h"

@implementation TKDSubjectFactory

static TKDSubjectFactory *_singleton = nil;
+ (TKDSubjectFactory *)sharedInstance
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_singleton = [[TKDSubjectFactory alloc] init];
	});
	return _singleton;
}


- (NSArray *)subjectsInPlist:(NSString *)plist
{
	if (plist == nil)
	{
		plist = @"kibon_kisul";
	}
	NSString *path = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
	NSArray *subjectDicts = [NSArray arrayWithContentsOfFile:path];
	NSMutableArray *subjectInstances = [NSMutableArray arrayWithCapacity:[subjectDicts count]];
	for (NSDictionary *subjectDict in subjectDicts)
	{
		NSString *keyName = [subjectDict objectForKey:@"key_name"];
		TKDSubject *subject = [[TKDSubject alloc] initWithKeyName:keyName];
		if (subject != nil)
		{
			[subjectInstances addObject:subject];
		}
		[subject release];
	}
	return subjectInstances;
}


@end

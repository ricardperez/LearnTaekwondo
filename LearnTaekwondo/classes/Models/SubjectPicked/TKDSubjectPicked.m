//
//  TKDSubjectPicked.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDSubjectPicked.h"

@implementation TKDSubjectPicked

- (void)dealloc
{
	[_subject release];
	[super dealloc];
}

- (id)initWithSubject:(TKDSubject *)subject
{
	self = [super init];
	if (self != nil)
	{
		self.subject = subject;
		self.picked = NO;
	}
	return self;
}

@end

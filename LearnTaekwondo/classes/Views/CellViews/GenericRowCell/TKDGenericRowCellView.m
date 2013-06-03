//
//  TKDGenericRowCellView.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 01/06/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDGenericRowCellView.h"
#import "TKDGenericRowView.h"

@implementation TKDGenericRowCellView

- (void)dealloc
{
	[_rowView release];
	[super dealloc];
}

- (void)setup
{
	[super setup];
	self.rowView = [[[self class] rowViewClass] viewWithOwner:self];
	[self.rowView setAutoresizingMask:(UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin)];
	self.rowView.frame = self.bounds;
	[self addSubview:self.rowView];
}

static NSString *genericRowCellViewIdentifier = nil;
+ (NSString *)cellIdentifier
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		genericRowCellViewIdentifier = @"TKDGenericRowCellView";
	});
	return genericRowCellViewIdentifier;
}

+ (Class)rowViewClass
{
	return [TKDGenericRowView class];
}

@end

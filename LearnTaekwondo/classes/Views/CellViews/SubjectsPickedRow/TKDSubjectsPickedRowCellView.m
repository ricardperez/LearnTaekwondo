//
//  TKDSubjectsRowCellView.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 01/06/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDSubjectsPickedRowCellView.h"
#import "TKDSubjectsPickedRowView.h"

@implementation TKDSubjectsPickedRowCellView

static NSString *subjectsRowCellIdentifier = nil;
+ (NSString *)cellIdentifier
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		subjectsRowCellIdentifier = @"TKDSubjectsPickedRowCellView";
	});
	return subjectsRowCellIdentifier;
}

- (void)setup
{
	[super setup];
	[self.rowView setAutoresizingMask:(UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin)];
}

+ (Class)rowViewClass
{
	return [TKDSubjectsPickedRowView class];
}

@end

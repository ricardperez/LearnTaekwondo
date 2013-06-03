//
//  TKDView.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDView.h"

@implementation TKDView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)init
{
	self = [self initWithFrame:CGRectZero];
	return self;
}

+ (id)viewWithOwner:(id)owner
{
	NSString *nibName = nil;
	if (IS_IPAD())
	{
		nibName = [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), IPAD_SUFFIX()];
		if (!FileExists(nibName, @"nib"))
		{
			nibName = nil;
		}
	}
	if (nibName == nil)
	{
		nibName = [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), IPHONE_SUFFIX()];
	}
	
	if (!FileExists(nibName, @"nib"))
	{
		nibName = NSStringFromClass([self class]);
	}
	
	NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:NULL];
	NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
	TKDView *view = nil;
	NSObject* nibItem = nil;
	while ((nibItem = [nibEnumerator nextObject]) != nil)
	{
		if ([nibItem isKindOfClass:[TKDView class]])
		{
			view = (TKDView *)nibItem;
			[view setup];
		}
	}
	return view;
}

- (void)setup
{
	self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
}

@end

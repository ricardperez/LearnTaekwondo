//
//  TKDCellView.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDCellView.h"

@implementation TKDCellView

+ (id)cellWithOwner:(id)owner
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
	TKDCellView *cellView = nil;
	NSObject* nibItem = nil;
	while ((nibItem = [nibEnumerator nextObject]) != nil)
	{
		if ([nibItem isKindOfClass:[TKDCellView class]])
		{
			cellView = (TKDCellView *)nibItem;
			[cellView setup];
		}
	}
	return cellView;
}


+ (NSString *)cellIdentifier
{
	return NSStringFromClass([self class]);
}

- (void)setup
{
	self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end

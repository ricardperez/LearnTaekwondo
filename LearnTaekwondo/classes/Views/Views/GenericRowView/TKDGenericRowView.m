//
//  TKDGenericRowView.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 01/06/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDGenericRowView.h"

@interface TKDGenericRowView ()

@property (nonatomic, retain) NSMutableArray *componentViews;
@property (nonatomic, retain) NSArray *items;
@property (nonatomic, retain) NSArray *lastVisibleItems;

@end

@implementation TKDGenericRowView

- (void)dealloc
{
	[_componentViews release];
	[_items release];
	[_lastVisibleItems release];
	[super dealloc];
}

- (void)setup
{
	[super setup];
	self.componentViews = [NSMutableArray arrayWithCapacity:10];
}


- (NSArray *)showItemViews:(NSInteger)nItems inWidth:(CGFloat)width andHeight:(CGFloat)height ofType:(Class)type
{
	if (nItems != [self.lastVisibleItems count])
	{
		NSMutableArray *itemViews = [NSMutableArray arrayWithCapacity:nItems];
		
		CGFloat itemsSize = MIN(height, ((width / nItems)*0.9f));
//		CGFloat separation = ((self.frame.size.width - nItems * itemsSize) / (nItems+1));
		CGFloat separation = ((width - nItems * itemsSize) / (nItems+1));
		CGRect frame = CGRectMake(separation, 0.0f, itemsSize, itemsSize);
		for (NSInteger i=0; i<nItems; ++i)
		{
			TKDView *view = [self reusableViewAtIndex:i ofType:type];
			[itemViews addObject:view];
			[view setFrame:frame];
			frame.origin.x += (separation + itemsSize);
		}
		
		for (NSInteger i=nItems; i<[self.componentViews count]; ++i)
		{
			TKDView *view = [self.componentViews objectAtIndex:i];
			[view setHidden:YES];
		}
		
		self.lastVisibleItems = itemViews;
		
	}
	
	return self.lastVisibleItems;
}

- (TKDView *)reusableViewAtIndex:(NSInteger)index ofType:(Class)type
{
	for (NSInteger i=[self.componentViews count]; i<=index; ++i)
	{
		TKDView *poolView = [type viewWithOwner:self];
		[poolView setAutoresizingMask:(UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin)];
		[poolView setHidden:YES];
		[self addSubview:poolView];
		[self.componentViews addObject:poolView];
	}
	
	TKDView *view = [self.componentViews objectAtIndex:index];
	[view setHidden:NO];
	return view;
}

@end

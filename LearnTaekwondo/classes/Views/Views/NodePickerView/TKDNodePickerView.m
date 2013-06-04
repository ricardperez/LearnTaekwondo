//
//  TKDNodePickerView.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDNodePickerView.h"
#import "TKDNode.h"
#import "TKDNodeView.h"
#import <QuartzCore/QuartzCore.h>

@interface TKDNodePickerView ()

@property (nonatomic, retain) NSArray *nodeViews;
@property (nonatomic, assign) NSInteger nViewsPerPage;
@property (nonatomic, retain) TKDNodeView *panNodeView;
@property (nonatomic, retain) TKDNodeView *panSelectedView;

- (void)pageControlValueChangedAction:(id)sender;
- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)sender;

@end

@implementation TKDNodePickerView

- (void)dealloc
{
	[_leftMarkView release];
	[_rightMarkView release];
	[_scrollView release];
	[_pageControlView release];
	[_nodeViews release];
	[_panGestureRecognizer release];
	[_panNodeView release];
	[_panSelectedView release];
	
	[self removeGestureRecognizer:self.panGestureRecognizer];
	
	[super dealloc];
}

- (void)setup
{
	[super setup];
	self.scrollView.delegate = self;
	
	[self.pageControlView setBackgroundColor:TKD_COLOR_PAGE_CONTROL_BACKGROUND];
	[self.pageControlView.layer setBorderColor:[TKD_COLOR_PAGE_CONTROL_BORDER CGColor]];
	[self.pageControlView.layer setCornerRadius:3.0f];
	[self.pageControlView.layer setBorderWidth:1.0f];
	[self.pageControlView setHidesForSinglePage:YES];
	
	[self.pageControlView addTarget:self action:@selector(pageControlValueChangedAction:) forControlEvents:UIControlEventValueChanged];
	
	self.panGestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)] autorelease];
	[self.panGestureRecognizer setDelegate:self];
	[self addGestureRecognizer:self.panGestureRecognizer];
	
	self.panNodeView = [TKDNodeView viewWithOwner:self];
	[self.panNodeView setAutoresizingMask:(UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin)];
	[self addSubview:self.panNodeView];
	[self.panNodeView setHidden:YES];
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
	[self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width, self.scrollView.frame.size.height-1.0f)];
}


- (NSArray *)createNodeViews:(NSInteger)nViews
{
	for (UIView *nodeView in self.nodeViews)
	{
		[nodeView removeFromSuperview];
	}
	
	float nodeViewSize = self.scrollView.frame.size.height;
	self.nViewsPerPage = (self.scrollView.frame.size.width / nodeViewSize);
	float nodeViewSeparation = ((self.scrollView.frame.size.width - self.nViewsPerPage * nodeViewSize) / (self.nViewsPerPage+1));
	
	NSMutableArray *nodeViews = [NSMutableArray arrayWithCapacity:nViews];
	CGFloat currX = nodeViewSeparation;
	for (int i=0; i<nViews; ++i)
	{
		TKDNodeView *nodeView = [TKDNodeView viewWithOwner:self];
		[nodeView setFrame:CGRectMake(currX, 0.0f, nodeViewSize, nodeViewSize)];
		[self.scrollView addSubview:nodeView];
		[nodeViews addObject:nodeView];
		
		currX += (nodeViewSize + nodeViewSeparation);
		if ((i % self.nViewsPerPage) == (self.nViewsPerPage-1))
		{
			currX += nodeViewSeparation;
		}
	}
	self.nodeViews = nodeViews;
	
	int nPages = ((nViews / self.nViewsPerPage) + ((nViews % self.nViewsPerPage) == 0 ? 0 : 1));
	[self.leftMarkView setHidden:YES];
	[self.leftMarkView setHidden:(nPages <= 1)];
	[self.pageControlView setNumberOfPages:nPages];
	if (nPages > 0)
	{
		[self.pageControlView setCurrentPage:0];
	}
	CGSize pageControlSize = [self.pageControlView sizeForNumberOfPages:nPages];
	pageControlSize.height = 16.0f;
	pageControlSize.width += 14.0f;
	[self.pageControlView setBounds:CGRectMake(0.0f, 0.0f, pageControlSize.width, pageControlSize.height)];
	
	[self.scrollView setContentSize:CGSizeMake((self.scrollView.frame.size.width*nPages-1.0f), self.scrollView.frame.size.height-1.0f)];
	[self.scrollView bringSubviewToFront:self.pageControlView];
	
	return self.nodeViews;
	
}

- (void)layoutNodeViews
{
	NSInteger itemsOffset = (self.pageControlView.currentPage * self.nViewsPerPage);
	
	NSInteger nViews = [self.nodeViews count];
	float nodeViewSize = self.scrollView.frame.size.height;
	self.nViewsPerPage = (self.scrollView.frame.size.width / nodeViewSize);
	float nodeViewSeparation = ((self.scrollView.frame.size.width - self.nViewsPerPage * nodeViewSize) / (self.nViewsPerPage+1));
	
	CGFloat currX = nodeViewSeparation;
	for (int i=0; i<nViews; ++i)
	{
		TKDNodeView *nodeView = [self.nodeViews objectAtIndex:i];
		[nodeView setFrame:CGRectMake(currX, 0.0f, nodeViewSize, nodeViewSize)];
		
		currX += (nodeViewSize + nodeViewSeparation);
		if ((i % self.nViewsPerPage) == (self.nViewsPerPage-1))
		{
			currX += nodeViewSeparation;
		}
	}
	
	int nPages = ((nViews / self.nViewsPerPage) + ((nViews % self.nViewsPerPage) == 0 ? 0 : 1));
	[self.leftMarkView setHidden:YES];
	[self.leftMarkView setHidden:(nPages <= 1)];
	[self.pageControlView setNumberOfPages:nPages];

	CGSize pageControlSize = [self.pageControlView sizeForNumberOfPages:nPages];
	pageControlSize.height = 16.0f;
	pageControlSize.width += 14.0f;
	UIViewAutoresizing pageControlAutoresizing = self.pageControlView.autoresizingMask;
	[self.pageControlView setAutoresizingMask:(UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin)];
	[self.pageControlView setFrame:CGRectMake((self.frame.size.width-pageControlSize.width)*0.5f, self.pageControlView.frame.origin.y, pageControlSize.width, pageControlSize.height)];
	self.pageControlView.autoresizingMask = pageControlAutoresizing;
	
	NSInteger currPage = (itemsOffset / self.nViewsPerPage) + ((itemsOffset % self.nViewsPerPage) == 0 ? 0 : 1);
	[self.pageControlView setCurrentPage:currPage];
	[self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*currPage+1.0f, 0.0f)];
}

- (void)showImages:(BOOL)showImages andNames:(BOOL)showNames
{
	for (TKDNodeView *nodeView in self.nodeViews)
	{
		[nodeView showImage:showImages andName:showNames hasToFillName:NO];
	}
}


- (void)pageControlValueChangedAction:(id)sender
{
	NSInteger page = [self.pageControlView currentPage];
	CGFloat offsetX = (page * self.scrollView.frame.size.width);
	[self.scrollView setContentOffset:CGPointMake(offsetX, 0.0f) animated:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	int page = ((scrollView.contentOffset.x+1.0f) / scrollView.frame.size.width);
	if (page < 0)
	{
		page = 0;
	}
	if (page >= [self.pageControlView numberOfPages])
	{
		page = ([self.pageControlView numberOfPages]-1);
	}
	
	[self.pageControlView setCurrentPage:page];
	[self.leftMarkView setHidden:(page == 0)];
	[self.rightMarkView setHidden:(page == [self.pageControlView numberOfPages]-1)];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	TKDNodeView *selectedNodeView = nil;
	CGPoint point = [gestureRecognizer locationInView:[self scrollView]];
	
	NSInteger i = 0;
	while (selectedNodeView == nil && i<[self.nodeViews count])
	{
		TKDNodeView *nextView = [self.nodeViews objectAtIndex:i];
		if (CGRectContainsPoint(nextView.frame, point))
		{
			selectedNodeView = nextView;
		} else
		{
			++i;
		}
	}
	
	if (selectedNodeView != nil)
	{
		self.panSelectedView = selectedNodeView;
		[self.panNodeView makeAs:self.panSelectedView];
		[self.panNodeView showImage:YES andName:NO hasToFillName:NO];
		CGRect frameInScrollView = selectedNodeView.frame;
		CGRect frameInSelf = frameInScrollView;
		frameInSelf.origin.y += self.scrollView.frame.origin.y;
		frameInSelf.origin.x += (self.scrollView.frame.origin.x - ([self.pageControlView currentPage]*self.scrollView.frame.size.width));
		[self.panNodeView setFrame:frameInSelf];
	} else
	{
		self.panSelectedView = nil;
	}
	return (self.panSelectedView != nil);
}

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)sender
{
	if (sender.state == UIGestureRecognizerStateBegan)
	{
		[self.panNodeView setHidden:NO];
	} else if (sender.state == UIGestureRecognizerStateChanged)
	{
		[self.panNodeView setCenter:[sender locationInView:[self.panNodeView superview]]];
	} else //ended
	{
		[self.delegate nodePickerView:self movedNodeView:self.panNodeView];
		[self.panNodeView setHidden:YES];
	}
}

- (void)setPanGestureRecognizerEnabled:(BOOL)enabled
{
	[self.panGestureRecognizer setEnabled:enabled];
}

@end

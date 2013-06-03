//
//  TKDTestResultsNodeView.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDTestResultsNodeView.h"
#import "TKDNodeView.h"
#import "TKDTestNode.h"
#import <QuartzCore/QuartzCore.h>

@implementation TKDTestResultsNodeView

- (void)dealloc
{
	[_nodeContainerView release];
	[_resultContainerView release];
	[_resultImageView release];
	[_failuresLabel release];
	[_nodeView release];
	[super dealloc];
}

- (void)setup
{
	[super setup];
	self.nodeView = [TKDNodeView viewWithOwner:self];
	self.nodeView.frame = [self.nodeContainerView bounds];
	[self.nodeContainerView addSubview:self.nodeView];
	
	[self.resultContainerView setBackgroundColor:TKD_COLOR_NODE_VIEW_IMAGE_BACKGROUND];
	[self.resultContainerView.layer setBorderColor:[TKD_COLOR_NODE_VIEW_IMAGE_BORDER CGColor]];
	[self.resultContainerView.layer setBorderWidth:1.0f];
	[self.resultContainerView.layer setCornerRadius:1.0f];
}

- (void)setNErrors:(NSInteger)nErrors
{
	if (nErrors > 0)
	{
		[self.failuresLabel setHidden:NO];
		[self.failuresLabel setText:[NSString stringWithFormat:@"%i", nErrors]];
		[self.resultImageView setImage:ImageForCurrentDevice(@"incorrect.png")];
		
		CGRect imageFrame = self.resultImageView.frame;
		imageFrame.origin = CGPointZero;
		self.resultImageView.frame = imageFrame;
		
	} else
	{
		[self.failuresLabel setHidden:YES];
		[self.resultImageView setImage:ImageForCurrentDevice(@"correct.png")];
		self.resultImageView.center = CGPointMake(self.resultContainerView.bounds.size.width*0.5f, self.resultContainerView.bounds.size.height*0.5f);
	}
}

@end

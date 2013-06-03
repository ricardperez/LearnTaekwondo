//
//  TKDNodeView.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDNodeView.h"
#import <QuartzCore/QuartzCore.h>
#import "TKDNode.h"

@interface TKDNodeView ()

@end

@implementation TKDNodeView

- (void)dealloc
{
	[_imageBackgroundView release];
	[_imageView release];
	[_titleBackgroundView release];
	[_titleUnderlineView release];
	[_titleLabel release];
	[super dealloc];
}

- (void)setup
{
	[super setup];
	
	self.imageBackgroundView.backgroundColor = TKD_COLOR_NODE_VIEW_IMAGE_BACKGROUND;
	[self.imageBackgroundView.layer setBorderColor:[TKD_COLOR_NODE_VIEW_IMAGE_BORDER CGColor]];
	[self.imageBackgroundView.layer setBorderWidth:1.0f];
	[self.imageBackgroundView.layer setCornerRadius:1.0f];
	
	self.titleBackgroundView.backgroundColor = TKD_COLOR_NODE_VIEW_IMAGE_BACKGROUND;
	[self.titleBackgroundView.layer setBorderColor:[TKD_COLOR_NODE_VIEW_IMAGE_BORDER CGColor]];
	[self.titleBackgroundView.layer setBorderWidth:1.0f];
	[self.titleBackgroundView.layer setCornerRadius:1.0f];
}

- (void)showImage:(BOOL)showImage andName:(BOOL)showName hasToFillName:(BOOL)hasToFillName
{
	[self.imageView setHidden:(!showImage)];
	
	if (showName || hasToFillName)
	{
		[self.titleBackgroundView setHidden:NO];
		[self.titleLabel setHidden:NO];
		[self.titleUnderlineView setHidden:(!hasToFillName)];
		
		CGFloat imageSizeY = (self.titleBackgroundView.frame.origin.y - 2.0f);
		[self.imageBackgroundView setFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, imageSizeY)];
		
	} else
	{
		[self.titleBackgroundView setHidden:YES];
		[self.imageBackgroundView setFrame:self.bounds];
	}
}


- (void)makeAs:(TKDNodeView *)other
{
	self.userInfo = other.userInfo;
	[self.imageView setImage:other.imageView.image];
	[self.titleLabel setText:other.titleLabel.text];
	[self showImage:(![other.imageView isHidden]) andName:(![other.titleLabel isHidden]) hasToFillName:(![other.titleUnderlineView isHidden])];
}

@end

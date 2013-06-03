//
//  TKDSubjectPickedView.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 01/06/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDSubjectPickedView.h"
#import "TKDSubjectPicked.h"
#import "TKDSubject.h"
#import <QuartzCore/QuartzCore.h>

@implementation TKDSubjectPickedView

- (void)dealloc
{
	[_subjectImageView release];
	[_subjectTitleLabel release];
	[_actionButton release];
	
	[super dealloc];
}


- (void)setup
{
	[super setup];
	
	[self.subjectImageView.layer setShadowColor:[TKD_COLOR_SUBJECTS_SELECTED_SHADOW CGColor]];
}
- (IBAction)actionButtonAction:(id)sender
{
	[self.delegate subjectPickedViewAction:self];
}


- (void)setPicked:(BOOL)picked
{
	[self.subjectImageView.layer setShadowRadius:(picked ? 3.0f : 0.0f)];
	[self.subjectImageView.layer setShadowOffset:(picked ? CGSizeMake(1.0f, 1.0f) : CGSizeZero)];
	[self.subjectImageView.layer setShadowOpacity:(picked ? 0.65f : 0.0f)];
	
	[self.subjectImageView.layer setOpacity:(picked ? 1.0f : 0.5f)];
	[self.subjectTitleLabel setTextColor:(picked ? [UIColor blackColor] : [UIColor grayColor])];
	
}

@end

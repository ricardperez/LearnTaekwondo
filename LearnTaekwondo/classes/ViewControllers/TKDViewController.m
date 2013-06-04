//
//  TKDViewController.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDViewController.h"

@interface TKDViewController ()

@end

@implementation TKDViewController

+ (id)viewController
{
	NSString *nibName = [NSString stringWithFormat:@"%@_%@", NSStringFromClass(self), DEVICE_SUFFIX()];
	
	if (!FileExists(nibName, @"nib"))
	{
		nibName = [NSString stringWithFormat:@"%@_%@", NSStringFromClass(self), IPHONE_SUFFIX()];
		if (!FileExists(nibName, @"nib"))
		{
			nibName = NSStringFromClass(self);
		}
	}
	
	return [[[self alloc] initWithNibName:nibName bundle:nil] autorelease];
}

+ (UINavigationController *)navigationControllerWithViewController:(id *)controllerRef
{
	id vc = [self viewController];
	if (controllerRef != nil)
	{
		*controllerRef = vc;
	}
	return [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

//
//  TKDViewStyles.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDViewStyles.h"
#import <QuartzCore/QuartzCore.h>

@interface TKDViewStyles ()

- (UIImage *)imageWithGradientColors:(NSArray *)colors width:(CGFloat)width height:(CGFloat)height cornerRadius:(CGFloat)radius;

@end

@implementation TKDViewStyles


static TKDViewStyles *_singleton = nil;
+ (TKDViewStyles *)sharedInstance
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_singleton = [[TKDViewStyles alloc] init];
	});
	return _singleton;
}


- (void)styleButton:(UIButton *)button
{
	[button.layer setCornerRadius:4.0f];
	[button.layer setBorderWidth:1.0f];
	[button.layer setBorderColor:[TKD_COLOR_BUTTONS_BORDER CGColor]];
	
	NSArray *gradientColors = [NSArray arrayWithObjects:
							   TKD_COLOR_BUTTONS_GRADIENT_TOP,
							   TKD_COLOR_BUTTONS_GRADIENT_TOP,
							   TKD_COLOR_BUTTONS_GRADIENT_BOTTOM,
							   nil];
	UIImage *image = [self imageWithGradientColors:gradientColors width:button.frame.size.width height:button.frame.size.height cornerRadius:4.0f];
	[button setBackgroundImage:image forState:UIControlStateNormal];
	[button setTitleColor:TKD_COLOR_BUTTONS_TITLE forState:UIControlStateNormal];
	[button setTitleColor:TKD_COLOR_BUTTONS_TITLE_HIGHLIGHTED forState:UIControlStateHighlighted];
	[button setTitleColor:TKD_COLOR_BUTTONS_TITLE_DISABLED forState:UIControlStateDisabled];
}


#pragma mark - private
- (UIImage *)imageWithGradientColors:(NSArray *)colors width:(CGFloat)width height:(CGFloat)height cornerRadius:(CGFloat)radius
{
	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.frame = CGRectMake(0.0f, 0.0f, width, height);
	gradientLayer.cornerRadius = radius;
	
	NSMutableArray *colorsRefs = [NSMutableArray arrayWithCapacity:[colors count]];
	for (UIColor *color in colors)
	{
		[colorsRefs addObject:(id)[color CGColor]];
	}
	gradientLayer.colors = colorsRefs;
	
	UIGraphicsBeginImageContext(CGSizeMake(width, height));
	[gradientLayer renderInContext: UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

@end

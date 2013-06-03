//
//  HelperFunctions.c
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "HelperFunctions.h"

BOOL FileExists(NSString *fileName, NSString *fileExtension)
{
	return ([[NSBundle mainBundle] pathForResource:fileName ofType:fileExtension] != nil);
}

/**
 * If iPad, will check for name_iPad image
 * If not found, will check for name@2x image
 * If not found or not iPad, will return name
 *
 * An image named image.png may have the following versions:
 *  image_iPad@2x.png  <- iPad retina (@2x will be added automatically)
 *  image_iPad.png     <- iPad
 *  image@2x.png       <- iPhone retina (@2x will be added automatically)
 *  image.png          <- iPhone
 */
NSString *ImageNameForCurrentDevice(NSString *name)
{
	NSString *fileName = [name stringByDeletingPathExtension];
	NSString *fileExtension = [name pathExtension];
	NSString *fileNameForDevice = nil;
	BOOL iPadFound = NO;
	if (IS_IPAD())
	{
		NSString *iPadFileName = [fileName stringByAppendingFormat:@"_%@", DEVICE_SUFFIX()];
		if (FileExists(iPadFileName, fileExtension))
		{
			iPadFound = YES;
			fileNameForDevice = iPadFileName;
		}
	}
	
	
	if (!iPadFound)
	{
		BOOL retinaFound = NO;
		if (IS_IPAD() && IS_RETINA())
		{
			NSString *iPhoneRetinaFileName = [fileName stringByAppendingFormat:@"@2x"];
			if (FileExists(iPhoneRetinaFileName, fileExtension))
			{
				retinaFound = YES;
				fileNameForDevice = iPhoneRetinaFileName;
			}
		}
		
		if (!retinaFound)
		{
			fileNameForDevice = fileName;
		}
	}
	
	return [fileNameForDevice stringByAppendingPathExtension:fileExtension];
}

UIImage *ImageForCurrentDevice(NSString *name)
{
	NSString *imageName = ImageNameForCurrentDevice(name);
	return [UIImage imageNamed:imageName];
}


@implementation NSArray (Random)

- (NSArray *)randomizedArray
{
	NSMutableArray *indexes = [NSMutableArray arrayWithCapacity:[self count]];
	for (NSInteger i=0; i<[self count]; ++i)
	{
		[indexes addObject:[NSNumber numberWithInteger:i]];
	}
	NSMutableArray *randomArray = [NSMutableArray arrayWithCapacity:[self count]];
	for (NSInteger i=0; i<[self count]; ++i)
	{
		NSInteger i = (arc4random() % [indexes count]);
		NSInteger index = [[indexes objectAtIndex:i] integerValue];
		[randomArray addObject:[self objectAtIndex:index]];
		[indexes removeObjectAtIndex:i];
	}
	
	return randomArray;
}

@end
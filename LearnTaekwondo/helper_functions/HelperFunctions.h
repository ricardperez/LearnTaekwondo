//
//  HelperFunctions.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#ifndef LearnTaekwondo_HelperFunctions_h
#define LearnTaekwondo_HelperFunctions_h

#import <UIKit/UIKit.h>
#import "SupportMacros.h"

BOOL FileExists(NSString *fileName, NSString *fileExtension);

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
NSString *ImageNameForCurrentDevice(NSString *name);

UIImage *ImageForCurrentDevice(NSString *name);



@interface NSArray (Random)

- (NSArray *)randomizedArray;

@end

#endif

//
//  TKDCellView.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupportMacros.h"
#import "HelperFunctions.h"
#import "TKDViewStyles.h"

@interface TKDCellView : UITableViewCell

@property (nonatomic, assign) id userInfo;

/**
 * Will initialize the cell with a nib name equal to the class name (adding a
 * _iPhone or _iPad suffix depending on the device)
 */
+ (id)cellWithOwner:(id)ownder;

/**
 * Should be overriden by subclasses and return a static NSString instance in 
 * order to improve performance.
 */
+ (NSString *)cellIdentifier;

/**
 * Will be called in init of cellWithOwner:
 * Use it to customize any setup.
 */
- (void)setup;

@end

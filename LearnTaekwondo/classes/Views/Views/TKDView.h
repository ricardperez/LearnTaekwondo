//
//  TKDView.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupportMacros.h"
#import "HelperFunctions.h"
#import "TKDViewStyles.h"

@interface TKDView : UIView

@property (nonatomic, assign) id userInfo;


+ (id)viewWithOwner:(id)owner;
- (void)setup;

- (void)setBackgroundColor:(UIColor *)backgroundColor recursively:(BOOL)recursive;

@end

//
//  TKDViewStyles.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>


#define TKD_COLOR_NODE_VIEW_IMAGE_BACKGROUND		[UIColor colorWithWhite:0.95f alpha:1.0f]
#define TKD_COLOR_NODE_VIEW_IMAGE_BORDER			[UIColor colorWithWhite:0.9f alpha:1.0f]
#define TKD_COLOR_PAGE_CONTROL_BACKGROUND			[UIColor colorWithWhite:0.75f alpha:0.75f]
#define TKD_COLOR_PAGE_CONTROL_BORDER				[UIColor colorWithWhite:0.75f alpha:1.0f]
#define TKD_COLOR_SUBJECTS_SELECTED_SHADOW			[UIColor colorWithRed:0.25f green:0.25f blue:0.85f alpha:1.0f]

#define TKD_COLOR_BUTTONS_BORDER					[UIColor colorWithWhite:0.4f alpha:1.0f]
#define TKD_COLOR_BUTTONS_GRADIENT_TOP				[UIColor colorWithWhite:0.8f alpha:1.0f]
#define TKD_COLOR_BUTTONS_GRADIENT_BOTTOM			[UIColor colorWithWhite:0.6f alpha:1.0f]
#define TKD_COLOR_BUTTONS_TITLE						[UIColor colorWithWhite:0.2f alpha:1.0f]
#define TKD_COLOR_BUTTONS_TITLE_HIGHLIGHTED			[UIColor colorWithWhite:1.0f alpha:1.0f]
#define TKD_COLOR_BUTTONS_TITLE_DISABLED			[UIColor colorWithWhite:0.35f alpha:1.0f]

@interface TKDViewStyles : NSObject

+ (TKDViewStyles *)sharedInstance;

- (void)styleButton:(UIButton *)button;

@end

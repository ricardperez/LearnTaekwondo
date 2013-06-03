//
//  TKDNodeView.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKDView.h"

@class TKDNode;
@interface TKDNodeView : TKDView

@property (nonatomic, retain) IBOutlet UIView *imageBackgroundView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIView *titleBackgroundView;
@property (nonatomic, retain) IBOutlet UIView *titleUnderlineView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;

- (void)showImage:(BOOL)showImage andName:(BOOL)showName hasToFillName:(BOOL)hasToFillName;

- (void)makeAs:(TKDNodeView *)other;

@end

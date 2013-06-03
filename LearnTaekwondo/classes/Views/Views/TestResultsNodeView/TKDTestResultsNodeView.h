//
//  TKDTestResultsNodeView.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDView.h"

@class TKDNodeView;
@class TKDTestNode;

@interface TKDTestResultsNodeView : TKDView

@property (nonatomic, retain) IBOutlet UIView *nodeContainerView;
@property (nonatomic, retain) IBOutlet UIView *resultContainerView;
@property (nonatomic, retain) IBOutlet UIImageView *resultImageView;
@property (nonatomic, retain) IBOutlet UILabel *failuresLabel;

@property (nonatomic, retain) TKDNodeView *nodeView;

- (void)setNErrors:(NSInteger)nErrors;

@end

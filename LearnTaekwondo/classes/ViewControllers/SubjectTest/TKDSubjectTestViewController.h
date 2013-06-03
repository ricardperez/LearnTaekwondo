//
//  TKDSubjectTestViewController.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDViewController.h"
#import "TKDNodePickerView.h"
#import <AudioToolbox/AudioToolbox.h>
@class TKDNodeView;

@interface TKDSubjectTestViewController : TKDViewController <TKDNodePickerViewDelegate>
{
	SystemSoundID _correctSoundID;
	SystemSoundID _incorrectSoundID;
}

@property (nonatomic, retain) IBOutlet UIView *testNodeMainBackgroundView;
@property (nonatomic, retain) IBOutlet UIView *testNodeBackgroundView;
@property (nonatomic, retain) IBOutlet UIView *nodePickerBackgroundView;
@property (nonatomic, retain) IBOutlet UIImageView *correctIncorrectImageView;


- (void)loadNodesForSubjects:(NSArray *)subjects dan:(NSInteger)dan nTests:(NSInteger)maxNTests;

@end

//
//  TKDSubjectPickedView.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 01/06/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDView.h"

@class TKDSubjectPickedView;
@protocol TKDSubjectPickedViewDelegate <NSObject>
- (void)subjectPickedViewAction:(TKDSubjectPickedView *)view;
@end

@interface TKDSubjectPickedView : TKDView

@property (nonatomic, retain) IBOutlet UIImageView *subjectImageView;
@property (nonatomic, retain) IBOutlet UILabel *subjectTitleLabel;
@property (nonatomic, retain) IBOutlet UIButton *actionButton;

@property (nonatomic, assign) id<TKDSubjectPickedViewDelegate> delegate;

- (IBAction)actionButtonAction:(id)sender;

- (void)setPicked:(BOOL)picked;

@end

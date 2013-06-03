//
//  TKDNodePickerView.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDView.h"
@class TKDNode;
@class TKDNodePickerView;
@class TKDNodeView;

@protocol TKDNodePickerViewDelegate <NSObject>

- (void)nodePickerView:(TKDNodePickerView *)view movedNodeView:(TKDNodeView *)nodeView;

@end

@interface TKDNodePickerView : TKDView <UIScrollViewDelegate, UIGestureRecognizerDelegate>


@property (nonatomic, retain) IBOutlet UIView *leftMarkView;
@property (nonatomic, retain) IBOutlet UIView *rightMarkView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControlView;
@property (nonatomic, retain) UIPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic, assign) id<TKDNodePickerViewDelegate> delegate;

- (NSArray *)createNodeViews:(NSInteger)nViews;
- (void)setPanGestureRecognizerEnabled:(BOOL)enabled;
- (void)showImages:(BOOL)showImages andNames:(BOOL)showNames;

@end

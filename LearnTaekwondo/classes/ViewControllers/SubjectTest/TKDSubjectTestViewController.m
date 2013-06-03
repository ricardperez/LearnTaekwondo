//
//  TKDSubjectTestViewController.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDSubjectTestViewController.h"
#import "TKDNodeView.h"
#import "TKDSubject.h"
#import "TKDNode.h"
#import "TKDTestNode.h"
#import "TKDTestResultsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TKDSubjectTestViewController ()

@property (nonatomic, retain) NSArray *nodes;
@property (nonatomic, retain) TKDNodeView *testNodeView;
@property (nonatomic, retain) TKDNodePickerView *nodePickerView;
@property (nonatomic, assign) NSInteger testIndex;
@property (nonatomic, retain) NSArray *testNodes;
@property (nonatomic, retain) TKDNodeView *pickedNodeView;
@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, retain) NSMutableSet *timers;

- (void)loadCurrentNode;
- (void)cancelButtonAction:(id)sender;
- (void)scheduledEvaluate:(NSTimer *)timer;
- (void)showSuccess:(BOOL)success duration:(NSTimeInterval)duration;
- (void)playSoundSuccess:(BOOL)success;

@end

@implementation TKDSubjectTestViewController

- (void)dealloc
{
	[_testNodeMainBackgroundView release];
	[_testNodeBackgroundView release];
	[_nodePickerBackgroundView release];
	[_correctIncorrectImageView release];
	[_nodes release];
	[_testNodeView release];
	[_nodePickerView release];
	[_testNodes release];
	[_pickedNodeView release];
	[_results release];
	
	
	for (NSTimer *timer in self.timers)
	{
		[timer invalidate];
	}
	[_timers release];
	
	AudioServicesDisposeSystemSoundID(_correctSoundID);
	AudioServicesDisposeSystemSoundID(_incorrectSoundID);
	
	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction:)] autorelease];
	[self.navigationItem setLeftBarButtonItem:cancelButton];
	
	self.pickedNodeView = [TKDNodeView viewWithOwner:self];
	[self.pickedNodeView setHidden:YES];
	[self.pickedNodeView setAutoresizingMask:(UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin)];
	[self.view addSubview:self.pickedNodeView];
	
	self.testNodeView = [TKDNodeView viewWithOwner:self];
	[self.testNodeView setFrame:[self.testNodeBackgroundView bounds]];
	[self.testNodeBackgroundView addSubview:self.testNodeView];
	
	[self setupNodePickerView];
	
	self.results = [NSMutableArray arrayWithCapacity:[self.nodes count]];
	self.testNodes = [self.nodes randomizedArray];
	self.testIndex = 0;
	[self loadCurrentNode];
	
	[self.testNodeBackgroundView setBackgroundColor:[self.view backgroundColor]];
	
	[self.nodePickerBackgroundView.layer setShadowOffset:CGSizeMake(1.0f, -1.0f)];
	[self.nodePickerBackgroundView.layer setShadowOpacity:0.25f];
	
	NSURL *correctSoundURL = [[NSBundle mainBundle] URLForResource:@"sound_correct" withExtension:@"wav"];
	AudioServicesCreateSystemSoundID((CFURLRef)correctSoundURL, &_correctSoundID);
	NSURL *inorrectSoundURL = [[NSBundle mainBundle] URLForResource:@"sound_incorrect" withExtension:@"wav"];
	AudioServicesCreateSystemSoundID((CFURLRef)inorrectSoundURL, &_incorrectSoundID);
	
	[self.correctIncorrectImageView setHidden:YES];
	[self.correctIncorrectImageView setAlpha:0.0f];
	
	self.timers = [NSMutableSet setWithCapacity:5];
	[self.view bringSubviewToFront:self.correctIncorrectImageView];
}

- (void)setupNodePickerView
{
	self.nodePickerView = [TKDNodePickerView viewWithOwner:self];
	[self.nodePickerView setFrame:[self.nodePickerBackgroundView bounds]];
	[self.nodePickerBackgroundView addSubview:self.nodePickerView];
	[self.nodePickerView setDelegate:self];
	
	NSArray *nodeViews = [self.nodePickerView createNodeViews:[self.nodes count]];
	for (NSInteger i=0; i<[self.nodes count]; ++i)
	{
		TKDNode *node = [self.nodes objectAtIndex:i];
		TKDNodeView *nodeView = [nodeViews objectAtIndex:i];
		
		[self loadNode:node toView:nodeView];
		[nodeView showImage:YES andName:NO hasToFillName:NO];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNodesForSubjects:(NSArray *)subjects dan:(NSInteger)dan nTests:(NSInteger)maxNTests
{
	NSInteger remaining = 0;
	NSMutableArray *allNodesBySubject = [NSMutableArray arrayWithCapacity:[subjects count]];
	for (TKDSubject *subject in subjects)
	{
		NSMutableArray *subjectNodes = [NSMutableArray arrayWithArray:[subject nodesForDan:dan]];
		[allNodesBySubject addObject:subjectNodes];
		remaining += [subjectNodes count];
	}
	
	NSMutableArray *testNodesBySubject = [NSMutableArray arrayWithCapacity:[subjects count]];
	for (NSInteger i=0; i<[subjects count]; ++i)
	{
		[testNodesBySubject addObject:[NSMutableArray arrayWithCapacity:(maxNTests / [subjects count])]];
	}
	
	NSInteger n = 0;
	NSInteger subjectIndex = 0;
	while ((n < maxNTests) && (remaining > 0))
	{
		NSMutableArray *subjectNodes = [allNodesBySubject objectAtIndex:subjectIndex];
		NSMutableArray *testSubjectNodes = [testNodesBySubject objectAtIndex:subjectIndex];
		if ([subjectNodes count] > 0)
		{
			NSInteger randomIndex = (arc4random() % [subjectNodes count]);
			TKDNode *node = [subjectNodes objectAtIndex:randomIndex];
			[testSubjectNodes addObject:node];
			[subjectNodes removeObjectAtIndex:randomIndex];
			++subjectIndex;
			++n;
			--remaining;
		}
		
		if ([allNodesBySubject count] > 0)
		{
			subjectIndex %= [allNodesBySubject count];
		}
	}
	
	NSMutableArray *nodes = [NSMutableArray arrayWithCapacity:maxNTests];
	for (NSMutableArray *testSubjectNodes in testNodesBySubject)
	{
		[nodes addObjectsFromArray:testSubjectNodes];
	}
	
	self.nodes = nodes;
}


- (void)loadCurrentNode
{
	if (self.testIndex < [self.testNodes count])
	{
		TKDNode *currentTestNode = [self.testNodes objectAtIndex:self.testIndex];
		[self loadNode:currentTestNode toView:self.testNodeView];
		[self.testNodeView showImage:NO andName:YES hasToFillName:NO];
		[self.nodePickerView setPanGestureRecognizerEnabled:YES];
		
		[self.results addObject:[[[TKDTestNode alloc] initWithNode:currentTestNode andFailures:0] autorelease]];
	}
}

- (void)cancelButtonAction:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - TKDNodePickerViewDelegate
- (void)nodePickerView:(TKDNodePickerView *)view movedNodeView:(TKDNodeView *)nodeView
{
	CGRect transformedFrame = nodeView.frame;
	transformedFrame.origin.x += self.nodePickerView.frame.origin.x + self.nodePickerBackgroundView.frame.origin.x;
	transformedFrame.origin.y += self.nodePickerView.frame.origin.y + self.nodePickerBackgroundView.frame.origin.y;
	
	CGRect destinyFrame = self.testNodeBackgroundView.frame;
	destinyFrame.origin.x += self.testNodeMainBackgroundView.frame.origin.x;
	destinyFrame.origin.y += self.testNodeMainBackgroundView.frame.origin.y;
	
	CGRect insetFrame = CGRectInset(transformedFrame, transformedFrame.size.width*0.25f, transformedFrame.size.height*0.25f);
	if (CGRectContainsRect(destinyFrame, insetFrame))
	{
		[self.testNodeView showImage:NO andName:YES hasToFillName:NO];
		
		[self.pickedNodeView setFrame:transformedFrame];
		[self.pickedNodeView makeAs:nodeView];
		[self.pickedNodeView showImage:YES andName:NO hasToFillName:NO];
		[self.pickedNodeView setHidden:NO];
		
		CGRect finalFrame;
		finalFrame.origin.x = self.testNodeMainBackgroundView.frame.origin.x + self.testNodeBackgroundView.frame.origin.x;
		finalFrame.origin.y = self.testNodeMainBackgroundView.frame.origin.y + self.testNodeBackgroundView.frame.origin.y;
		finalFrame.size.width = self.testNodeView.imageBackgroundView.frame.size.width;
		finalFrame.size.height = self.testNodeView.imageBackgroundView.frame.size.height;
		
		[self.nodePickerView setPanGestureRecognizerEnabled:NO];
		
		[UIView animateWithDuration:0.2 animations:^{
			[self.pickedNodeView setFrame:finalFrame];
		} completion:^(BOOL finished) {
			[self.timers addObject:[NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(scheduledEvaluate:) userInfo:nodeView.userInfo repeats:NO]];
		}];
	}
}


- (void)scheduledEvaluate:(NSTimer *)timer
{
	[self.timers removeObject:timer];
	TKDNode *node = (TKDNode *)timer.userInfo;
	
	TKDTestNode *currentResultNode = [self.results lastObject];
	if ([node.keyName isEqualToString:currentResultNode.node.keyName])
	{
		[self showSuccess:YES duration:0.5];
		[self playSoundSuccess:YES];
		
		[self loadNode:node toView:self.testNodeView];
		[self.testNodeView showImage:YES andName:YES hasToFillName:NO];
		[self.timers addObject:[NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(scheduledLoadNextTest:) userInfo:nil repeats:NO]];
		
		[self.pickedNodeView setHidden:YES];
	} else
	{
		[self showSuccess:NO duration:0.5];
		[self playSoundSuccess:NO];
		
		[currentResultNode increaseFailures];
		
		BOOL maxErrorsTriggered = (currentResultNode.failures >= 3);
		[self.timers addObject:[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(scheduledHidePickedNodeView:) userInfo:[NSNumber numberWithBool:maxErrorsTriggered] repeats:NO]];
		if (!maxErrorsTriggered)
		{
			[self.nodePickerView setPanGestureRecognizerEnabled:YES];
		}
	}
	
	
}

- (void)scheduledHidePickedNodeView:(NSTimer *)timer
{
	BOOL shouldLoadNextTest = [timer.userInfo boolValue];
	
	[self.timers removeObject:timer];
	CGAffineTransform transform = CGAffineTransformRotate(self.pickedNodeView.transform, M_PI);
	[UIView animateWithDuration:0.2 animations:^{
		[self.pickedNodeView setBounds:CGRectMake(0.0f, 0.0f, 20.0f, 20.0f)];
		[self.pickedNodeView setTransform:transform];
	} completion:^(BOOL finished) {
		[self.pickedNodeView setTransform:CGAffineTransformIdentity];
		[self.pickedNodeView setHidden:YES];
		
		if (shouldLoadNextTest)
		{
			[self.testNodeView showImage:YES andName:YES hasToFillName:NO];
			[self.timers addObject:[NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(scheduledLoadNextTest:) userInfo:nil repeats:NO]];
		}
	}];
}

- (void)scheduledLoadNextTest:(NSTimer *)timer
{
	[self.timers removeObject:timer];
	if (self.testIndex < ([self.testNodes count]-1))
	{
		self.testIndex++;
		
		CGFloat positionOutX = (-self.testNodeBackgroundView.frame.origin.x - self.testNodeView.frame.size.width - 1.0f);
		CGFloat positionInX = (self.view.frame.size.width - self.testNodeBackgroundView.frame.origin.x + 1.0f);
		
		CGRect rect = self.testNodeView.frame;
		[UIView animateWithDuration:0.2 animations:^{
			[self.testNodeView setFrame:CGRectMake(positionOutX, rect.origin.y, 50.0f, 50.0f)];
			[self.correctIncorrectImageView setAlpha:0.0f];
		} completion:^(BOOL finished) {
			[self.testNodeView setFrame:CGRectMake(positionInX, rect.origin.y, 50.0f, 50.0f)];
			[self.correctIncorrectImageView setHidden:YES];
			[self loadCurrentNode];
			[UIView animateWithDuration:0.2 animations:^{
				[self.testNodeView setFrame:rect];
			}];
		}];
	} else
	{
		NSLog(@"Finish!");
		TKDTestResultsViewController *resultsVC = [TKDTestResultsViewController viewController];
		[resultsVC loadResults:self.results];
		[self.navigationController pushViewController:resultsVC animated:YES];
	}
}


- (void)loadNode:(TKDNode *)node toView:(TKDNodeView *)view
{
	view.userInfo = node;
	[view.imageView setImage:[node cachedImage]];
	[view.titleLabel setText:[node localizedName]];
}


- (void)showSuccess:(BOOL)success duration:(NSTimeInterval)duration
{
	[self.correctIncorrectImageView setHighlighted:(!success)];
	[self.correctIncorrectImageView setHidden:NO];
	[UIView animateWithDuration:0.2 animations:^{
		[self.correctIncorrectImageView setAlpha:1.0f];
	} completion:^(BOOL finished) {
		[self.timers addObject:[NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(scheduledHideSuccess:) userInfo:nil repeats:NO]];
	}];
}

- (void)playSoundSuccess:(BOOL)success
{
	AudioServicesPlaySystemSound((success ? _correctSoundID : _incorrectSoundID));
}

- (void)scheduledHideSuccess:(NSTimer *)timer
{
	[self.timers removeObject:timer];
	[UIView animateWithDuration:0.2 animations:^{
		[self.correctIncorrectImageView setAlpha:0.0f];
	} completion:^(BOOL finished) {
		[self.correctIncorrectImageView setHidden:YES];
	}];
}

- (void)setTestIndex:(NSInteger)testIndex
{
	_testIndex = testIndex;
	[self.navigationItem setTitle:[NSString stringWithFormat:@"%i / %i", (testIndex+1), [self.nodes count]]];
}

@end

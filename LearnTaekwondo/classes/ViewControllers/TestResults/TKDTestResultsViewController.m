//
//  TKDTestResultsViewController.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDTestResultsViewController.h"
#import "TKDTestResultsCellView.h"
#import "TKDTestNode.h"
#import "TKDTestResultsRowView.h"
#import "TKDTestResultsNodeView.h"
#import "TKDNodeView.h"
#import "TKDNode.h"

@interface TKDTestResultsViewController ()

@property (nonatomic, retain) NSArray *loadedResults;
@property (nonatomic, retain) NSArray *groupedResults;
@property (nonatomic, assign) UIInterfaceOrientation usedOrientation;

- (void)setupResultInstances;
- (NSInteger)nItemsPerRow;
- (CGFloat)rowsHeight;

@end

@implementation TKDTestResultsViewController

- (void)dealloc
{
	[_tableView release];
	[_continueButton release];
	[_groupedResults release];
	[_loadedResults release];
	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
	[self loadResults:self.loadedResults];
	
	[self.continueButton setTitle:NSLocalizedString(@"Salir", nil) forState:UIControlStateNormal];
	
	BOOL passed = YES;
	NSInteger i = 0;
	while (passed && i<[self.loadedResults count])
	{
		TKDTestNode *testNode = [self.loadedResults objectAtIndex:i];
		passed = (testNode.failures == 0);
		++i;
	}
	[self.navigationItem setTitle:(passed ? NSLocalizedString(@"¡Aprobado!", nil) : NSLocalizedString(@"Suspendido", nil))];
	[[TKDViewStyles sharedInstance] styleButton:self.continueButton];
}

- (void)loadResults:(NSArray *)results
{
	self.loadedResults = results;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.usedOrientation = [self interfaceOrientation];
	[self setupResultInstances];
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.groupedResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	TKDTestResultsCellView *cellView = [tableView dequeueReusableCellWithIdentifier:[TKDTestResultsCellView cellIdentifier]];
	if (cellView == nil)
	{
		cellView = [TKDTestResultsCellView cellWithOwner:self];
	}
	
	NSArray *models = [self.groupedResults objectAtIndex:[indexPath row]];
	[self loadModels:models toCellView:cellView];
	
	return cellView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self rowsHeight];
}

- (void)loadModels:(NSArray *)models toCellView:(TKDTestResultsCellView *)cellView
{
	cellView.backgroundColor = [UIColor clearColor];
	cellView.contentView.backgroundColor = [UIColor clearColor];
	TKDTestResultsRowView *rowView = (TKDTestResultsRowView *)cellView.rowView;
	NSArray *views = [rowView showItemViews:[models count] inWidth:self.tableView.frame.size.width andHeight:[self rowsHeight]];
	for (NSInteger i=0; i<[models count]; ++i)
	{
		TKDTestResultsNodeView *resultView = [views objectAtIndex:i];
		TKDTestNode *resultNode = [models objectAtIndex:i];
		
		TKDNodeView *nodeView = resultView.nodeView;
		[nodeView.imageView setImage:[resultNode.node cachedImage]];
		[nodeView.titleLabel setText:[resultNode.node localizedName]];
		[nodeView showImage:YES andName:YES hasToFillName:NO];
		[resultView setNErrors:[resultNode failures]];
	}
	
	[rowView setBackgroundColor:[UIColor clearColor] recursively:YES];
}


- (void)setupResultInstances
{
	NSInteger nElementsPerRow = [self nItemsPerRow];
	
	NSMutableArray *groupedResults = [NSMutableArray arrayWithCapacity:5];
	NSInteger firstIndex = 0;
	NSInteger length = MIN(nElementsPerRow, [self.loadedResults count]);
	while (length > 0)
	{
		NSArray *subrange = [self.loadedResults subarrayWithRange:NSMakeRange(firstIndex, length)];
		[groupedResults addObject:subrange];
		
		firstIndex += length;
		length = MIN(nElementsPerRow, ([self.loadedResults count]-firstIndex));
	}
	self.groupedResults = groupedResults;
}

- (NSInteger)nItemsPerRow
{
	if (IS_IPAD())
	{
		return (UIInterfaceOrientationIsPortrait(self.usedOrientation) ? 5 : 8);
	} else
	{
		return (UIInterfaceOrientationIsPortrait(self.usedOrientation) ? 3 : 5);
	}
}

- (CGFloat)rowsHeight
{
	return (IS_IPAD() ? 150.0f : 104.0f);
}


- (IBAction)exitAction:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Rotations
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[NSTimer scheduledTimerWithTimeInterval:duration/2.0 target:self selector:@selector(scheduledLayoutForRotation:) userInfo:[NSNumber numberWithInteger:toInterfaceOrientation] repeats:NO];
}

- (void)scheduledLayoutForRotation:(NSTimer *)timer
{
	self.usedOrientation = [timer.userInfo integerValue];
	[self setupResultInstances];
	[self.tableView reloadData];
}

@end

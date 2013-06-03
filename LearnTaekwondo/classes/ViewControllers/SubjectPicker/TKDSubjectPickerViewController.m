//
//  TKDSubjectPickerCellViewViewController.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDSubjectPickerViewController.h"
#import "TKDSubjectFactory.h"
#import "TKDSubject.h"
#import "TKDSubjectPicked.h"
#import "TKDSubjectsPickedRowCellView.h"
#import "TKDSubjectTestViewController.h"
#import "TKDSubjectPickedView.h"
#import "TKDSubjectsPickedRowView.h"

@interface TKDSubjectPickerViewController ()

@property (nonatomic, retain) NSArray *groupedSubjects;
@property (nonatomic, assign) NSInteger nSelectedSubjects;


- (NSInteger)nItemsPerRow;

@end

@implementation TKDSubjectPickerViewController

- (void)dealloc
{
	[_groupedSubjects release];
	[_subjectPickedModels release];
	[_tableView release];
	[_nextButton release];
	[super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self setupSubjectInstances];
	[self.tableView reloadData];
	
	[self.navigationItem setTitle:@"Kibon kisul"];
	[self.nextButton setTitle:NSLocalizedString(@"Siguiente", nil) forState:UIControlStateNormal];
	[[TKDViewStyles sharedInstance] styleButton:self.nextButton];
	self.nSelectedSubjects = 0;
}

- (void)setupSubjectInstances
{
	if (self.subjectPickedModels == nil)
	{
		NSArray *subjects = [[TKDSubjectFactory sharedInstance] subjectsInPlist:@"kibon_kisul"];
		NSMutableArray *subjectsPicked = [NSMutableArray arrayWithCapacity:[subjects count]];
		for (TKDSubject *subject in subjects)
		{
			TKDSubjectPicked *subjectPicked = [[[TKDSubjectPicked alloc] initWithSubject:subject] autorelease];
			[subjectsPicked addObject:subjectPicked];
		}
		self.subjectPickedModels = subjectsPicked;
	}
	
	NSInteger nItemsPerRow = [self nItemsPerRow];
	NSMutableArray *groupedSubjects = [NSMutableArray arrayWithCapacity:5];
	NSInteger firstIndex = 0;
	NSInteger length = MIN(nItemsPerRow, [self.subjectPickedModels count]);
	while (length > 0)
	{
		NSArray *subrange = [self.subjectPickedModels subarrayWithRange:NSMakeRange(firstIndex, length)];
		[groupedSubjects addObject:subrange];
		
		firstIndex += length;
		length = MIN(nItemsPerRow, ([self.subjectPickedModels count]-firstIndex));
	}
	self.groupedSubjects = groupedSubjects;
	
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	for (TKDSubjectPicked *subjectPicked in self.subjectPickedModels)
	{
		[subjectPicked setPicked:NO];
	}
	[self.tableView reloadData];
	[self setNSelectedSubjects:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
	for (TKDSubjectPicked *subjectPicked in self.subjectPickedModels)
	{
		[subjectPicked.subject purge];
	}
}

- (IBAction)nextAction:(id)sender
{
	if (self.nSelectedSubjects > 0)
	{
		NSMutableArray *pickedSubjects = [NSMutableArray arrayWithCapacity:[self.subjectPickedModels count]];
		for (TKDSubjectPicked *subjectPicked in self.subjectPickedModels)
		{
			if ([subjectPicked isPicked])
			{
				[pickedSubjects addObject:[subjectPicked subject]];
			}
		}
		
		TKDSubjectTestViewController *testVC;
		UINavigationController *navController = [TKDSubjectTestViewController navigationControllerWithViewController:&testVC];
		[testVC loadNodesForSubjects:pickedSubjects dan:1 nTests:10];
		
		[self presentViewController:navController animated:YES completion:nil];
	}
}


#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.groupedSubjects count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self rowsHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	TKDSubjectsPickedRowCellView *cellView = [tableView dequeueReusableCellWithIdentifier:[TKDSubjectsPickedRowCellView cellIdentifier]];
	if (cellView == nil)
	{
		cellView = [TKDSubjectsPickedRowCellView cellWithOwner:self];
	}
	
	NSArray *modelsForRow = [self.groupedSubjects objectAtIndex:indexPath.row];
	[self loadModels:modelsForRow toCellView:cellView];
	
	return cellView;
}


- (void)loadModels:(NSArray *)models toCellView:(TKDSubjectsPickedRowCellView *)cellView
{
	TKDSubjectsPickedRowView *rowView = (TKDSubjectsPickedRowView *)cellView.rowView;
	NSArray *itemsViews = [rowView showItemViews:[models count] inWidth:self.tableView.frame.size.width andHeight:[self rowsHeight]];
	
	cellView.backgroundColor = [UIColor clearColor];
	cellView.contentView.backgroundColor = [UIColor clearColor];
	cellView.rowView.backgroundColor = [UIColor clearColor];
	
	for (NSInteger i=0; i<[models count]; ++i)
	{
		TKDSubjectPickedView *itemView = [itemsViews objectAtIndex:i];
		TKDSubjectPicked *item = [models objectAtIndex:i];
		
		[itemView setUserInfo:item];
		[itemView.subjectImageView setImage:[item.subject cachedImage]];
		[itemView.subjectTitleLabel setText:[item.subject localizedName]];
		[itemView setPicked:[item isPicked]];
		
		[itemView setDelegate:self];
		[itemView setBackgroundColor:[UIColor clearColor]];
	}
}

#pragma mark - Private
- (void)setNSelectedSubjects:(NSInteger)nSelectedSubjects
{
	_nSelectedSubjects = nSelectedSubjects;
	[self.nextButton setEnabled:(nSelectedSubjects > 0)];
}


- (NSInteger)nItemsPerRow
{
	return (IS_IPAD() ? 3 : 2);
}

- (CGFloat)rowsHeight
{
	return (IS_IPAD() ? 200.0f : (IS_IPHONE_4_INCH() ? 138.0f : 122.0f));
}


#pragma mark - TKDSubjectPickedViewDelegate
- (void)subjectPickedViewAction:(TKDSubjectPickedView *)view
{
	TKDSubjectPicked *item = view.userInfo;
	[item setPicked:(![item isPicked])];
	
	if ([item isPicked])
	{
		self.nSelectedSubjects++;
	} else
	{
		self.nSelectedSubjects--;
	}
	
	NSInteger row = 0;
	BOOL found = NO;
	while (!found && row < [self.groupedSubjects count])
	{
		found = [[self.groupedSubjects objectAtIndex:row] containsObject:item];
		if (!found)
		{
			++row;
		}
	}
	
	if (found)
	{
		NSArray *indexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]];
		[self.tableView beginUpdates];
		[self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
		[self.tableView endUpdates];
	}
	[self.tableView reloadData];
}

@end

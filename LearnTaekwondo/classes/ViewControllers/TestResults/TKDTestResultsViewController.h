//
//  TKDTestResultsViewController.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDViewController.h"

@interface TKDTestResultsViewController : TKDViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIButton *continueButton;

/**
 * Instances of TKDTestNode
 */
- (void)loadResults:(NSArray *)results;

- (IBAction)exitAction:(id)sender;

@end

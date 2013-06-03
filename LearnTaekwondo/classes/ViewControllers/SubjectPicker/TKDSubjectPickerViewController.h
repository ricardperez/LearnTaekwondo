//
//  TKDSubjectPickerCellViewViewController.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDViewController.h"
#import "TKDSubjectPickedView.h"

@interface TKDSubjectPickerViewController : TKDViewController <UITableViewDataSource, UITableViewDelegate, TKDSubjectPickedViewDelegate>
{
}

@property (nonatomic, retain) NSArray *subjectPickedModels;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;

- (IBAction)nextAction:(id)sender;

@end

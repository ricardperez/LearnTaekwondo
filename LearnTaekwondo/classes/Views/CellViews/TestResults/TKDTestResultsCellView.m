//
//  TKDTestResultsCellView
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDTestResultsCellView.h"
#import "TKDTestResultsRowView.h"

@implementation TKDTestResultsCellView

static NSString *testResultsCellViewIdentifier = nil;
+ (NSString *)cellIdentifier
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		testResultsCellViewIdentifier = @"TKDTestResultsCellView";
	});
	return testResultsCellViewIdentifier;
}

+ (Class)rowViewClass
{
	return [TKDTestResultsRowView class];
}

@end

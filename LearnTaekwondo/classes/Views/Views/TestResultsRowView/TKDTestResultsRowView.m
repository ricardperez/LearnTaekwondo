//
//  TKDTestResultsRowView.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 31/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDTestResultsRowView.h"
#import "TKDTestResultsNodeView.h"


@implementation TKDTestResultsRowView

- (NSArray *)showItemViews:(NSInteger)nItems inWidth:(CGFloat)width andHeight:(CGFloat)height
{
	return [self showItemViews:nItems inWidth:width andHeight:height ofType:[TKDTestResultsNodeView class]];
}

@end

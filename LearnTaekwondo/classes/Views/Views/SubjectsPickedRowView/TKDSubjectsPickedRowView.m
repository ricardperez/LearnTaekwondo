//
//  TKDSubjectsPickedRowView.m
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 01/06/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDSubjectsPickedRowView.h"
#import "TKDSubjectPickedView.h"


@implementation TKDSubjectsPickedRowView


- (NSArray *)showItemViews:(NSInteger)nItems inWidth:(CGFloat)width andHeight:(CGFloat)height
{
	return [self showItemViews:nItems inWidth:width andHeight:height ofType:[TKDSubjectPickedView class]];
}

@end

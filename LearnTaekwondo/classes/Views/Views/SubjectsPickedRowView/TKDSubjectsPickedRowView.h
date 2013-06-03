//
//  TKDSubjectsPickedRowView.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 01/06/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKDGenericRowView.h"

@interface TKDSubjectsPickedRowView : TKDGenericRowView


- (NSArray *)showItemViews:(NSInteger)nItems inWidth:(CGFloat)width andHeight:(CGFloat)height;

@end

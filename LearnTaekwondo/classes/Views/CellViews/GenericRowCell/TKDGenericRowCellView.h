//
//  TKDGenericRowCellView.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 01/06/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import "TKDCellView.h"

@class TKDGenericRowView;

@interface TKDGenericRowCellView : TKDCellView

@property (nonatomic, retain) TKDGenericRowView *rowView;

+ (Class)rowViewClass;

@end

//
//  TKDSubjectPicked.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TKDSubject;

@interface TKDSubjectPicked : NSObject

@property (nonatomic, retain) TKDSubject *subject;
@property (nonatomic, assign, getter = isPicked) BOOL picked;

- (id)initWithSubject:(TKDSubject *)subject;

@end

//
//  TKDNodeFactory.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKDSubject;
@class TKDNode;

@interface TKDNodeFactory : NSObject

+ (TKDNodeFactory *)sharedInstance;

- (NSArray *)nodesForSubject:(TKDSubject *)subject dan:(unsigned int)dan;

@end

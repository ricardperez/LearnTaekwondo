//
//  TKDSubject.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 01/06/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TKDNode;
@interface TKDSubject : NSObject

@property (nonatomic, copy) NSString *keyName;
@property (nonatomic, copy) NSString *localizedName;
@property (nonatomic, retain) NSString *imageName;
/**
 * When accessed will load it if nil.
 * If purge is called, it will be released.
 */
@property (nonatomic, retain) UIImage *cachedImage;
@property (nonatomic, retain) NSMutableDictionary *nodes;

- (id)initWithKeyName:(NSString *)keyName;

/**
 * Dan may go from 1 to 9
 */
- (NSArray *)nodesForDan:(NSInteger)dan;

- (void)purge;

@end

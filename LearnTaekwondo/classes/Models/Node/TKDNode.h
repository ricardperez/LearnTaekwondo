//
//  TKDNode.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKDSubject;
@interface TKDNode : NSObject
{
}


@property (nonatomic, assign) TKDSubject *subject;
@property (nonatomic, copy) NSString *keyName;
@property (nonatomic, copy) NSString *localizedName;
@property (nonatomic, retain) NSString *imageName;

/**
 * When accessed will load it if nil.
 * If purge is called, it will be released.
 */
@property (nonatomic, retain) UIImage *cachedImage;

/**
 * Will release the cached image.
 * Should be called if a memory warning is triggered.
 */
- (void)purge;


- (id)initWithSubject:(TKDSubject *)subject andKeyName:(NSString *)keyName;

@end

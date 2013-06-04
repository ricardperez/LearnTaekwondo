//
//  TKDNode.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKDSubject;

/**
 * This is the representation of the subject childs. It has a name, an image and
 * a parent subject.
 * Like the TKDSubject, it will be constructed by passing a keyname, but here
 * also a subject instance which will be its parent.
 * With the keyname, the name and the image name will be constructed. The image
 * will be accessed lazily.
 * A purge method exists in order to free memory when a memory warning alert is
 * triggered. It will release the cached image and set the property to nil, so
 * next time asked, will be loaded again.
 */
@interface TKDNode : NSObject
{
}

/**
 * The parent subject. It's given by the constructor.
 * Should be readonly (externally).
 */
@property (nonatomic, assign) TKDSubject *subject;

/**
 * The keyname. This is going to be used to get the localized name and the image
 * name. It's given by the constructor.
 * Should be readonly (externally).
 */
@property (nonatomic, copy) NSString *keyName;

/**
 * The localized name is got by replacing all '_' characters from the keyname
 * property to spaces and uppercasing the first letter. This new string is then
 * used as a key to query the localizable strings file to get the final result.
 * Should be readonly (externally).
 */
@property (nonatomic, copy) NSString *localizedName;

/**
 * This property is got by appending a ".png" to the keyname property.
 * Should be readonly (externally).
 */
@property (nonatomic, retain) NSString *imageName;

/**
 * Will be loaded lazily using the imageName property.
 * If purge is called, it will be released and set to nil.
 */
@property (nonatomic, retain) UIImage *cachedImage;

/**
 * This message will release the cachedImage and set it to nil.
 * This should be called at any memory warning alert.
 */
- (void)purge;


- (id)initWithSubject:(TKDSubject *)subject andKeyName:(NSString *)keyName;

@end

//
//  TKDSubjectPicked.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TKDSubject;

/**
 * This class will be used to represent the models of the "Pick a subject"
 * screen. It will let us know which subject is picked.
 *
 * Instead of being a subclass of TKDSubject and adding a picked boolean, it
 * uses composition and has both TKDSubject and boolean properties.
 */
@interface TKDSubjectPicked : NSObject

/**
 * The subject that is or is not picked.
 */
@property (nonatomic, retain) TKDSubject *subject;

/**
 * The boolean to know if the subject is or is not picked.
 * By default it's set to NO.
 */
@property (nonatomic, assign, getter = isPicked) BOOL picked;

/**
 * Will set picked to false by default.
 */
- (id)initWithSubject:(TKDSubject *)subject;

@end

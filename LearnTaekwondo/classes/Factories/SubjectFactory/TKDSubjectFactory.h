//
//  TKDSubjectFactory.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 01/06/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKDSubjectFactory : NSObject

+ (TKDSubjectFactory *)sharedInstance;

- (NSArray *)subjectsInPlist:(NSString *)plist;

@end

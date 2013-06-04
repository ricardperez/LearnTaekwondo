//
//  AppDelegate.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 29/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

/**
 * The app delegate will be responsible to load the view controller hierarchy.
 * In this application, this is a single UINavigationController with an instance
 * of TKDSubjectPickerViewController as its root.
 * We use a navigation controller but we don't use to push views to it. We use 
 * it because of prevention for some day be able to push views.
 */
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 * The root view controller for the window.
 */
@property (strong, nonatomic) UINavigationController *navigationController;

@end

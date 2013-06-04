//
//  TKDViewController.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupportMacros.h"
#import "HelperFunctions.h"
#import "TKDViewStyles.h"

/**
 * Our custom ViewController base class.
 * This way, any generic change to all view controller will be added just once
 * to this base class.
 * It adds two class methods to instantiate an autoreleased controller by using
 * a nib of the same name than the class itself and to instantiate an
 * autoreleased navigation controller with a controller of this type as its
 * rooot.
 */
@interface TKDViewController : UIViewController

/**
 * Will return an autoreleased instance of this class using a nib name with the
 * same name of the class.
 * Will try to add the respective device suffix (DEVICE_SUFFIX macro) to that
 * name so the specific nib will be used. If not found, will try it again with
 * the IPHONE_SUFFIX. If not found, will try it again without any suffix.
 */
+ (id)viewController;

/**
 * Will return a new autoreleased UINavigationController by setting its root
 * view controller to an instance of this class (by invoking the viewController
 * message). If controllerRef is not nil, then it will be set to the instance of
 * this class.
 */
+ (UINavigationController *)navigationControllerWithViewController:(id *)controllerRef;

@end

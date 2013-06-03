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

@interface TKDViewController : UIViewController

+ (id)viewController;
+ (UINavigationController *)navigationControllerWithViewController:(id *)controllerRef;

@end

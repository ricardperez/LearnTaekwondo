//
//  SupportMacros.h
//  LearnTaekwondo
//
//  Created by Ricard Pérez del Campo on 30/05/13.
//  Copyright (c) 2013 Ricard Pérez del Campo. All rights reserved.
//

#ifndef LearnTaekwondo_SupportMacros_h
#define LearnTaekwondo_SupportMacros_h

#define IS_IPAD()			([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE()			([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4_INCH()	(IS_IPHONE() && (MAX([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) > 500.0f))
#define IS_RETINA()			([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] > 1.99f)
#define IPHONE_SUFFIX()		(@"iPhone")
#define IPHONE_4_INCH_SUFFIX()		(@"iPhone-568h")
#define IPAD_SUFFIX()		(@"iPad")
#define DEVICE_SUFFIX()		(IS_IPAD() ? IPAD_SUFFIX() : (IS_IPHONE_4_INCH() ? IPHONE_4_INCH_SUFFIX() : IPHONE_SUFFIX()))


#endif

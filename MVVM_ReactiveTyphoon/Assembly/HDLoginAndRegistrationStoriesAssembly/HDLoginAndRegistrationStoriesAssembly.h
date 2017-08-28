//
//  HDLoginAndRegistrationStoriesAssembly.h
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

//#import <Typhoon/Typhoon.h>

#import <Typhoon/Typhoon.h>

// Protocol Controller
#import "HDLoginVCPrtcl.h"

@interface HDLoginAndRegistrationStoriesAssembly : TyphoonAssembly

- (id <HDLoginVCPrtcl>) getHDLoginVC;

@end

//
//  HDWorkerStoriesAssembly.h
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Typhoon/Typhoon.h>

// Protocol Controllers
#import "HDWorkerTVCPrtcl.h"

@interface HDWorkerStoriesAssembly : TyphoonAssembly

- (id <HDWorkerTVCPrtcl>) getHDWorkerTVC;

@end

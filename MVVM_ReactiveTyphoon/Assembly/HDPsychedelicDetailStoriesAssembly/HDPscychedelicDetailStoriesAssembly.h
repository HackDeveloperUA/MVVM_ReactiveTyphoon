//
//  HDPscychedelicDetailStoriesAssembly.h
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Typhoon/Typhoon.h>


// Protocol Controller
#import "HDPsychedelicDetailTVCPrtcl.h"

@interface HDPscychedelicDetailStoriesAssembly : TyphoonAssembly

- (id <HDPsychedelicDetailTVCPrtcl>) getHDPsychedelicDetailTVC:(HDWorkerFull*) model;

@end

//
//  HDDetailStoriesAssembly.h
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Typhoon/Typhoon.h>

// Protocol ViewController
#import "HDDetailVCPrtcl.h"

@interface HDDetailStoriesAssembly : TyphoonAssembly

- (id <HDDetailVCPrtcl>) getHDDetailVCWithLinkOnFullCV:(NSString*) link;

@end

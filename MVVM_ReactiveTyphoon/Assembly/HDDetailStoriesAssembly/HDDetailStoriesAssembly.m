//
//  HDDetailStoriesAssembly.m
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDDetailStoriesAssembly.h"

// Protocol ViewModel
#import "HDWorkerDetailVMPrtcl.h"

// Real ViewModel
#import "HDWorkerDetailViewModel.h"

// Real ViewController
#import "HDDetailVC.h"

// Model
#import "HDWorkerFull.h"

@implementation HDDetailStoriesAssembly


- (id <HDDetailVCPrtcl>) getHDDetailVCWithLinkOnFullCV:(NSString*) link
{
   return [TyphoonDefinition withClass: [HDDetailVC class]
                         configuration:^(TyphoonDefinition *definition) {
          
            [definition injectProperty:@selector(vmWorkerDetail) with:[self getHDWorkerDetailViewModel:link]];
                             
          }];

}

- (id <HDWorkerDetailVMPrtcl>) getHDWorkerDetailViewModel:(NSString*) link
{
    return [TyphoonDefinition withClass:[HDWorkerDetailViewModel class]
                          configuration:^(TyphoonDefinition *definition) {
    
   [definition useInitializer:@selector(initWithLinkOnFull_CV_Model:) parameters:^(TyphoonMethod *initializer) {
       [initializer injectParameterWith: link];
   }];
                              
    }];
}




@end

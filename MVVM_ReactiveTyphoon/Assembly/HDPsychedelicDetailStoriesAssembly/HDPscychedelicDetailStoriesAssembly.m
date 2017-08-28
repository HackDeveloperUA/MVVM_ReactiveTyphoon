//
//  HDPscychedelicDetailStoriesAssembly.m
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDPscychedelicDetailStoriesAssembly.h"

// Protocol Controller
#import "HDPsychedelicDetailTVCPrtcl.h"

// Protocol ViewModel
#import "HDListOfPsychedelicWorkersTableVMPrtcl.h"


// Real Model
#import "HDWorkerFull.h"

// Real ViewModel
#import "HDListOfPsychedelicWorkersTableViewModel.h"

// Real Controller
#import "HDPsychedelicDetailTVC.h"


@implementation HDPscychedelicDetailStoriesAssembly


- (id <HDPsychedelicDetailTVCPrtcl>) getHDPsychedelicDetailTVC:(HDWorkerFull*) model
{
   return [TyphoonDefinition withClass: [HDPsychedelicDetailTVC class]
                   configuration:^(TyphoonDefinition *definition) {
                       

       [definition useInitializer: @selector(initWithVM:) parameters:^(TyphoonMethod* initializer){
           [initializer injectParameterWith:  [self getHDListOfPsychedelicWorkersTableViewModel:model]];
       }];
   
     }];
}

- (id <HDListOfPsychedelicWorkersTableVMPrtcl>) getHDListOfPsychedelicWorkersTableViewModel:(HDWorkerFull*) model
{
    return [TyphoonDefinition withClass: [HDListOfPsychedelicWorkersTableViewModel class]
                          configuration:^(TyphoonDefinition *definition) {
                              
            [definition injectProperty:@selector(modelWorker) with: model];
                              
                          }];
}

@end


//
//  HDWorkerStoriesAssembly.m
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDWorkerStoriesAssembly.h"

// Real Controller
#import "HDWorkerTVC.h"

// Protocol ViewModel
#import "HDListOfWorkersTableVMPrtcl.h"

// Real ViewModel
#import "HDListOfWorkersTableViewModel.h"


@implementation HDWorkerStoriesAssembly

- (id <HDWorkerTVCPrtcl>) getHDWorkerTVC
{
    return [TyphoonDefinition withClass:[HDWorkerTVC class]
                          configuration:^(TyphoonDefinition *definition) {
                             
    [definition injectProperty:@selector(vmListOfWorkersTableView) with:[self getHDListOfWorkersTableViewModel]];
                          }];
}

#pragma mark - Get ViewModels methods

- (id <HDListOfWorkersTableVMPrtcl>) getHDListOfWorkersTableViewModel
{
    return [TyphoonDefinition withClass: [HDListOfWorkersTableViewModel class]];
}

@end

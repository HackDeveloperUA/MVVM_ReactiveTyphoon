//
//  HDLoginAndRegistrationStoriesAssembly.m
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDLoginAndRegistrationStoriesAssembly.h"

// Real Controllers
#import "HDLoginVC.h"


// Protocol ViewModel
#import "HDAccountsDataVMPrtcl.h"

// Real ViewModel
#import "HDAccountsDataViewModel.h"


@implementation HDLoginAndRegistrationStoriesAssembly

- (id <HDLoginVCPrtcl>) getHDLoginVC
{
    return [TyphoonDefinition withClass:[HDLoginVC class]
                          configuration:^(TyphoonDefinition *definition) {
                      
    [definition injectProperty:@selector(vmAccountsData) with: [self getHDAccountsDataViewModel]];
                          
                          }];
}


#pragma mark - Get ViewModels methods

- (id <HDAccountsDataVMPrtcl>) getHDAccountsDataViewModel
{
    return [TyphoonDefinition withClass: [HDAccountsDataViewModel class]];
}

@end


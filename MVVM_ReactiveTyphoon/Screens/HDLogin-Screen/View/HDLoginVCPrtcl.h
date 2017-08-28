//
//  HDLoginVCPrtcl.h
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "HDAccountsDataVMPrtcl.h"

@protocol HDLoginVCPrtcl <NSObject>

@property (strong, nonatomic) id<HDAccountsDataVMPrtcl> vmAccountsData;

@end

//
//  HDDetailVCPrtcl.h
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HDWorkerDetailVMPrtcl.h"

@protocol HDDetailVCPrtcl <NSObject>

@property (nonatomic, strong) id <HDWorkerDetailVMPrtcl> vmWorkerDetail;

@end

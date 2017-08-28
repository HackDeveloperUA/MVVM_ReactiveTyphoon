//
//  HDWorkerTVCPrtcl.h
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HDListOfWorkersTableVMPrtcl.h"

@protocol HDWorkerTVCPrtcl <NSObject>

@property (nonatomic, strong) id <HDListOfWorkersTableVMPrtcl> vmListOfWorkersTableView;

@end

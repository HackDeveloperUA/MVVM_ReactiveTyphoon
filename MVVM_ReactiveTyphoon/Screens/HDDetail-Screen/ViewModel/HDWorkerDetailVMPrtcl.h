//
//  HDWorkerDetailVMPrtcl.h
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HDWorkerFull;

@protocol HDWorkerDetailVMPrtcl <NSObject>

@property (nonatomic, strong) HDWorkerFull *model;
@property (nonatomic, strong) NSString* linkOnFullCV;

@end

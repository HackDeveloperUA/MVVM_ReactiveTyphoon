//
//  HDAccountsDataVMPrtcl.h
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@protocol HDAccountsDataVMPrtcl <NSObject>


- (RACSignal*) signInBtnClicked:(NSString*)login
                        andPass:(NSString*) pass;

@end

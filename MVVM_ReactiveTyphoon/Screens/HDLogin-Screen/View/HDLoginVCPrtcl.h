//
//  HDLoginVCPrtcl.h
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBProgressHUD;
@class HDAccountsDataViewModel;


@protocol HDLoginVCPrtcl <NSObject>

@property (strong, nonatomic) HDAccountsDataViewModel* vmAccountsData;
@property (strong, nonatomic) MBProgressHUD *HUD;

@end

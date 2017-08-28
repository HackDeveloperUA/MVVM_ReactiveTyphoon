//
//  HDPsychedelicDetailTVCPrtcl.h
//  MVVM_Reactive
//
//  Created by Uber on 27/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HDListOfPsychedelicWorkersTableVMPrtcl.h"

@protocol HDPsychedelicDetailTVCPrtcl <NSObject>

@property(nonatomic, strong) id <HDListOfPsychedelicWorkersTableVMPrtcl> vmListOfPsychedelicWorkersTableView;

@end

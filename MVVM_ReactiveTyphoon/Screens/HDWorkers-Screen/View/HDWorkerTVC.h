//
//  WorkerTVC.h
//  MVVM_NonReactive
//
//  Created by Uber on 08/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>

// ViewModeles
#import "HDListOfWorkersTableViewModel.h"

/*
 RU:
 Экран с таблицией топ работников Apple
 
 EN:
 The screen with table top Apple workers
 */

@class Router;

@interface HDWorkerTVC : UITableViewController

@property (nonatomic, strong) HDListOfWorkersTableViewModel* vmListOfWorkersTableView; // link on controller viewmodel

@end

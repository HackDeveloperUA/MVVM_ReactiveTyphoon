//
//  PsychedelicDetailTVC.h
//  MVVM_NonReactive
//
//  Created by Uber on 14/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 RU:
 Экран на котором показано, как MVVM работает с ячейками разных типо и разных ViewModel.
 
 EN:
 A screen that shows you how MVVM works with cells of different types and different ViewModel.
 */

@class HDRouter;
@class HDListOfPsychedelicWorkersTableViewModel;


@interface HDPsychedelicDetailTVC : UITableViewController

// link on ViewModels
@property (nonatomic, strong) HDListOfPsychedelicWorkersTableViewModel* vmListOfPsychedelicWorkersTableView;

- (instancetype)initWithVM:(HDListOfPsychedelicWorkersTableViewModel*) vm;

@end

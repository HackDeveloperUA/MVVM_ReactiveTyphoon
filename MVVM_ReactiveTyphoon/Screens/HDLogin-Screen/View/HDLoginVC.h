//
//  HDLoginVC.h
//  MVVM_NonReactive
//
//  Created by Uber on 27/07/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>

// ViewModels
#import "HDAccountsDataViewModel.h"

// Utilites
#import "HDUtilites.h"

// Fraemworks
#import "MBProgressHUD.h"
#import "ANHelperFunctions.h"

/*
   RU:
   Экран на котором происходит процесс псевдо-аутентификации
   
   EN:
   The screen where the process of pseudo-authentication.
*/

@interface HDLoginVC : UIViewController

@property (strong, nonatomic) HDAccountsDataViewModel* vmAccountsData;

- (void) setupUI;

@end

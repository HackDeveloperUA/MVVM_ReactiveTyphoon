//
//  HDDetailVC.h
//  MVVM_NonReactive
//
//  Created by Uber on 08/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>

// ViewModels
#import "HDWorkerDetailViewModel.h"


/*
 RU:
 Экран где осуществляется детальный обзор профиля работника
 
 EN:
 The screen where the detailed review profile of the employee
 */

@interface HDDetailVC : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *cvImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postInCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *goToPscychedelicTVCbtn;


@property (strong, nonatomic) HDWorkerDetailViewModel* vmWorkerDetail; // link on controller ViewModel

- (void)bindWithViewModel:(HDWorkerDetailViewModel *)vm;

@end

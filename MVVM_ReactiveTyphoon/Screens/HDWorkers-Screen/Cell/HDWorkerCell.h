//
//  WorkerCell.h
//  MVVM_NonReactive
//
//  Created by Uber on 08/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>

// ViewModels
#import "HDWorkerCellViewModel.h"

// Fraemworks
#import <AFNetworking/UIImage+AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface HDWorkerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cvPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;

@property (weak, nonatomic) HDWorkerCellViewModel* vmWorkerCell; // link on cell viewmodel

- (void)bindWithViewModel:(HDWorkerCellViewModel *)vm;

@end

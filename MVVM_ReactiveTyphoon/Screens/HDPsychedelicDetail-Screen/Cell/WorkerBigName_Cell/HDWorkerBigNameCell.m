//
//  HDWorkerBigNameCell.m
//  MVVM_NonReactive
//
//  Created by Uber on 14/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDWorkerBigNameCell.h"

// ViewModels
#import "HDWorkerBigNameCellViewModel.h"

// Fraemworks
#import <AFNetworking/UIImage+AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation HDWorkerBigNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Bindings

- (void)bindWithViewModel:(HDWorkerBigNameCellViewModel *)vm
{
    RACScheduler* mainThreadScheduler = [RACScheduler mainThreadScheduler];
    
    RAC(self.fullNameLabel, text) = [[vm.fullNameSignal takeUntil:self.rac_prepareForReuseSignal] deliverOn:mainThreadScheduler];
    
    RAC(self.postInCompnayLabel, text) = [[vm.postTitleSignal takeUntil:self.rac_prepareForReuseSignal] deliverOn:mainThreadScheduler];
}

@end

//
//  HDWorkerRightAlignmentCell.m
//  MVVM_NonReactive
//
//  Created by Uber on 14/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDWorkerRightAlignmentCell.h"

// ViewModels
#import "HDWorkerRightAlignmentCellViewModel.h"

// Fraemworks
#import <AFNetworking/UIImage+AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation HDWorkerRightAlignmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - Bindings

- (void)bindWithViewModel:(HDWorkerRightAlignmentCellViewModel *)vm
{
    @weakify(self);
    RACScheduler* mainThreadScheduler = [RACScheduler mainThreadScheduler];
    
    RAC(self.fullNameLabel, text) = [[vm.fullNameSignal takeUntil:self.rac_prepareForReuseSignal] deliverOn:mainThreadScheduler];
    
    RAC(self.postInCompnayLabel, text) = [[vm.postTitleSignal takeUntil:self.rac_prepareForReuseSignal] deliverOn:mainThreadScheduler];
    
    [RACObserve(self.vmWorkerCell, cvImgURL) subscribeNext:^(id x) {
        @strongify(self);
        NSURL* imgURL = [NSURL URLWithString:x];
        [self.cvImgView setImageWithURL: imgURL];
    }];
}

- (void) setCvImgView:(UIImageView *)cvImgView
{
    _cvImgView = cvImgView;
    _cvImgView.layer.masksToBounds = YES;
    _cvImgView.layer.cornerRadius  = CGRectGetWidth(_cvImgView.frame)/2;
}


@end

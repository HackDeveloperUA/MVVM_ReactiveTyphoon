//
//  WorkerRightAlignment_Cell.h
//  MVVM_NonReactive
//
//  Created by Uber on 14/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HDWorkerRightAlignmentCellViewModel;

@interface HDWorkerRightAlignmentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cvImgView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postInCompnayLabel;

@property (weak, nonatomic) HDWorkerRightAlignmentCellViewModel* vmWorkerCell; // link on cell ViewModel

#pragma mark - Bindings
- (void)bindWithViewModel:(HDWorkerRightAlignmentCellViewModel *)vm;


@end

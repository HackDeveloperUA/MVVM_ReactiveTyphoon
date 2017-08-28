//
//  ViewModel_WorkerRightAlignment_Cell.m
//  MVVM_NonReactive
//
//  Created by Uber on 14/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDWorkerRightAlignmentCellViewModel.h"

// Model
#import "HDWorkerFull.h"

@implementation HDWorkerRightAlignmentCellViewModel

#pragma mark - Init methods

- (instancetype)initWithWorker:(HDWorkerFull*) worker
{
    self = [super init];
    if (self) {
        
        self.model   = worker;
        self.fullNameTitle = [NSString stringWithFormat:@"%@ %@", _model.firstName, _model.lastName];
        self.postInCompany = _model.postInCompany;
        self.cvImgURL      = _model.photoURL;
    }
    return self;
}

#pragma mark - Setters

-(void) setModel:(HDWorkerFull *)model
{
    _model = model;
    [self bindSignals];
}


#pragma mark - Binding methods

- (void)bindSignals
{
    RACSignal *workerSingal = [RACSignal return: self.model];
    
    self.fullNameSignal = [workerSingal map:^id(HDWorkerFull* worker) {
        return [NSString stringWithFormat:@"%@ %@",worker.firstName, worker.lastName];
    }];
    
    self.postTitleSignal = [workerSingal map:^id(HDWorkerFull* worker) {
        return worker.postInCompany;
    }];
    
    self.cvImageURLSignal = [workerSingal map:^id(HDWorkerFull* worker) {
        return worker.photoURL;
    }];
    
}


@end

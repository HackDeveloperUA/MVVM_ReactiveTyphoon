//
//  WorkerCell-VM.m
//  MVVM_NonReactive
//
//  Created by Uber on 08/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDWorkerCellViewModel.h"


@implementation HDWorkerCellViewModel


#pragma mark - Init methods

- (instancetype)initWithWorker:(HDWorkerShort*) worker
{
    self = [super init];
    if (self) {

        self.model         = worker;
        self.fullNameTitle = [NSString stringWithFormat:@"%@ %@",_model.firstName, _model.lastName];
        self.postTitle     = _model.postInCompany;
        self.cvImageURL    = _model.photoURL;
        self.linkOnFullModel = _model.linkOnFullModel;
    }
    return self;
}

#pragma mark - Setters

-(void) setModel:(HDWorkerShort *)model
{
    _model = model;
    [self bindSignals];
}


#pragma mark - Binding methods

- (void)bindSignals
{
    RACSignal *workerSingal = [RACSignal return: self.model];

    self.fullNameSignal = [workerSingal map:^id(HDWorkerShort* worker) {
        return [NSString stringWithFormat:@"%@ %@",worker.firstName, worker.lastName];
    }];
    
    self.postTitleSignal = [workerSingal map:^id(HDWorkerShort* worker) {
        return worker.postInCompany;
    }];
    
    self.cvImageURLSignal = [workerSingal map:^id(HDWorkerShort* worker) {
        return worker.photoURL;
    }];
    
    self.linkOnFullModelSignal = [workerSingal map:^id(HDWorkerShort* worker) {
        return worker.linkOnFullModel;
    }];
}

@end

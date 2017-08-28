//
//  ViewModel_WorkerLeftAlignment_Cell.h
//  MVVM_NonReactive
//
//  Created by Uber on 14/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDBasedWorkerCellViewModel.h"

// Reactive
#import <ReactiveCocoa/ReactiveCocoa.h>

@class HDWorkerFull;

@interface HDWorkerLeftAlignmentCellViewModel : HDBasedWorkerCellViewModel

@property (nonatomic, strong) HDWorkerFull* model; // link on model

@property (nonatomic, strong) NSString* fullNameTitle;
@property (nonatomic, strong) NSString* postInCompany;
@property (nonatomic, strong) NSString* cvImgURL;


@property (nonatomic) RACSignal *fullNameSignal;   //NSString
@property (nonatomic) RACSignal *postTitleSignal;  //NSString
@property (nonatomic) RACSignal *cvImageURLSignal; //NSString

#pragma mark - Init methods
- (instancetype)initWithWorker:(HDWorkerFull*) worker;

#pragma mark - Binding methods
- (void)bindSignals;

@end

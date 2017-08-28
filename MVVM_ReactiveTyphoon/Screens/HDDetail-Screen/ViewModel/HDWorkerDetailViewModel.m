//
//  DetailController_VM.m
//  MVVM_NonReactive
//
//  Created by Uber on 09/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDWorkerDetailViewModel.h"

// Models
#import "HDWorkerFull.h"
#import "HDPhotoModel.h"

// Server API
#import "HDServerManager.h"

// Router
#import "HDRouter.h"



@implementation HDWorkerDetailViewModel


#pragma mark - Init methods

- (instancetype)initWithWorker:(HDWorkerFull*) worker
{
    self = [super init];
    if (self) {
        
        self.modelWorker = worker;
        
        self.fullNameTitle =  [NSString stringWithFormat:@"%@ %@",_modelWorker.firstName, _modelWorker.lastName];
        self.postTitle     = self.modelWorker.postInCompany;
        self.mainTextTitle = self.modelWorker.mainText;
        self.cvImageURL    = self.modelWorker.photoURL;
    }
    return self;
}


- (instancetype)initWithLinkOnFull_CV_Model:(NSString*) link
{
    self = [super init];
    if (self) {
        self.linkOnFullCV = link;
       }
    return self;
}



#pragma mark - Binding methods

- (void)bindSignals
{
    if (self.modelWorker)
    {
        @weakify(self);
        
#warning Почему он не работает ? В классе ViewModel_Worker_Cell в методе bindSignals, используется точно такой же подход, только там работает, а тут нет ...


        // Шестой способ
        [[RACSignal combineLatest:@[RACObserve(self.modelWorker, firstName),
                                   RACObserve(self.modelWorker, lastName)]
                          reduce:^id(id fName, id lName){
                              NSLog(@"reduuce = %@", [NSString stringWithFormat:@"%@ %@",fName, lName]);
                              return [NSString stringWithFormat:@"%@ %@",fName, lName];
                          }] subscribeNext:^(id x) {
                              @strongify(self);
                              NSLog(@"subscribeNext = %@",x);
                              self.fullNameTitle = x;
                          }];
        [RACObserve(self.modelWorker, postInCompany) subscribeNext:^(id x) {
            @strongify(self);
            self.postTitle = x;
        }];
        [RACObserve(self.modelWorker, mainText) subscribeNext:^(id x) {
            @strongify(self);
            self.mainTextTitle = x;
        }];
        [RACObserve(self.modelWorker, photoURL) subscribeNext:^(id x) {
            @strongify(self);
            self.cvImageURL = x;
        }];
    }
}



#pragma mark - UI Handlers

- (void) openImgCVonFullScreenWithPhotoModel:(id<NYTPhoto>) model
{
    [[HDRouter sharedRouter] openNYTPhotovVCwithPhotoModel:model];
}

- (void) goToPscychedelicTVC_Clicked
{
    [[HDRouter sharedRouter] openPsychedelicDetailTVC:self.modelWorker];
}

#pragma mark - API

- (RACSignal*) get_FullWorkerModelByLink:(NSString*) link
{
    return  [[HDServerManager sharedManager] getFullInfoByWorkers:link];
}


#pragma mark - Setters

- (void) setLinkOnFullCV:(NSString *)linkOnFullCV
{
    _linkOnFullCV = linkOnFullCV;
    [[self get_FullWorkerModelByLink:linkOnFullCV] subscribeNext:^(HDWorkerFull* x) {
        
        self.modelWorker = x;
        self.fullNameTitle = x.firstName;
    }];
}

- (void) setModelWorker:(HDWorkerFull *)model
{
    _modelWorker = model;
    [self bindSignals];
}

@end

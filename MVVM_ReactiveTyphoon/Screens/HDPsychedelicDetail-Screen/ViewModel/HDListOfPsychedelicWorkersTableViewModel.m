//
//  ViewModel_ListOfPsychedelicWorkers_TableView.m
//  MVVM_NonReactive
//
//  Created by Uber on 14/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDListOfPsychedelicWorkersTableViewModel.h"

// Cell VM
#import "HDBasedWorkerCellViewModel.h"
#import "HDWorkerBigNameCellViewModel.h"
#import "HDWorkerRightAlignmentCellViewModel.h"
#import "HDWorkerLeftAlignmentCellViewModel.h"

// Cell
#import "HDWorkerLeftAlignmentCell.h"
#import "HDWorkerRightAlignmentCell.h"
#import "HDWorkerBigNameCell.h"


// Model
#import "HDWorkerFull.h"

// Router
#import "HDRouter.h"


#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))


@implementation HDListOfPsychedelicWorkersTableViewModel


#pragma mark - Init methods

- (instancetype)initWithWorker:(HDWorkerFull*) workerModel
{
    self = [super init];
    if (self) {
        self.vmForCellsArray = [NSMutableArray array];
        self.modelWorker = workerModel;
    }
    return self;
}


#pragma mark - Methods for TableView work

- (NSInteger) countWorkers {
    return self.vmForCellsArray.count;
}

- (HDBasedWorkerCellViewModel*) cellViewModel:(NSInteger) index {
    if (index > self.vmForCellsArray.count){
        return nil;
    }
    return self.vmForCellsArray[index];
}



#pragma mark - Reactive API Method
- (RACSignal*) getSignal_generateVMforCells
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
        
        self.vmForCellsArray = [NSMutableArray arrayWithArray:[self generateVMforCells]];
      
        if (self.vmForCellsArray.count>0){
            [subscriber sendNext:@(YES)];
        } else{
            [subscriber sendNext:@(NO)];
        }
        
        return nil;
    }];
}


#pragma mark - None Reactive API Method

- (void) generateVMforCells:(void(^)(BOOL successOperation)) success
                  onFailure:(void(^)(NSError* errorBlock)) failure
{
    self.vmForCellsArray = [NSMutableArray arrayWithArray:[self generateVMforCells]];
    if (self.vmForCellsArray.count>0){
        success(YES);
    } else{
        NSError* error=[NSError errorWithDomain:@"Empty array" code:100 userInfo:nil];
        failure(error);
    }
}


#pragma mark - UI Handlers

- (void) didSelectAtRowFromTable:(NSIndexPath*) indexPath {
    // ...
}


#pragma mark - Others helpers

- (NSArray*) generateVMforCells
{
    NSInteger countLeftAlignmentCell  =  RAND_FROM_TO(1, 50);
    NSInteger countRightAlignmentCell =  RAND_FROM_TO(1, 50);
    NSInteger countBigNameCell        =  RAND_FROM_TO(1, 50);
    
    NSMutableArray* vmForCellsArray = [NSMutableArray new];
    
    for (int i = 0; i <= (countLeftAlignmentCell+countRightAlignmentCell+countBigNameCell); i++)
    {
        if (i % 2 == 0)
        {
            if (arc4random() % 2 == 0)
                [vmForCellsArray addObject:[[HDWorkerLeftAlignmentCellViewModel alloc] initWithWorker:_modelWorker]];
            else
                [vmForCellsArray addObject:[[HDWorkerRightAlignmentCellViewModel alloc] initWithWorker:_modelWorker]];
        } else {
            if (arc4random() % 2 == 0)
                [vmForCellsArray addObject:[[HDWorkerBigNameCellViewModel alloc]initWithWorker:_modelWorker]];
        }
    }
    return vmForCellsArray;
}

@end

//
//  WorkerViewModel.m
//  MVVM_NonReactive
//
//  Created by Uber on 08/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDListOfWorkersTableViewModel.h"

// Model
#import "HDWorkerShort.h"

// Router
#import "HDRouter.h"

// Server API
#import "HDServerManager.h"

@implementation HDListOfWorkersTableViewModel


#pragma mark - Init methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellsArray = [NSMutableArray array];
        
    }
    return self;
}


#pragma mark - Methods for TableView work

- (NSInteger) countWorkers{
    return self.cellsArray.count;
}


- (HDWorkerCellViewModel*) cellViewModel:(NSInteger) index {
   
    if (index > self.cellsArray.count){
        return nil;
    }
    return self.cellsArray[index];
}


#pragma mark  - UI Handlers

- (void) didSelectAtRowFromTable:(NSIndexPath*) indexPath {
    
    HDWorkerCellViewModel* cellVM = [self cellViewModel:indexPath.row];
    [[HDRouter sharedRouter] openDetailVCwithLinkOnFullCV: cellVM.linkOnFullModel];
}

- (void) logoutBtnClicked {
    
    [[HDRouter sharedRouter] setIsLoginInUserDefaults:NO];
    [[HDRouter sharedRouter] openLoginVC];
}

#pragma mark - Reactive API Method
   

- (RACSignal*) getSignalUpdateWorkerList
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [self.cellsArray removeAllObjects];
        
        [[[HDServerManager sharedManager] getListAllWorkers] subscribeNext:^(NSArray *arrayWorkers) {
            
            self.modelArray = [NSMutableArray arrayWithArray:arrayWorkers];
            for (HDWorkerShort* worker in arrayWorkers) {
                [self.cellsArray addObject: [[HDWorkerCellViewModel alloc] initWithWorker: worker]];
            }
            [subscriber sendNext:@(YES)];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        } completed:^{
            
        }];
        
        return nil;
    }];
}


#pragma mark - None Reactive API Method

- (void) updateWorkerList:(void(^)(BOOL successOperation)) success
                onFailure:(void(^)(NSError* errorBlock,  NSObject* errObj)) failure {
    
    [self.cellsArray removeAllObjects];
    
    [[HDServerManager sharedManager] getListAllWorkers:^(NSArray *arrayWorkers) {
        self.modelArray = [NSMutableArray arrayWithArray:arrayWorkers];
        
        for (HDWorkerShort* worker in arrayWorkers) {
            [self.cellsArray addObject: [[HDWorkerCellViewModel alloc] initWithWorker: worker]];
        }
        
        success(YES);
        
    } onFailure:^(NSError *errorBlock, NSInteger statusCode) {
        
        failure(errorBlock, [NSObject new]);
    }];
}

@end


































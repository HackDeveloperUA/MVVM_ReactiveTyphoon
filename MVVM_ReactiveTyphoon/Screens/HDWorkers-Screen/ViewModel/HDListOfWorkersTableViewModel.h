//
//  WorkerViewModel.h
//  MVVM_NonReactive
//
//  Created by Uber on 08/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>

// Cell VM
#import "HDWorkerCellViewModel.h"

// ReactiveCocoa
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface HDListOfWorkersTableViewModel : NSObject

@property (nonatomic, strong) NSMutableArray* cellsArray; // Here store ViewModels
@property (nonatomic, strong) NSMutableArray* modelArray; // Here story Model


#pragma mark - Methods for TableView work

- (HDWorkerCellViewModel*) cellViewModel:(NSInteger) index;
- (NSInteger) countWorkers;

#pragma mark  - UI Handlers

- (void) didSelectAtRowFromTable:(NSIndexPath*) indexPath;
- (void) logoutBtnClicked;


#pragma mark - Reactive API Method

- (RACSignal*) getSignalUpdateWorkerList;


#pragma mark - None Reactive API Method

- (void) updateWorkerList:(void(^)(BOOL successOperation)) success
                onFailure:(void(^)(NSError* errorBlock,  NSObject* errObj)) failure;

@end

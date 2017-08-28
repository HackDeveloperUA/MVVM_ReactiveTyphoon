//
//  HDListOfPsychedelicWorkersTableViewModel.h
//  MVVM_NonReactive
//
//  Created by Uber on 14/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>

// Reactive
#import <ReactiveCocoa/ReactiveCocoa.h>


@class HDWorkerFull;
@class HDBasedWorkerCellViewModel;

@interface HDListOfPsychedelicWorkersTableViewModel : NSObject

@property (nonatomic, strong) NSMutableArray* vmForCellsArray;  // Here store ViewModels
@property (nonatomic, strong) HDWorkerFull*     modelWorker;      // Here story Model


#pragma mark - Init methods
- (instancetype)initWithWorker:(HDWorkerFull*) workerModel;


#pragma mark - Methods for TableView work
- (HDBasedWorkerCellViewModel*) cellViewModel:(NSInteger) index;
- (NSInteger) countWorkers;


#pragma mark - Reactive API Method
- (RACSignal*) getSignal_generateVMforCells;


#pragma mark - None Reactive API Method
- (void) generateVMforCells:(void(^)(BOOL successOperation)) success
                  onFailure:(void(^)(NSError* errorBlock)) failure;


#pragma mark - UI Handlers
- (void) didSelectAtRowFromTable:(NSIndexPath*) indexPath;

@end








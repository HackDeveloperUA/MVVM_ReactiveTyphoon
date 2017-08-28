//
//  WorkerCell-VM.h
//  MVVM_NonReactive
//
//  Created by Uber on 08/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>

// Model
#import "HDWorkerShort.h"

// Reactive Cocoa
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface HDWorkerCellViewModel : NSObject

@property (nonatomic, strong) HDWorkerShort* model; // link on model

@property (nonatomic, strong) NSString* fullNameTitle;
@property (nonatomic, strong) NSString* postTitle;
@property (nonatomic, strong) NSString* cvImageURL;
@property (nonatomic, strong) NSString* linkOnFullModel;

@property (nonatomic) RACSignal *fullNameSignal;   //NSString
@property (nonatomic) RACSignal *postTitleSignal;  //NSString
@property (nonatomic) RACSignal *cvImageURLSignal; //NSString
@property (nonatomic) RACSignal *linkOnFullModelSignal; //NSString


#pragma mark - Init methods
- (instancetype)initWithWorker:(HDWorkerShort*) worker;

#pragma mark - Binding methods
- (void)bindSignals;




@end

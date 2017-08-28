//
//  ServerManager.h
//  MVVM_NonReactive
//
//  Created by Uber on 27/07/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@class HDWorkerFull;

@interface HDServerManager : NSObject

+ (HDServerManager*) sharedManager;


//----- Get Accounts login & password -----//
- (void) getAccountsData:(void(^)(NSDictionary* dictWithLoginAndPassword)) success
               onFailure:(void(^)(NSError* errorBlock,  NSInteger statusCode)) failure;


//----- Get List Workers -----//
- (void) getListAllWorkers:(void(^)(NSArray* arrayWorkers)) success
                 onFailure:(void(^)(NSError* errorBlock, NSInteger statusCode)) failure;


//----- Get Full Info about worker -----//
- (void) getFullInfoByWorkers:(NSString *)link
                    onSuccess:(void(^)(HDWorkerFull* worker)) success
                    onFailure:(void(^)(NSError* errorBlock,  NSInteger statusCode)) failure;


//////////// ReactiveCocoa ///////////////

- (RACSignal*) getAccountsData;
- (RACSignal*) getListAllWorkers;
- (RACSignal*) getFullInfoByWorkers:(NSString *)link;


@end

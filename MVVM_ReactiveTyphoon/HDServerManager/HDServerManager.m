//
//  ServerManager.m
//  MVVM_NonReactive
//
//  Created by Uber on 27/07/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDServerManager.h"

// Models
#import "HDWorkerFull.h"
#import "HDWorkerShort.h"
#import "FEMDeserializer.h"


@interface HDServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@property (strong, nonatomic) dispatch_queue_t requestQueue;

@end


@implementation HDServerManager

+ (HDServerManager*) sharedManager
{
    
    static HDServerManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HDServerManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    
    self = [super init];
    if (self)
    {
        self.requestQueue = dispatch_queue_create("MVVM_ReactiveTyphoon.request", DISPATCH_QUEUE_PRIORITY_DEFAULT);
        
        self.manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json",@"text/html", nil];
    }
    return self;
}



//////////// ReactiveCocoa ///////////////

- (RACSignal*) getAccountsData
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        [self.manager GET:@"https://raw.githubusercontent.com/HackDeveloperUA/JSON-ForExampleProjects/master/accountsData.json"
               parameters:nil
                 progress:nil
                  success:^(NSURLSessionDataTask* task, NSDictionary* responseObject) {
                      
                      NSDictionary *json = (NSDictionary *)responseObject[@"accounts"];
                      
                      [subscriber sendNext:json];
                      [subscriber sendCompleted];
                  }
                  failure:^(NSURLSessionDataTask* task, NSError*  error) {
                      
                      [subscriber sendError:error];
                  }];
        return nil;
    }] deliverOn:[RACScheduler scheduler]];
}



- (RACSignal*) getListAllWorkers
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        [self.manager GET:@"https://raw.githubusercontent.com/HackDeveloperUA/JSON-ForExampleProjects/master/workersData.json"
               parameters:nil
                 progress:nil
                  success:^(NSURLSessionDataTask *  task, NSDictionary*   responseObject) {
                      
                      NSDictionary *json = (NSDictionary *)responseObject;
                      if (json) {
                          NSArray* list = [self parseWithMapping:json andClassModel:[HDWorkerShort class]];
                          [subscriber sendNext:list];
                          [subscriber sendCompleted];
                      }
                  }
                  failure:^(NSURLSessionDataTask* task, NSError* error) {
                      
                      [subscriber sendError:error];
                  }];
        
        return nil;
    }] deliverOn:[RACScheduler scheduler]];
}



- (RACSignal*) getFullInfoByWorkers:(NSString *)link
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [self.manager GET:link
               parameters:nil
                 progress:nil
                  success:^(NSURLSessionDataTask* task, id responseObject) {
                      
                      NSDictionary *json = (NSDictionary *)responseObject;
                      if (json) {
                          HDWorkerFull* worker = [self parseWithMapping:json andClassModel:[HDWorkerFull class]];
                          [subscriber sendNext:worker];
                          [subscriber sendCompleted];
                      }
                  }
                  failure:^(NSURLSessionDataTask* task, NSError* error) {
                      [subscriber sendError:error];
                  }];
        return nil;
    }] deliverOn:[RACScheduler scheduler]];
}





// ----------  NON REACTIVE METHODS ---------  //




//----- Get Accounts login & password -----//
- (void) getAccountsData:(void(^)(NSDictionary* dictWithLoginAndPassword)) success
               onFailure:(void(^)(NSError* errorBlock,  NSInteger statusCode)) failure
{
    
    [self.manager GET:@"https://raw.githubusercontent.com/HackDeveloperUA/JSON-ForExampleProjects/master/accountsData.json"
           parameters:nil
             progress:nil
              success:^(NSURLSessionDataTask* task, NSDictionary* responseObject) {
                  
                  NSDictionary *json = (NSDictionary *)responseObject[@"accounts"];
                  success(json);
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
                  failure(error, error.code);
              }];
}


//----- Get List Workers -----//

- (void) getListAllWorkers:(void(^)(NSArray* arrayWorkers)) success
                 onFailure:(void(^)(NSError* errorBlock, NSInteger statusCode)) failure
{
    
    [self.manager GET:@"https://raw.githubusercontent.com/HackDeveloperUA/JSON-ForExampleProjects/master/workersData.json"
           parameters:nil
             progress:nil
              success:^(NSURLSessionDataTask *  task, NSDictionary*   responseObject) {
                  
                  NSDictionary *json = (NSDictionary *)responseObject;
                  if (json) {
                      success([self parseWithMapping:json andClassModel:[HDWorkerShort class]]);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
                  failure(error, error.code);
              }];
}

//----- Get Full Info about worker -----//

- (void) getFullInfoByWorkers:(NSString *)link
                    onSuccess:(void(^)(HDWorkerFull* worker)) success
                    onFailure:(void(^)(NSError* errorBlock,  NSInteger statusCode)) failure
{
    [self.manager GET:link
           parameters:nil
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  
                  NSDictionary *json = (NSDictionary *)responseObject;
                  if (json) {
                      success([self parseWithMapping:json andClassModel:[HDWorkerFull class]]);
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
                  failure(error, error.code);
              }];
}


#pragma mark - Helpers Method


- (id) parseWithMapping:(NSDictionary*) responDict andClassModel:(Class) modelClass
{
    
    if ([modelClass isSubclassOfClass:[HDWorkerShort class]]) {
        FEMMapping* objectMapping = [HDWorkerShort defaultMapping];
        NSArray*    modelsArray   = [FEMDeserializer collectionFromRepresentation:responDict[@"workers"] mapping:objectMapping];
        return modelsArray;
    }
    
    if ([modelClass isSubclassOfClass:[HDWorkerFull class]]) {
        FEMMapping *mapping     = [HDWorkerFull defaultMapping];
        HDWorkerFull *worker = [FEMDeserializer objectFromRepresentation:responDict mapping: mapping];
        return worker;
    }
    return @"Not found Classes Model";
}

@end

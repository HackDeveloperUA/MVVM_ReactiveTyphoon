//
//  PsychedelicDetailTVC.m
//  MVVM_NonReactive
//
//  Created by Uber on 14/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDPsychedelicDetailTVC.h"

// ViewModel - Controller
#import "HDListOfPsychedelicWorkersTableViewModel.h"

// ViewModel - Cells
#import "HDBasedWorkerCellViewModel.h"
#import "HDWorkerLeftAlignmentCellViewModel.h"
#import "HDWorkerRightAlignmentCellViewModel.h"
#import "HDWorkerBigNameCellViewModel.h"

// View - Cells
#import "HDWorkerLeftAlignmentCell.h"
#import "HDWorkerRightAlignmentCell.h"
#import "HDWorkerBigNameCell.h"

// Model
#import "HDWorkerFull.h"

// Router
#import "HDRouter.h"

// Another fraemworks
#import <ANHelperFunctions/ANHelperFunctions.h>

@interface HDPsychedelicDetailTVC ()

@end

@implementation HDPsychedelicDetailTVC

#pragma mark - Init methods

- (instancetype)initWithVM:(HDListOfPsychedelicWorkersTableViewModel*) vm
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"HDPsychedelicDetailTVC"];
    
    if (self) {
        self.vmListOfPsychedelicWorkersTableView = vm;
        [[RACObserve(self.vmListOfPsychedelicWorkersTableView.modelWorker, firstName) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            self.title = x;
        }];
        
    }
    return self;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.vmListOfPsychedelicWorkersTableView countWorkers];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell;
    
    if ([[_vmListOfPsychedelicWorkersTableView cellViewModel:indexPath.row]   isKindOfClass: [HDWorkerLeftAlignmentCellViewModel class]]){
        
        cell = (HDWorkerLeftAlignmentCell*)[tableView dequeueReusableCellWithIdentifier:@"HDWorkerLeftAlignmentCell"];
    }
    
    if ([[_vmListOfPsychedelicWorkersTableView cellViewModel:indexPath.row]   isKindOfClass: [HDWorkerRightAlignmentCellViewModel class]]){
        
        cell = (HDWorkerRightAlignmentCell*)[tableView dequeueReusableCellWithIdentifier:@"HDWorkerRightAlignmentCell"];
    }
    
    if ([[_vmListOfPsychedelicWorkersTableView cellViewModel:indexPath.row]   isKindOfClass: [HDWorkerBigNameCellViewModel class]]){
        
        cell = (HDWorkerBigNameCell*)[tableView dequeueReusableCellWithIdentifier:@"HDWorkerBigNameCell"];
    }

    return cell;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self configureCell:cell atIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.vmListOfPsychedelicWorkersTableView didSelectAtRowFromTable:indexPath];
}


#pragma mark - UITableView helper methods

- (void)configureCell:(id)cell atIndexPath:(NSIndexPath *)indexPath
{
    ANDispatchBlockToBackgroundQueue(^{
       
        id vm  = [self.vmListOfPsychedelicWorkersTableView cellViewModel:indexPath.row];
      
        if ([vm isKindOfClass: [HDWorkerLeftAlignmentCellViewModel class]]){
            [cell bindWithViewModel:vm];
        }
        
        if ([vm isKindOfClass: [HDWorkerRightAlignmentCellViewModel class]]){
            [cell bindWithViewModel:vm];
        }
        
        if ([vm isKindOfClass: [HDWorkerBigNameCellViewModel class]]){
            [cell bindWithViewModel:vm];
        }
    });
}

#pragma mark - Others


- (void) setVmListOfPsychedelicWorkersTableView:(HDListOfPsychedelicWorkersTableViewModel *)vmListOfPsychedelicWorkersTableView {
    
    _vmListOfPsychedelicWorkersTableView = vmListOfPsychedelicWorkersTableView;
    
    @weakify(self);
    RACScheduler* mainThreadScheduler = [RACScheduler mainThreadScheduler];
   
    [[[vmListOfPsychedelicWorkersTableView getSignal_generateVMforCells] deliverOn:mainThreadScheduler]
     subscribeNext:^(NSNumber* successOperation) {
       
         @strongify(self);
         if ([successOperation boolValue]){
             [self.tableView reloadData];
         }
        
    }error:^(NSError *error) {
        NSLog(@"getSignal_generateVMforCells error = %@",error);

    } completed:^{
        NSLog(@"getSignal_generateVMforCells completed");
    }];
}

@end

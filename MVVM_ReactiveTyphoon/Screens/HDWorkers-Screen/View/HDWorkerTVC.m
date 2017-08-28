//
//  WorkerTVC.m
//  MVVM_NonReactive
//
//  Created by Uber on 08/08/2017.
//  Copyright © 2017 Uber. All rights reserved.
//

#import "HDWorkerTVC.h"


// ViewModels
#import "HDWorkerCellViewModel.h"

// Models
#import "HDWorkerShort.h"

// Cell
#import "HDWorkerCell.h"

// Another fraemworks
#import <ANHelperFunctions/ANHelperFunctions.h>

@interface HDWorkerTVC ()


@end

@implementation HDWorkerTVC

#pragma mark - Inits methods

- (instancetype)init
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"HDWorkerTVC"];
    
    if (self) {
        self.title = @"Apple`s Engineers";
        
        UIImage *logOutIcon   = [[UIImage imageNamed:@"logout"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        if (self.navigationItem){
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:logOutIcon
                                                                                      style:UIBarButtonItemStylePlain
                                                                                     target:self
                                                                                     action:@selector(logoutAction)];
        }
    }
    return self;
}


#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    [RACObserve(self.vmListOfWorkersTableView, cellsArray) subscribeNext:^(NSArray* cellsArray) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.vmListOfWorkersTableView countWorkers];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[_vmListOfWorkersTableView cellViewModel:indexPath.row] isKindOfClass: [HDWorkerCellViewModel class]]){
         HDWorkerCell* cell  = (HDWorkerCell*)[tableView dequeueReusableCellWithIdentifier:@"HDWorkerCell"];
         [self configureCell:cell atIndexPath:indexPath];
         return cell;
    }
  return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.vmListOfWorkersTableView didSelectAtRowFromTable:indexPath];
}

#pragma mark - UITableView helper methods

- (void)configureCell:(id)cell atIndexPath:(NSIndexPath *)indexPath
{
    ANDispatchBlockToBackgroundQueue(^{
        id vm  = [self.vmListOfWorkersTableView cellViewModel:indexPath.row];
        if ([vm isKindOfClass: [HDWorkerCellViewModel class]]){
            [cell bindWithViewModel:vm];
        }
    });
}


#pragma mark - Actions

- (void)logoutAction {
    [self.vmListOfWorkersTableView logoutBtnClicked];
}

#pragma mark - Others

// Setters
- (void) setVmListOfWorkersTableView:(HDListOfWorkersTableViewModel *)vmListOfWorkers_TableView
{
    @weakify(self);
    [[vmListOfWorkers_TableView getSignalUpdateWorkerList] subscribeNext:^(NSNumber* successOperation) {
        @strongify(self);
        ANDispatchBlockToMainQueue(^{
            [self.tableView reloadData];
        });
    } error:^(NSError *error) {
        NSLog(@"setControllerVM = %@",error);
    }];
    _vmListOfWorkersTableView = vmListOfWorkers_TableView;
}

@end

//
//  LoadsTableViewController.m
//  NewAFTemplateProject
//
//  Created by shane davis on 08/03/2014.
//  Copyright (c) 2014 shane davis. All rights reserved.
//

#import "LoadsTableViewController.h"
#import "Load.h"
@interface LoadsTableViewController ()<NSFetchedResultsControllerDelegate>{
    NSFetchedResultsController *_fetchedResultsController;
}
@property BOOL isOnline;
- (void)refetchData;
@end

@implementation LoadsTableViewController

- (void)refetchData {
    _fetchedResultsController.fetchRequest.resultType = NSManagedObjectResultType;
    [_fetchedResultsController performFetch:nil];
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    _isOnline = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeOnline:) name:@"didBecomeOnlineNotifcation" object:nil];
    
    //NSString *vehicleId = @"123456";
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Loads", nil);
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Load"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"custName" ascending:YES selector:@selector(localizedStandardCompare:)]];
  

    fetchRequest.returnsObjectsAsFaults = NO;
//    fetchRequest.predicate =  [NSPredicate predicateWithFormat:@"custName == %@",@"Pepsi"];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[(id)[[UIApplication sharedApplication] delegate] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    

    _fetchedResultsController.delegate = self;
    [_fetchedResultsController performFetch:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refetchData)];
    


}

-(void)becomeOnline:(NSNotification*)note{
    _isOnline = !_isOnline;
    NSError *error = nil;
    if(![[(id)[[UIApplication sharedApplication] delegate] managedObjectContext] save:&error]){
        NSLog(@"Error %@", [error localizedDescription]);
    }
    NSLog(@"application became online");
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[_fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Load *load = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = load.custName;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationFade];

    [[(id)[[UIApplication sharedApplication] delegate] managedObjectContext] performBlock:^{
        Load *load = (Load *)[_fetchedResultsController objectAtIndexPath:indexPath];
        NSLog(@"load:: %@", load);
        load.custName = @"COFFEE";
        NSError *error;
        [load.managedObjectContext save:&error];
//       [[(id)[[UIApplication sharedApplication] delegate] managedObjectContext] save:&error];
    }];
//    [[(id)[[UIApplication sharedApplication] delegate] managedObjectContext] save:&error];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

@end
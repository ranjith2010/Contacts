//
//  ViewController.m
//  Contacts
//
//  Created by Ranjith on 16/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CPeopleTableViewController.h"
#import "CServer.h"
#import "CServerInterface.h"
#import "CLocal.h"
#import "CLocalInterface.h"
#import "CEditViewController.h"
#import "CDisplayViewController.h"
#import "CConstants.h"
#import "UIAlertView+ZPBlockAdditions.h"
#import "NSMutableDictionary+Additions.h"

#import "CServerUserInterface.h"
#import "CServerUser.h"
#import "CDisplayViewController.h"

@interface CPeopleTableViewController ()

@property (nonatomic)UIRefreshControl *refreshControl;
@property (nonatomic,strong)NSArray *dataSource;
@property (nonatomic,strong)NSMutableArray *receivedContacts;

@property (nonatomic)id<CServerUserInterface> serverUser;
@property (nonatomic)id<CServerInterface> server;

@end

@implementation CPeopleTableViewController
@synthesize refreshControl;

#pragma mark - ViewController Delegates
- (void)viewDidLoad {
    [super viewDidLoad];
    self.serverUser = [CServerUser defaultUser];
    self.server = [CServer defaultParser];
    self.navigationController.title = @"Home";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self pr_viewDidLoad];
    [self fetchAllContacts];
}

#pragma mark -


# pragma mark - Private API
- (void)pr_viewDidLoad {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContact)];
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(fetchAllContacts) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchAllContacts];
}

- (void)pr_pullDownToRefreshSelector {
    [self fetchAllContacts];
}

- (void)fetchAllContacts {
        if([self.serverUser hasCurrentUser]) {
        [self.server readAllContacts:^(NSArray *contacts, NSError *error) {
            [self.refreshControl endRefreshing];
            self.dataSource = nil;
            self.dataSource = contacts;
            [self.tableView reloadData];
        }];
    }
    else {
        [self.refreshControl endRefreshing];
    }
}

#pragma mark - TableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    CContact *contact = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.phone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CDisplayViewController *displayVC = [CDisplayViewController new];
    [displayVC setContact:[self.dataSource objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:displayVC animated:YES];
}

- (void)addContact {
    CEditViewController *editViewController = [CEditViewController new];
    [self.navigationController pushViewController:editViewController animated:YES];
}

@end

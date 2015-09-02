//
//  PUSelectionTableViewController.m
//  ParseUser
//
//  Created by Ranjith on 25/11/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CSelectionTableViewController.h"
#import "CContact.h"
#import "CConstants.h"
#import "CAppDelegate.h"

#import "CServer.h"
#import "CServerInterface.h"

@interface CSelectionTableViewController (){
    NSMutableArray * selectedRows;
}
@end

@implementation CSelectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    selectedRows= [[NSMutableArray alloc]init];
    self.tableView.allowsMultipleSelection = YES;
}

- (void)viewDidUnload {
    selectedRows = nil;
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    CContact *contact = [self.contacts objectAtIndex:indexPath.row];
    cell.textLabel.text = [contact getFullName];
    if ([selectedRows indexOfObject:[self.contacts objectAtIndex:indexPath.row]] == NSNotFound ){
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([selectedRows indexOfObject:[self.contacts objectAtIndex:indexPath.row]] == NSNotFound ){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [selectedRows addObject:[self.contacts objectAtIndex:indexPath.row]];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [selectedRows removeObject:[self.contacts objectAtIndex:indexPath.row]];
    }
}

#pragma mark - Action API

- (IBAction)dismissVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareBtn:(id)sender {
    NSMutableArray *selectedPUContacts = [[NSMutableArray alloc]init];
    for(CContact *contact in selectedRows){
//        [selectedPUContacts addObject:contact.objectId];
    }
  //  [[CServer defaultParser] saveSharedContacts:selectedPUContacts :^(BOOL succedeed){
//        if(succedeed){
//    [[CServer defaultParser] currentUserObjectId:^(NSString *userObjectId){
//        if(userObjectId){
//        [[CServer defaultParser] findPFObjectwithObjectId:[[CServer defaultParser] userObjectId]
//                                                         :^(NSString *sharedClassObjectId,NSError *error){
//                                                             if(sharedClassObjectId){
//                                                                 [self pr_shareContact:sharedClassObjectId];
//                                                             }
//                                                                      }];
//                }
//    }];
   //     }
    //}];
}

#pragma mark - Private API

-(void)pr_shareContact:(NSString*)objectID{    
    NSString *finalString = [@"Contacts:" stringByAppendingString:[NSString stringWithFormat:@"%@%@",@"//multipleContacts/",objectID]];
    NSURL *customURL = [[NSURL alloc] initWithString:finalString];
    self.activityVC = [[CActivityViewController alloc] initWithURL:customURL];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.activityVC] applicationActivities:nil];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //iPhone, present activity view controller as is
        [self presentViewController:activityViewController animated:YES completion:nil];
    }
}

@end

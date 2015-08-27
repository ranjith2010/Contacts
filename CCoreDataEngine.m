//
//  PUCoreDataEngine.m
//  ParseUser
//
//  Created by Ran on 05/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CCoreDataEngine.h"

#import "CLocalInterface.h"
#import "CCoreDataSharedInstance.h"

#import "CUser.h"
#import "CContact.h"

#import "NSMutableDictionary+Additions.h"
#import "CUser+Additions.h"

#import "CConstants.h"

@implementation CCoreDataEngine{
   NSManagedObjectContext *moc;
}


+ (CCoreDataEngine*)sharedInstance {
    static CCoreDataEngine* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[CCoreDataEngine alloc] init];

    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    moc = [[CCoreDataSharedInstance sharedInstance] managedObjectContext];
    return self;
}


//
//
//#pragma mark - Public API
//
//
//
//- (void)deleteContact:(NSString*)contactObjectId :(void (^)(BOOL succedeed))block{
//    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
//    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CDContact" inManagedObjectContext:moc]];
//    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
//    NSError * error = nil;
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId=%@",contactObjectId];
//    [fetchRequest setPredicate:predicate];
//    NSArray * contactsObjects = [moc executeFetchRequest:fetchRequest error:&error];
//    CDContact *contact = contactsObjects.firstObject;
//    [moc deleteObject:contact];
//    if([moc save:&error]){
//        block(YES);
//        }
//    else{
//        block(NO);
//        }
//}
//
//
//- (BOOL)saveContact:(CContact*)contact error:(NSError **)error {
////- (CDContact *)saveContact:(CContact*)contactModel error:(NSError **)error {
//    CDContact *cdContact = [self getContactFromObjectId:contact.objectId error:error];
//    if(cdContact!=nil){
//        [self updateContactWithContactModel:contact toContact:cdContact error:error];
//    }
//    else {
//        // no contact with this object id, so create the new object id
//        cdContact = [NSEntityDescription insertNewObjectForEntityForName:@"CDContact" inManagedObjectContext:moc];
//        [self updateContactWithContactModel:contact toContact:cdContact error:error];
//    }
//    return [self saveCoreDataStateWithError:error];
//}
//
///*!
// This should be called to save any pending changes to disk.
// */
//- (BOOL)saveCoreDataStateWithError:(NSError**)error {
//    @synchronized(self) {
//        BOOL saved = [moc save:error];
//        return saved;
//    }
//}
//
//
//// read from the database
//- (CDContact *)getContactFromObjectId:(NSString *)objectId error:(NSError **)error {
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"CDContact"];
////    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:kCoreDataZipprKeyCreatedAt ascending:YES]];
//    request.predicate       = [NSPredicate predicateWithFormat:@"%K = %@",kServerObjectIdAttribute, objectId];
//    // execute the fetch request
//    // TODO: Should always have single recored for a objectId
//    NSArray *matches = [moc executeFetchRequest:request error:error];
//    if (matches && matches.count) {
//        return [matches firstObject];
//    }
//    return nil;
//
//}
//
//- (BOOL)updateContactWithContactModel:(CContact*)contactModel toContact:(CDContact*)cdContact error:(NSError**)error {
//    cdContact.objectId = contactModel.objectId;
//    cdContact.firstname = contactModel.firstname;
//    cdContact.lastname = contactModel.lastname;
//    cdContact.userObjectId = contactModel.userObjectId;
//    cdContact.email = [NSKeyedArchiver archivedDataWithRootObject:contactModel.email];
//    cdContact.phone = [NSKeyedArchiver archivedDataWithRootObject:contactModel.phone];
//    // dont save the data. Its done by caller.
//    return YES;
//}
//
//
//- (void)fetchCurrentUserContacts:(NSString*)userObjectId :(void(^)(NSArray *contacts))block {
//    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
//    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CDContact"
//                                        inManagedObjectContext:[[CCoreDataSharedInstance sharedInstance] managedObjectContext]]];
//    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
//    NSError *error = nil;
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userObjectId = %@",userObjectId];
////    [fetchRequest setPredicate:predicate];
//    NSArray *persistedContacts = [[[CCoreDataSharedInstance sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
//    if(persistedContacts && persistedContacts.count) {
//        NSMutableArray *userContacts = [NSMutableArray new];
//        for (CDContact *contact in persistedContacts) {
//            CContact *contactModel = [CContact new];
//            [contactModel setFirstname:contact.firstname];
//            [contactModel setLastname:contact.lastname];
//            [contactModel setEmail:[NSKeyedUnarchiver unarchiveObjectWithData:contact.email]];
//            [contactModel setPhone:[NSKeyedUnarchiver unarchiveObjectWithData:contact.phone]];
//            [contactModel setObjectId:contact.objectId];
//            [userContacts addObject:contactModel];
//        }
//     return block(userContacts);
//    }
//    block(nil);
//}
//
//
//
//
////- (void)updateAddressInfo:(CContact*)contact withAddress:(NSMutableDictionary *)addressInfo :(void (^)(BOOL, NSError *))block{
////    // Update into Contact.addressObjects -> Value
////    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
////    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CDContact"
////                                        inManagedObjectContext:[[CCoreDataSharedInstance sharedInstance] managedObjectContext]]];
////    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
////    NSError *error = nil;
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",contact.name];
////    [fetchRequest setPredicate:predicate];
////    NSArray *persistedContacts = [[[CCoreDataSharedInstance sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
////    CDContact *CDcontact = [persistedContacts firstObject];
////        [CDcontact setName:contact.name];
//////        [CDcontact setEmail:contact.email];
//////        [CDcontact setPhone:contact.phone];
////        NSMutableArray *addressObjects = [NSKeyedUnarchiver unarchiveObjectWithData:CDcontact.addressIdCollection];
////            NSMutableDictionary *addressInfoLocal = [addressObjects firstObject];
////        if(addressInfoLocal==nil){
////        // No Address dict
////        addressInfoLocal = [[NSMutableDictionary alloc]init];
////            [addressInfoLocal safeAddForKey:kServerTypeAttribute value:[addressInfo valueForKey:kServerTypeAttribute]];
////            [addressInfoLocal safeAddForKey:kServerStreetAttribute value:[addressInfo valueForKey:kServerStreetAttribute]];
////            [addressInfoLocal safeAddForKey:kServerDistrictAttribute value:[addressInfo valueForKey:kServerDistrictAttribute]];
////        }
////          else if([[addressInfoLocal valueForKey:kServerAddressId] isEqualToNumber:[addressInfo valueForKey:kServerAddressId]]){
////                [addressInfoLocal safeAddForKey:kServerTypeAttribute value:[addressInfo valueForKey:kServerTypeAttribute]];
////                [addressInfoLocal safeAddForKey:kServerStreetAttribute value:[addressInfo valueForKey:kServerStreetAttribute]];
////                [addressInfoLocal safeAddForKey:kServerDistrictAttribute value:[addressInfo valueForKey:kServerDistrictAttribute]];
////                }
////          else{
////              [addressInfoLocal safeAddForKey:kServerTypeAttribute value:[addressInfo valueForKey:kServerTypeAttribute]];
////              [addressInfoLocal safeAddForKey:kServerStreetAttribute value:[addressInfo valueForKey:kServerStreetAttribute]];
////              [addressInfoLocal safeAddForKey:kServerDistrictAttribute value:[addressInfo valueForKey:kServerDistrictAttribute]];
////          }
////    [CDcontact setAddressIdCollection:[NSKeyedArchiver archivedDataWithRootObject:[[NSMutableArray alloc] initWithObjects:addressInfoLocal, nil]]];
////    // Here it simply saving the 'Coredata Context'
////    if ([[[CCoreDataSharedInstance sharedInstance] managedObjectContext] save:&error] == NO) {
////        block(NO,error);
////    }
////    else{
////        block(YES,nil);
////    }
////}
////
////
//
//#pragma mark - Private methods
//
//
//
//// Fetch the Contacts info from Coredata
//
//-(void)fetchContacts :(NSString*)objectId :(void (^)(NSMutableArray *PUcontacts, NSError *error))block{
//    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
//    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CDContact"
//                                        inManagedObjectContext:[[CCoreDataSharedInstance sharedInstance] managedObjectContext]]];
//    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
//    NSError * error = nil;
//    if(objectId){
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId=%@",objectId];
//        [fetchRequest setPredicate:predicate];
//    }
//    NSArray * arrayOfContactsCDModel = [[[CCoreDataSharedInstance sharedInstance] managedObjectContext] executeFetchRequest:fetchRequest error:&error];
//    NSMutableArray *PUcontacts = [[NSMutableArray alloc]init];
//    for(CDContact *CDcontact in arrayOfContactsCDModel){
//        [PUcontacts addObject:[CDContact contactCDModelToCModel:CDcontact]];
//    }
//    block(PUcontacts,nil);
//}
//
//
////-(void)addMoreAddress:(NSMutableDictionary*)addressDictionary withContactName:(NSString*)whom WhichOperation:(NSString*)operation :(void(^)(BOOL succeeded, NSError *error))block{
////    NSFetchRequest * allContacts = [[NSFetchRequest alloc] init];
////    [allContacts setEntity:[NSEntityDescription entityForName:@"CDContact"
////                                       inManagedObjectContext:[[CCoreDataSharedInstance sharedInstance] managedObjectContext]]];
////    [allContacts setIncludesPropertyValues:NO]; //only fetch the managedObjectID
////    NSError * error = nil;
////    NSArray * contactsObjects = [[[CCoreDataSharedInstance sharedInstance] managedObjectContext] executeFetchRequest:allContacts error:&error];
////    for(CDContact *contact in contactsObjects){
////        if([contact.name isEqualToString:whom]){
////            NSMutableArray *existingAddress = [NSKeyedUnarchiver unarchiveObjectWithData:contact.addressIdCollection];
////            if([operation isEqualToString:@"Add"]){
////                [existingAddress addObject:addressDictionary];
////            }
////            else if ([operation isEqualToString:@"Edit"]){
////                NSMutableArray *toDeleteArray = [[NSMutableArray alloc]init];
////                for(NSMutableDictionary *dict in existingAddress){
////                    if([[dict valueForKey:kServerAddressId] isEqualToNumber:[addressDictionary valueForKey:kServerAddressId]]){
////                        [toDeleteArray addObject:dict];
////                    }
////                }
////                [existingAddress removeObjectsInArray:toDeleteArray];
////                [existingAddress addObject:addressDictionary];
////            }
////            else if ([operation isEqualToString:@"Delete"]){
////                NSMutableArray *toDeleteArray = [[NSMutableArray alloc]init];
////                for(NSMutableDictionary *dict in existingAddress){
////                    if([[dict valueForKey:kServerAddressId] isEqualToNumber:[addressDictionary valueForKey:kServerAddressId]]){
////                        [toDeleteArray addObject:dict];
////                    }
////                }
////                [existingAddress removeObjectsInArray:toDeleteArray];
////            }
////            [contact setAddressIdCollection:[NSKeyedArchiver archivedDataWithRootObject:existingAddress]];
////        }
////    }
////    
////    NSError *saveError = nil;
////    if([[[CCoreDataSharedInstance sharedInstance] managedObjectContext] save:&saveError]){
////        block(YES,nil);
////    }
////    else{
////        block(NO,error);
////    }
////}
//
//
//#pragma mark - Well written Functions
//
//
//- (BOOL)createNewUser:(CUser *)user {
//    NSEntityDescription *userEntityDesc = [NSEntityDescription entityForName:@"CDUser"
//                                                      inManagedObjectContext:moc];
//    CDUser *newUserCDModel = (CDUser*)[[NSManagedObject alloc] initWithEntity:userEntityDesc
//                                               insertIntoManagedObjectContext:moc];
//    newUserCDModel.username = user.username;
//    newUserCDModel.email = user.email;
//    newUserCDModel.password = user.password;
//    NSError *error = nil;
//    // Here it simply saving the 'Coredata Context'
//    if ([moc save:&error] == NO) {
//        return NO;
//    }
//    else{
//        return YES;
//    }
//}
//
//
///**!
// 
// @abstract Create a new user
// @param userName string value user entered into textField
// @param email string value user entered into textField
// @param password string value user entered into textField
// @param block
// */
//
//
//
//- (void)createNewUser:(NSString *)userName
//                email:(NSString *)email
//             password:(NSString *)password
//                     :(void (^)(BOOL succeeded, NSError *))block {
//    NSEntityDescription *userEntityDesc = [NSEntityDescription entityForName:@"CDUser"
//                                                      inManagedObjectContext:moc];
//    CDUser *newUser= (CDUser*)[[NSManagedObject alloc] initWithEntity:userEntityDesc
//                                               insertIntoManagedObjectContext:moc];
//    newUser.username = userName;
//    newUser.email = email;
//    newUser.password = password;
//    NSError *error = nil;
//    // Here it simply saving the 'Coredata Context'
//    if ([moc save:&error] == NO) {
//        block(NO,error);
//    }
//    else{
//        block(YES,error);
//    }
//}
//
//
//
//
//
//
////- (void)fetchAddress:(int)addressId : (void (^)(CAddress *address))block{
////    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
////    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CDAddress" inManagedObjectContext:moc]];
////    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
////    NSError * error = nil;
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"addressId=%d",addressId];
////    [fetchRequest setPredicate:predicate];
////    NSArray * arrayOfCDAddress = [moc executeFetchRequest:fetchRequest error:&error];
////    block([CDAddress CDAddressToCAddress:[arrayOfCDAddress firstObject]]);
////}
////
////- (void)saveContact:(CContact*)contact :(void (^)(BOOL succedeed))block{
////    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"CDContact"
////                                                  inManagedObjectContext:moc];
////    CDContact *newContact = (CDContact*)[[NSManagedObject alloc] initWithEntity:entityDesc insertIntoManagedObjectContext:moc];
////    [newContact setName:contact.name];
//////    [newContact setPhone:contact.phone];
//////    [newContact setEmail:contact.email];
////    [newContact setObjectId:contact.objectId];
////    [newContact setUserObjectId:contact.userObjectId];
////    [newContact setCduser:[self fetchCurrentUser:YES]];
//////    [newContact setAddressIdCollection:[NSKeyedArchiver archivedDataWithRootObject:contact.addressIdCollection]];
////    NSError *error = nil;
////    // Here it simply saving the 'Coredata Context'
////    if ([moc save:&error] == NO) {
////        block(NO);
////    }
////    else{
////        block(YES);
////    }
////}
////
////
////- (void)saveRecord:(CRecord *)record
////                  :(void(^)(BOOL succeedeed,NSError *error))block {
////    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"CDRecord"
////                                                  inManagedObjectContext:moc];
////    CDRecord *newRecord = (CDRecord*)[[NSManagedObject alloc] initWithEntity:entityDesc insertIntoManagedObjectContext:moc];
////    [newRecord setUserObjectId:record.userObjectId];
////    [newRecord setRecordId:record.recordId];
////    NSError *error = nil;
////    // Here it simply saving the 'Coredata Context'
////    if ([moc save:&error] == NO) {
////        block(NO,error);
////    }
////    else{
////        block(YES,error);
////    }
////}
////
////- (void)saveAddress:(CAddress*)address :(void (^)(BOOL succeed))block{
////    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"CDAddress"
////                                                  inManagedObjectContext:moc];
////    CDAddress *newAddress = (CDAddress*)[[NSManagedObject alloc]initWithEntity:entityDesc insertIntoManagedObjectContext:moc];
////    [newAddress setType:address.typeOfAddress];
////    [newAddress setStreet:address.street];
////    [newAddress setDistrict:address.district];
////    [newAddress setAddressId:[NSNumber numberWithInt:address.addressId]];
////    [newAddress setContactObjectId:address.contactObjectId];
////    [newAddress setCdcontact:[self pr_fetchContact:address.contactObjectId]];
////    NSError *error = nil;
////    if([moc save:&error] == NO){
////        block(NO);
////    }
////    else{
////        block(YES);
////    }
////}
////
////- (CDContact*)pr_fetchContact:(NSString*)contactObjectId{
////    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
////    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CDContact" inManagedObjectContext:moc]];
////    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
////    NSError * error = nil;
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId=%@",contactObjectId];
////    [fetchRequest setPredicate:predicate];
////    NSArray * arrayOfCDContacts = [moc executeFetchRequest:fetchRequest error:&error];
////    CDContact *cdContact = [arrayOfCDContacts firstObject];
////    return cdContact;
////}
////
////- (id)fetchCurrentUser:(BOOL)CDUserNeeded{
////    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
////    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CDUser" inManagedObjectContext:moc]];
////    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
////    NSError * error = nil;
////    NSArray *user = [moc executeFetchRequest:fetchRequest error:&error];
////    if(CDUserNeeded){
////        return [user firstObject];
////    }
////    else{
////      return [CUser CDUserToCUser:[user firstObject]];
////    }
////}
////
////- (void)editContact:(CContact*)contact :(void(^)(BOOL succeed))block{
////    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
////    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CDContact" inManagedObjectContext:moc]];
////    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
////    NSError * error = nil;
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId=%@",contact.objectId];
////    [fetchRequest setPredicate:predicate];
////    NSArray * arrayOfCDContacts = [moc executeFetchRequest:fetchRequest error:&error];
////    CDContact *cdContact = [arrayOfCDContacts firstObject];
////    [cdContact setName:contact.name];
//////    [cdContact setEmail:contact.email];
//////    [cdContact setPhone:contact.phone];
////    if([moc save:&error] == NO){
////        block(NO);
////    }
////    else{
////        block(YES);
////    }
////}
////
////- (void)editAddress:(CAddress*)address :(void(^)(BOOL succeed))block{
////    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
////    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CDAddress" inManagedObjectContext:moc]];
////    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
////    NSError * error = nil;
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"addressId=%d",address.addressId];
////    [fetchRequest setPredicate:predicate];
////    NSArray * arrayOfCDAddress = [moc executeFetchRequest:fetchRequest error:&error];
////    CDAddress *cdAddress = [arrayOfCDAddress firstObject];
////    [cdAddress setType:address.typeOfAddress];
////    [cdAddress setStreet:address.street];
////    [cdAddress setDistrict:address.district];
////    if([moc save:&error] == NO){
////        block(NO);
////    }
////    else{
////        block(YES);
////    }
////}
//
////- (void)affectAddressIdinContact:(NSString*)contactObjectId withAddressId:(int)addressId :(void (^)(BOOL succeed))block{
////    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
////    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CDContact" inManagedObjectContext:moc]];
////    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
////    NSError * error = nil;
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId=%@",contactObjectId];
////    [fetchRequest setPredicate:predicate];
////    NSArray * arrayOfCDContacts = [moc executeFetchRequest:fetchRequest error:&error];
////    CDContact *cdContact = [arrayOfCDContacts firstObject];
////    if(cdContact){
////        NSMutableArray *arrayOfAddressId = [NSKeyedUnarchiver unarchiveObjectWithData:cdContact.addressIdCollection];
////        if(arrayOfAddressId.count){
////            [arrayOfAddressId addObject:[NSNumber numberWithInt:addressId]];
////            if([moc save:&error] == NO){
////                block(NO);
////            }
////            else{
////                block(YES);
////            }
////        }
////    }
////}
//
////- (void)deleteAddress:(int)addressId :(void(^)(BOOL succeed))block{
////    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
////    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CDAddress" inManagedObjectContext:moc]];
////    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
////    NSError * error = nil;
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"addressId=%d",addressId];
////    [fetchRequest setPredicate:predicate];
////    NSArray * arrayOfCDAddress = [moc executeFetchRequest:fetchRequest error:&error];
////    CDAddress *cdAddress = [arrayOfCDAddress firstObject];
////    [moc deleteObject:cdAddress];
////    if([moc save:&error] == NO){
////        block(NO);
////    }
////    else{
////        block(YES);
////    }
////}
//
////- (void)removeAddressIdinContact:(NSString*)contactObjectId withAddressId:(int)addressId :(void (^)(BOOL succeed))block{
////    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
////    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CDContact" inManagedObjectContext:moc]];
////    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
////    NSError * error = nil;
////    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId=%@",contactObjectId];
////    [fetchRequest setPredicate:predicate];
////    NSArray * arrayOfCDContacts = [moc executeFetchRequest:fetchRequest error:&error];
////    CDContact *cdContact = [arrayOfCDContacts firstObject];
////    if(cdContact){
////        NSMutableArray *arrayOfAddressId = [NSKeyedUnarchiver unarchiveObjectWithData:cdContact.addressIdCollection];
////        if(arrayOfAddressId.count){
////            [arrayOfAddressId removeObject:[NSNumber numberWithInt:addressId]];
////            if([moc save:&error] == NO){
////                block(NO);
////            }
////            else{
////                block(YES);
////            }
////        }
////    }
////
////}
//
//
//- (void)logout:(void (^)(BOOL succedeed))block{
//    NSError *error = nil;
//    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"CDUser"];
//    NSArray *userObjects = [[[CCoreDataSharedInstance sharedInstance] managedObjectContext] executeFetchRequest:request error:&error];
//    if(userObjects.count){
//        [moc deleteObject:[userObjects firstObject]];
//        if([moc save:&error]){
//            block(YES);
//        }
//        else{
//            block(NO);
//        }
//    }
//}
//
//
//- (void)flushAllContacts:(NSString*)userObjectId :(void (^)(BOOL succedeed))block{
//    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
//    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CDContact"
//                                        inManagedObjectContext:[[CCoreDataSharedInstance sharedInstance] managedObjectContext]]];
//    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
//    NSError * error = nil;
//    NSArray * CDcontacts = [moc executeFetchRequest:fetchRequest error:&error];
//    for (NSManagedObject * contact in CDcontacts) {
//        if([[contact valueForKey:kServerUserObjectIdAttribute]isEqualToString:userObjectId]){
//            [[[CCoreDataSharedInstance sharedInstance] managedObjectContext] deleteObject:contact];
//        }
//    }
//    NSError *saveError = nil;
//    if([[[CCoreDataSharedInstance sharedInstance] managedObjectContext] save:&saveError]){
//        block(YES);
//    }
//    else{
//        block(NO);
//    }
//}
//
//*/

@end

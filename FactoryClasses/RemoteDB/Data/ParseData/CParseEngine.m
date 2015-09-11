//
//  ParseEngine.m
//  ParseUser
//
//  Created by Ranjith on 03/12/14.
//  Copyright (c) 2014 Zippr. All rights reserved.
//

#import "CParseEngine.h"
#import "CConstants.h"
#import "CContact.h"
#import "NSMutableDictionary+Additions.h"
#import "PFObject+Additions.h"
#import "CUser.h"
#import "CServer.h"
#import "CServerInterface.h"
#import "CServerUserInterface.h"
#import "CServerUser.h"

#pragma mark - Cloud Functions

NSString *storeContactCloudFunction = @"storeContact";
NSString *shareContactCloudFunction = @"storeSharedContact";

@interface CParseEngine ()
@property (nonatomic)id<CServerUserInterface> serverUser;
@end

@implementation CParseEngine

+ (CParseEngine*)sharedInstance {
    static CParseEngine* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[CParseEngine alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    self.serverUser = [CServerUser defaultUser];
    return self;
}

- (void)initialize {
    [Parse setApplicationId:kServerApplicationId clientKey:kServerClientKey];
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicWriteAccess:NO];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
}

- (void)storeContact:(CContact *)contact :(storeContactCompletionBlock)block {
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[kServerUserObjectIdAttr] = [self.serverUser userObjectId];
    [params safeAddForKey:kServerNameAttr value:contact.name];
    [params safeAddForKey:kServerEmailAttr value:contact.email];
    [params safeAddForKey:kServerPhoneAttr value:contact.phone];
    [params safeAddForKey:kServerStreetAttr value:contact.street];
    [params safeAddForKey:kServerDistrictAttr value:contact.district];

    [PFCloud callFunctionInBackground:storeContactCloudFunction
                       withParameters:params
                                block:^(id object, NSError *error) {
        PFObject *pfObject = object;
        if (object) {
            NSLog(@"contact Objectid: %@", pfObject.objectId);
            CContact *contact = [pfObject contact];
            block(contact,nil);

        } else {
            block(nil, error);
        }
      }];
}

- (void)readAllContacts:(readAllContactsCompletionBlock)block {
    PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
    [query whereKey:kServerUserObjectIdAttr equalTo:[self.serverUser userObjectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray * __nullable objects, NSError * __nullable error) {
        if(objects && objects.count) {
            NSMutableArray *arrayOfContacts = [NSMutableArray new];
            for(PFObject *pfObject in objects) {
                [arrayOfContacts addObject:[pfObject contact]];
            }
            block(arrayOfContacts,nil);
        }
        else {
            block(nil,error);
        }
    }];
}

- (void)deleteContact:(CContact *)contact :(deleteContactCompletionBlock)block {
    NSError *error;
    PFObject *object = [PFQuery getObjectOfClass:kServerContactClassName objectId:contact.objectId error:&error];
    BOOL result = [object delete:&error];
    block(result,error);
}

- (void)updateContact:(CContact*)contact :(updatContactCompletionBlock)block {
    NSError *error;
    PFObject *object = [PFQuery getObjectOfClass:kServerContactClassName
                                        objectId:contact.objectId error:&error];
    if(object) {
        [object c_safeAddKey:kServerNameAttr value:contact.name];
        [object setObject:[self.serverUser userObjectId] forKey:kServerUserObjectIdAttr];
        [object c_safeAddKey:kServerPhoneAttr value:contact.phone];
        [object c_safeAddKey:kServerEmailAttr value:contact.email];
        [object c_safeAddKey:kServerStreetAttr value:contact.street];
        [object c_safeAddKey:kServerDistrictAttr value:contact.district];
        [object saveInBackgroundWithBlock:block];
    }
    else {
        block(nil,error);
    }
}

- (void)storeShareArray:(NSArray *)objectIdCollection :(storeSharedArray)block {
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[kServerUserObjectIdAttr] = [self.serverUser userObjectId];
    params[kServerShareCollection] = objectIdCollection;
    [PFCloud callFunctionInBackground:shareContactCloudFunction
                       withParameters:params
                                block:^(id object, NSError *error) {
    PFObject *pfObject = object;
    if (object) {
        NSLog(@"%@", pfObject.objectId);
        block(pfObject.objectId, nil);
    } else {
        block(nil, error);
    }
    }];
}


- (void)fetchSharedContacts:(NSURL *)sharedURL :(fetchSharedContactsCompletionBlock)block {
    // This case is individual contacts. like 1 or multiple contacts
    // So we are making an array and sharing to someone
    if (sharedURL){
        NSString *myString = [sharedURL absoluteString];
        NSArray *items = [myString componentsSeparatedByString:@"/"];
        if([items[2] isEqualToString:@"multipleContacts"]){
            PFQuery *query = [PFQuery queryWithClassName:kServerSharedContactsClassName];
            [query whereKey:kServerObjectIdAttr equalTo:items[3]];
            [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
                if(!error && pfObjects.count){
                    NSArray *collection = pfObjects.firstObject[kServerShareCollection];
                    for(NSString *objectid in collection){
                        NSError *error;
                        PFObject *object = [PFQuery getObjectOfClass:kServerContactClassName
                                                            objectId:objectid error:&error];
                        if(object) {
                            [self storeContact:[object contact] :^(CContact *contact, NSError *error) {

                            }];
                        }
                    }
                }
            }];
        }
        else{
            // the following code to share all the contacts
            // So here we sending the userobjectId to someOne
            PFQuery *query = [PFQuery queryWithClassName:kServerContactClassName];
            if([items[2] isEqualToString:kServerUserObjectIdAttr]){
                [query whereKey:kServerUserObjectIdAttr equalTo:items[3]];
            }
            else{
                [query whereKey:kServerObjectIdAttr equalTo:items[3]];
            }
            [query findObjectsInBackgroundWithBlock:^(NSArray *pfObjects,NSError *error){
                if(!error && pfObjects.count){
                    for(PFObject *object in pfObjects){
                        if(object) {
                            [self storeContact:[object contact] :^(CContact *contact, NSError *error) {
                                
                            }];
                        }
                    }
                }
            }];
        }
    }
}

@end

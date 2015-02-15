//
//  AllInformationSharedStore.h
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 07.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface AllInformationSharedStore : NSObject

@property (nonatomic, strong) NSMutableArray *allInformationArray;

// Core Data properties
@property (nonatomic, strong) NSManagedObjectContext *managedContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;

+ (AllInformationSharedStore *)sharedStore;

// The path used by Core data
- (NSString *)allInformationArchievePath;

- (BOOL)saveChanges;

- (void)loadAllInformation;

@end
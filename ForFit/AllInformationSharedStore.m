//
//  AllInformationSharedStore.m
//  ForFit
//
//  Created by Gaydashevskiy Mikhail on 07.01.15.
//  Copyright (c) 2015 Gaydashevskiy Mikhail. All rights reserved.
//

#import "AllInformationSharedStore.h"

@implementation AllInformationSharedStore

+ (AllInformationSharedStore *)sharedStore
{
    static AllInformationSharedStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil]init];
    }
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Creating a managed object model from ForFit.xcdatamodeld
        self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        // Creating a persistent store coordinator with a path and persistent store type (NSSQLiteStoreType)
        NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managedObjectModel];
        NSString *pathString = [self allInformationArchievePath];
        NSURL *URL = [NSURL fileURLWithPath:pathString];
        NSError *error = nil;
        if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:URL options:nil error:&error]) {
            [NSException raise:@"Open failed" format:@"Reason: %@", error.localizedDescription];
        }
        
        // Creating a managed object context
        self.managedContext = [[NSManagedObjectContext alloc]init];
        self.managedContext.persistentStoreCoordinator = persistentStoreCoordinator;
        // There is no need in undo support
        self.managedContext.undoManager = nil;
        
        // Load all information
        [self loadAllInformation];
    }
    return self;
}


#pragma mark - My methods
- (NSString *)allInformationArchievePath
{
    NSArray *documentDirectoriesArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Getting a document directory
    NSString *documentDirectoryString = [documentDirectoriesArray objectAtIndex:0];
    
    return [documentDirectoryString stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges
{
    NSError *error = nil;
    BOOL successfullySaved = [self.managedContext save:&error];
    if (!successfullySaved) {
        NSLog(@"Error saving: %@", error.localizedDescription);
    }
    return successfullySaved;
}

- (void)loadAllInformation
{
    if (!self.allInformationArray) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"OneDayInformation"];
        
        // Ordering
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:NO];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        
        NSError *error = nil;
        NSArray *resultArray = [self.managedContext executeFetchRequest:fetchRequest error:&error];
        if (!resultArray) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", error.localizedDescription];
        }
        self.allInformationArray = [[NSMutableArray alloc]initWithArray:resultArray];
    }
}

@end
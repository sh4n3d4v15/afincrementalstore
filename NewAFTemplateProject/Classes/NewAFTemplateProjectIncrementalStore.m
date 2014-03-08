#import "NewAFTemplateProjectIncrementalStore.h"
#import "NewAFTemplateProjectAPIClient.h"

@implementation NewAFTemplateProjectIncrementalStore

+ (void)initialize {
    [NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[self type]];
}

+ (NSString *)type {
    return NSStringFromClass(self);
}

+ (NSManagedObjectModel *)model {
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"NewAFTemplateProject" withExtension:@"xcdatamodeld"]];
}

- (id <AFIncrementalStoreHTTPClient>)HTTPClient {
    return [NewAFTemplateProjectAPIClient sharedClient];
}

@end
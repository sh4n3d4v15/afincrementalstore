#import "NewAFTemplateProjectAPIClient.h"
#import "AFJSONRequestOperation.h"

//static NSString * const kNewAFTemplateProjectAPIBaseURLString = @"http://chepserver.eu01.aws.af.cm";
static NSString * const kNewAFTemplateProjectAPIBaseURLString = @"http://127.0.0.1:5000";
@implementation NewAFTemplateProjectAPIClient

+ (instancetype)sharedClient {
    static NewAFTemplateProjectAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kNewAFTemplateProjectAPIBaseURLString]];
    });
    
    return _sharedClient;
}



- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    __block NewAFTemplateProjectAPIClient *that = self;
    [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"changed %d", status);
        BOOL isReachable = (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN);
        
        NSLog(@"Network Status: %@", (isReachable) ? @"Online" : @"Offline");
        
        [[that operationQueue] setSuspended:!isReachable];
    
            //[[NSNotificationCenter defaultCenter]postNotificationName:@"didBecomeOnlineNotifcation" object:nil];
    }];
    
    
    return self;
}

#pragma mark - AFIncrementalStore

- (id)representationOrArrayOfRepresentationsFromResponseObject:(id)responseObject {
    return responseObject;
}

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation 
                                     ofEntity:(NSEntityDescription *)entity 
                                 fromResponse:(NSHTTPURLResponse *)response 
{
    NSMutableDictionary *mutablePropertyValues = [[super attributesForRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];
    
    // Customize the response object to fit the expected attribute keys and values
    if ([entity.name isEqualToString:@"Load"]) {
        NSNumber *id = [representation objectForKey:@"id"];
        [mutablePropertyValues setValue:id forKey:@"id"];
    }
    
    return mutablePropertyValues;
}

- (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID *)objectID
                                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

- (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription *)relationship
                               forObjectWithID:(NSManagedObjectID *)objectID
                        inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

@end

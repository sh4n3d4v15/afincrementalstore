#import "AFIncrementalStore.h"
#import "AFRestClient.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface NewAFTemplateProjectAPIClient : AFRESTClient <AFIncrementalStoreHTTPClient>

+ (NewAFTemplateProjectAPIClient *)sharedClient;

@end

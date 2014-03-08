#import "AFIncrementalStore.h"
#import "AFRestClient.h"

@interface NewAFTemplateProjectAPIClient : AFRESTClient <AFIncrementalStoreHTTPClient>

+ (NewAFTemplateProjectAPIClient *)sharedClient;

@end

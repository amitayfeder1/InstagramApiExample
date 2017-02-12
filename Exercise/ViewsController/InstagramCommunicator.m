//
//  InstagramCommunicator.m
//

#import "InstagramCommunicator.h"
#import "InstagramCommunicatorDelegate.h"

@implementation InstagramCommunicator
@synthesize access_token;

//Search Tag
-(void) searchAndHandleTags:(NSString*)searchText
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    NSString* request = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/search?q=%@&access_token=%@",searchText,access_token];
    NSURL * url = [NSURL URLWithString:request];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if (error) {
                                                            [self.delegate fetchingTagsFailedWithError:error];
                                                        } else {
                                                            [self.delegate receivedTagsJSON:data];
                                                        }
                                                    }];
    [dataTask resume];
}

//Search Location
-(void) searchAndHandleLocations:(CLLocationCoordinate2D)coordinate
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    NSString* location = [NSString stringWithFormat:@"lat=%f&lng=%f",coordinate.latitude, coordinate.longitude];
    NSString* request = [NSString stringWithFormat:@"https:api.instagram.com/v1/locations/search?%@&access_token=%@",location,access_token];
    NSURL * url = [NSURL URLWithString:request];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if (error) {
                                                            [self.delegate fetchingLocationsFailedWithError:error];
                                                        } else {
                                                            [self.delegate receivedLocationsJSON:data];
                                                        }
                                                    }];
    [dataTask resume];
}

//Search Media
-(void) searchAndHandleMedia:(NSString*)request
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    NSURL * url = [NSURL URLWithString:request];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if (error) {
                                                            [self.delegate fetchingMediasFailedWithError:error];
                                                        } else {
                                                            [self.delegate receivedMediasJSON:data];
                                                        }
                                                    }];
    
    [dataTask resume];
}

-(void) searchRecentUserMedia
{
    NSString* request = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@",access_token];
    [self searchAndHandleMedia:request];
}

-(void) searchMediaFromTag:(NSString*)searchTag
{
    NSString* request = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?access_token=%@",searchTag,access_token];
    [self searchAndHandleMedia:request];
}

-(void) searchMediaByLocationId:(NSString*)locationId
{
    NSString* request = [NSString stringWithFormat:@"https://api.instagram.com/v1/locations/%@/media/recent?access_token=%@",locationId,access_token];
    [self searchAndHandleMedia:request];
}

//Set like and like (POST)
-(void) likeOrUnlikeMedia:(NSString*)mediaId andLike:(BOOL)like{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSString* request = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/%@/likes?access_token=%@",mediaId,access_token];
    NSURL * url = [NSURL URLWithString:request];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    if (like)
    {
        [urlRequest setHTTPMethod:@"POST"];
    }
    else
    {
        [urlRequest setHTTPMethod:@"DELETE"];
    }
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest];
    [dataTask resume];
}
@end

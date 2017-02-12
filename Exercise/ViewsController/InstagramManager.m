//
//  InstagramManager.m
//

#import "InstagramParser.h"
#import "InstagramCommunicator.h"
#import "InstagramManager.h"
#import "TagDetails.h"
#import "LocationDetails.h"

@implementation InstagramManager
-(void) fetchRecentUserMedia
{
    [self.communicator searchRecentUserMedia];
}
-(void) fetchMediaFromTag:(NSString*)searchTag
{
    [self.communicator searchAndHandleTags:searchTag];
}
-(void) fetchMediaByLocation:(CLLocationCoordinate2D)coordinate
{
    [self.communicator searchAndHandleLocations:coordinate];
}
-(void) likeOrUnlikeMedia:(NSString*)mediaId andLike:(BOOL)like
{
    [self.communicator likeOrUnlikeMedia:mediaId andLike:like];
}

#pragma mark - InstagramCommunicatorDelegate

- (void)receivedMediasJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *medias = [InstagramParser mediaFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingMediasFailedWithError:error];
        
    } else {
        [self.delegate didReceiveMedias:medias];
    }
}

- (void)fetchingMediasFailedWithError:(NSError *)error
{
    [self.delegate fetchingMediasFailedWithError:error];
}

- (void)receivedTagsJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *tags = [InstagramParser tagFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingMediasFailedWithError:error];
    } else if (tags.count == 0) {
        NSLog(@"No tags found");
    }
    else {
        TagDetails* tag = [tags firstObject];
        [self.communicator searchMediaFromTag:tag.name];
    }
}

-(void) fetchingTagsFailedWithError:(NSError *)error
{
    [self.delegate fetchingMediasFailedWithError:error];
}

- (void)receivedLocationsJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *locations = [InstagramParser locationsFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingMediasFailedWithError:error];
    } else if (locations.count == 0) {
        NSLog(@"No locations found");
    }
    else {
        LocationDetails* loc = [locations firstObject];
        [self.communicator searchMediaByLocationId:loc.identifier];
    }
}

-(void) fetchingLocationsFailedWithError:(NSError *)error
{
      [self.delegate fetchingMediasFailedWithError:error];
}

@end
